#### yml文件示例
```
#文件格式版本，根据docker版本可以在官方文档查询 [版本查询地址](https://docs.docker.com/compose/compose-file/)
version: '3.8'
services:
  # 指定服务名称
  db:
    #指定使用dockerfile构建 以下使用的dockerfile所在目录
    build: ./mysqldockerfile/
    # 指定服务使用的镜像
    image: mysql:mycnf
    # 指定容器名称
    container_name: mysql
    # 指定服务运行的端口
    ports:
      - 3306:3306
    # 指定容器中需要挂载的文件
    volumes:
    #  - /root/dockertest/mydata/mysql/log:/var/log/mysql
      - /root/dockertest/mydata/mysql/data:/var/lib/mysql
    #  - /root/dockertest/mydata/mysql/conf:/etc/mysql
      - /etc/localtime:/etc/localtime
    # 指定容器的环境变量
    environment:
      - MYSQL_ROOT_PASSWORD=root
  # 指定服务名称
  tomcat:
    build: ./tomcatdockerfile/
    # 指定服务使用的镜像
    image: tomcat:python
    # 指定容器名称
    container_name: tomcat
    #依赖启动 先启动依赖服务
    depends_on:
      - db
    # 指定服务运行的端口
    ports:
      - 8080:6577
      - 8081:8081
    # 指定容器中需要挂载的文件
    volumes:
      - /etc/localtime:/etc/localtime
     # - /root/dockertest/mydata/tomcat/logs:/usr/local/tomcat/logs
      - /root/dockertest/mydata/tomcat/log:/usr/local/tomcat/log
     # - /root/dockertest/mydata/tomcat/conf:/usr/local/tomcat/conf
      - /root/dockertest/mydata/tomcat/webapps:/usr/local/tomcat/webapps
      - /home/john/data/fzzx/raw_data:/usr/local/tomcat/dataapps/ROOT/data
      - /home/john:/home/john
      - /root/dockertest/updata:/root/updata
    #可以使用服务名连接其他服务（就是在/etc/hosts文件里添加了别的机器的地址）
    links:
      - db


```
