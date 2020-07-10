1. 查询集群健康状态
`GET /_cat/health?v&pretty`
2. 查询节点状态
`GET /_cat/nodes?v`
3. 查看index的信息
`GET /indexName?pretty`
4. 查询所有存在的index
`GET /_cat/indices?v&pretty`
5. 创建索引
` PUT /indexName`
6. 删除索引
` DELETE /indexName`
7. 删除多个
`DELETE /index_one,index_two`
`DELETE /index_*`
`DELETE /_all`
8. 添加数据
`PUT /indexName/typeName/id(可以是任意字符串或数字，不写会随机生成) `即使没有index也会自动创建
```
$ curl -X PUT 'localhost:9200/accounts/person/1' -d '
{
  "user": "张三",
  "title": "工程师",
  "desc": "数据库管理"
}'
```
9. 查看记录
`GET /accounts/person/id?pretty`
10. 删除记录
`DELETE  /accounts/person/id `
11. 更新记录
如同创建记录，只要id相同就会更新
