#### 创建索引
```
PUT http://127.0.0.1:9200/indexName
{
	"settings": {
    #分片大小（默认5）（是指文档会被分成几份，如果是集群就会自动分布到各个节点）
		"number_of_shards": 3,
    #副本大小（默认1）（备份）
		"number_of_replicas": 2
	},
  #映射字段
	"mapping": {
    #type
		"_doc": {
			"properties": {
        #字段名称
				"commodity_id": {
          #字段类型
					"type": "long"
				},
				"commodity_name": {
					"type": "text"
				},
				"picture_url": {
					"type": "keyword"
				},
				"price": {
					"type": "double"
				}
			}
		}
	}
}
```
创建成功返回
```
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "indexName"
}
```
常用字段类型
类型 | 标识
--| -- | --
字符类型  |   |
字符串类型  |  string,text,keyword
整数类型   |integer,long,short,byte
浮点类型   | double,float,half_float,scaled_float
逻辑类型   | boolean
日期类型   | date
范围类型   | range
二进制类型  |  binary
复合类型    |
数组类型 |   array
对象类型   | object
嵌套类型   | nested
地理类型    |
地理坐标类型  |  geo_point
地理地图   | geo_shape
特殊类型   |
IP类型 |   ip
范围类型  |  completion
令牌计数类型 |   token_count
附件类型   | attachment
抽取类型   | percolator

#### 查询操作
1. 使用restful接口简单查询
`GET /indexName/typeName/_search?q=name:zhangsan&sort=age:desc`
q是query
2. 使用DSL进行高级查询（Domain Sepcified Language）
   请求接口`GET /indexName/typeName/_search` 传输payload
     1. **query结构体内**
         1. match
         标准的全文检索，会对查询关键字分词，可以指定分词器
         ```
              {
              "query": {
                "match": {
                  "name": {
                    "query": "超级羽绒服",
                    "analyzer": "ik_smart"
                  }
                }
              }
            }
         ```
         2. match_phrase
         搜索关键字分词后依旧相邻的所有数据，slop可以指定分词之后相邻的最大距离，可以指定分词器
         ```
               {
              "query": {
                "match_phrase": {
                  "name": {
                    "query": "超级羽绒服",
                    "analyzer": "ik_smart",
                    "slop": 2
                  }
                }
              }
            }
         ```
         3. term
        不进行分词，精准匹配文档
            `"term": {"title": "东北贵族大米"}`
        4. terms
        多个terms匹配
        `"terms": {"title": ["苏泊尔","小米"]}`
        5. exists
        匹配存在指定字段的文档，字段值为null或[],mapping设置index：false，长度超过ignore_above限制，字段值奇奇怪怪时匹配不到
      `  "exists": {"field": "name"}`
        6. range
          按term匹配范围内的数据

            ```     {
                "range" : {
                 "age" : {
                     "gte" : "2019-12-10",
                     "lte" : "2020-11-11",
                     "format" : "yyyy-MM-dd"
                 }
             }
             ```
          7. ids
          根据文档id查询
        `
          "ids" : {
            "values" : ["1", "4", "100"]
        }
          `
          8. bool
          将query组合查询must=and，must_not是不等于，should=or
          ```
                  {
        "query": {
          "bool": {
            "must": [
              {
                "match": {
                  "name": "花花公子羽绒服"
                }
              }
            ],
            "must_not": [
              {
                "term": {
                  "proId": 6
                }
              }
            ],
            "should": [
              {
                "terms": {
                  "name.keyword": ["花花公子暖心羽绒服", "花花公子外套"]
                }
              }
            ]}
           }
          }
          ```

   3.**Filter结构体内**
   只筛选符合的文档，不计分，可以缓存，实际使用与query结构内一样
   4.**sort结构体内**
   对字段进行排序
   ```
       {
       "query":{
             "match":{
                       "name":"zhangsan"
             }
       },
       "sort":[
           {
                "age":"desc"
          }
      ]
    }
   ```
   5. **分页操作**
   ```
         {
          "query":{"match_all":{}},
          "from":1,
          "size":2
      }
   ```
   6. **返回指定字段**
   ```
       {
        "query":{"match_all":{}},
        "_source":["name","age"]
    }
   ```
   7. **高亮查询**
   ```
       {
         "query":{
               "match_phrase":{
                       "name":"zhangsan"
                 }
         } ,
        "highlight":{
                   "fields":{
                         "name":{}
                    }
        }
     }
   ```
