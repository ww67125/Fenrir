##### 如何在构建镜像时导入sql
官方提供了 /docker-entrypoint-initdb.d 目录来执行初始化sql文件
将文件复制到此处赋予可执行权限自动执行

##### docker-compose相关
- depends_on 依赖服务启动，优先启动依赖服务再启动自身
- link 保证用服务名连接到其他服务
- 使用dockerfile构建后可以用 image命名
- 删除容器 挂在的卷不会被删除
- 有些配置文件最好不挂载整个目录，挂载目录后会把容器源文件清空，采用copy的形式复制过去
