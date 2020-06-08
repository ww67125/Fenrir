杀死所有运行的容器
`docker kill $(docker ps -a -q)`
-q 只显示id

删除所有停止容器
`docker rm $(docker ps -a -q)`

删除所有镜像（添加-f参数强制删除）
`docker rmi $(docker images -q)`

docker-compose命令
up -d 后台启动执行
up --build 启动时重新构建
build 重新构建
rm -v 删除停止容器
down 停止并删除
logs -f servicename 查看指定服务日志
