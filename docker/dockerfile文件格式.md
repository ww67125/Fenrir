#### tomcatdockerfile 格式示例
```
#基于哪个基础镜像构建
FROM tomcat:9.0.35-jdk8
#构建镜像时执行的命令（一个run是一层镜像，不建议写多个run，可以按以下形式把命令写在一起）
RUN apt -y  update && apt install -y  python-pip && apt install -y  default-mysql-client \
&& python -m pip install --upgrade pip  \
&& pip install requests \
&& pip install xlrd \
&& pip install xlwt \
&& pip install ipython \
&& pip install openpyxl \
&& pip install --upgrade lxml \
&& pip install docx \
&& pip install bs4 \
&& pip install DBUtils
#将dockerfile所在目录里的文件复制到镜像指定目录中
COPY import_data.sh /root
COPY server.xml /usr/local/tomcat/conf

```
#### mysqldockerfile 格式示例
```
FROM mysql:5.7
COPY my.cnf /etc/mysql/
#将需要在构建镜像时初始化的sql放在此目录，构建时自动执行
COPY back_data.sql /docker-entrypoint-initdb.d
#ENV  MYSQL_ROOT_PASSWORD=root
RUN chmod a+x /docker-entrypoint-initdb.d/back_data.sql
```
