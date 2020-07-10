#### 添加依赖
springboot pom文件增加maven配置
es版本需要对应
```
<dependency>
          <groupId>org.springframework.boot</groupId>
          <artifactId>spring-boot-starter-data-elasticsearch</artifactId>
</dependency>
```
#### 配置application.yml
```
spring:
  data:
      elasticsearch:
        #集群名称
        cluster-name: elasticsearch
        #集群节点（9300端口）
        cluster-nodes: 144.34.194.36:9300
        repositories:
          enabled: true
```
```
#关闭心跳检测
management:
  health:
    elasticsearch:
      enabled: false
```
#### 配合JPA使用
1. 导入jpa依赖
```
<dependency>
         <groupId>org.springframework.boot</groupId>
         <artifactId>spring-boot-starter-data-jpa</artifactId>
</dependency>
```
2. 一个实体对应一个索引
实体类上添加`@Document(indexName = "file_content", type = "spu")`标签 ，`indexName`为索引名称，`type`类似表名，新版已弃用
3. 使用jpa查询
jpa接口继承`ElasticsearchRepository<FileContentES, Integer>`
例：
```
public interface FileContentESRepository extends ElasticsearchRepository<FileContentES, Integer> {
    Page<FileContentEntity> findByContentAndGbkFilePathAndHostIdAndType(String content, String path, Integer hostId, String type, Pageable pageable);
    Page<FileContentEntity> findByContentAndHostId(String Content,Integer hostId, Pageable pageable);
    Page<FileContentEntity> findByContent(String content,Pageable pageable);
    List<FileContentEntity> findByContent(String content);
    List<FileContentEntity> findByHostId(Integer hostId);
}
```
4.使用querybuilder进行高级查询
  1. 构建querybuilder
      query类型  |用途   |
      --|---|--
      matchQuery  | 正常打分匹配   |
      fuzzyQuery  | 模糊匹配  |
      termQuery | 完全匹配 |
      boolQuery  | 组和匹配 should=or,must=and |
  例：
  ```
  private QueryBuilder getquerybuider(FileContentEntity fileContentEntity,List<Integer> hostids){
    //获取QueryBuilder
    QueryBuilder queryBuilder = QueryBuilders.boolQuery();
    if (hostids != null && hostids.size() > 0){
        for (int i : hostids) {
            ((BoolQueryBuilder) queryBuilder).must(QueryBuilders.termsQuery("host_id",hostids));
        }
    }
    if (fileContentEntity.getHostId()!=null){
        ((BoolQueryBuilder) queryBuilder).must(QueryBuilders.termQuery("host_id",fileContentEntity.getHostId()));
    }
    if (!StringUtils.isEmpty(fileContentEntity.getType())){
        String type=fileContentEntity.getType();

        if (type.contains("|")) {
            BoolQueryBuilder q2=QueryBuilders.boolQuery();
            for (String s : type.split("\\|")) {
                q2.should(QueryBuilders.matchQuery("gbk_file_path",s));
            }
            ((BoolQueryBuilder) queryBuilder).must(q2);
        } else if (type != null && type.length() > 2) {
            ((BoolQueryBuilder) queryBuilder).must(QueryBuilders.matchQuery("gbk_file_path",type));
        } else {
            ((BoolQueryBuilder) queryBuilder).must(QueryBuilders.fuzzyQuery("type",type));
        }
   /*     if (!StringUtils.isEmpty(fileContentEntity.getGbkFilePath())){
            ((BoolQueryBuilder) queryBuilder).must(QueryBuilders.fuzzyQuery("gbk_file_path",fileContentEntity.getGbkFilePath()));
        }*/
    }
 /*   if (!StringUtils.isEmpty(fileContentEntity.getGbkFilePath())){



        ((BoolQueryBuilder) queryBuilder).should(QueryBuilders.fuzzyQuery("gbk_file_path",fileContentEntity.getGbkFilePath()));
    }*/
    if (!StringUtils.isEmpty(fileContentEntity.getContent())){
        BoolQueryBuilder q2=QueryBuilders.boolQuery();
        q2.should(QueryBuilders.matchQuery("gbk_file_path",fileContentEntity.getGbkFilePath()));
        q2.should(QueryBuilders.fuzzyQuery("content",fileContentEntity.getContent()));
        ((BoolQueryBuilder) queryBuilder).must(q2);
    }
    return queryBuilder;
}
  ```
  2. 构建searchQuery
     `withQuery` 匹配目标
     `withPageable` 进行分页
     `withFields` 返回的字段
     `withFilter` 进行过滤
  例：

    SearchQuery searchQuery = new NativeSearchQueryBuilder() //2
             .withQuery(queryBuilder) // 3
             .withPageable(pageable)
             .withFields("id")//4
             .withFilter(filterBuilder)
             .build(); //5

  3. 最后使用 repository.search(searchQuery)查询
