#### 首先
将mysql 驱动包 准备好 目前使用（mysql-connector-java-5.1.47.jar）
#### 之后
准备好jdbc.conf 文件放到配置文件配置的文件夹中 （pipline）

#### jdbc 基本格式
```
#输入
input{
  #标准输入
  stdin {
   }
   jdbc{

   }
}
#输出
output{
  #标准输出
  stdout {

      # JSON格式输出

      codec => json_lines

  }
}
```
