远程连接 vnc4server
启动后出现启动配置文件 .vnc/xstartup
关闭连接 vnc4server -kill :1           双端复制 vncconfig&

图形界面
gnome 灰色背景 无桌面 有菜单和其它控件
xfce4 可以使用
xubuntu xfce4完整版 控件齐全

安装jdk8
下载方式（无登陆验证）
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz

配置环境变量
vim /etc/profile

export PATH USER LOGNAME MAIL HOSTNAME HISTSIZE HISTCONTROL

export MYSQL_HOME=/usr/local/mysql

export JAVA_HOME=/usr/java/jdk/jdk1.8.0_131

export JRE_HOME=/usr/java/jdk/jdk1.8.0_131/jre

export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH

export PATH=$MYSQL_HOME/bin:$JAVA_HOME/bin:$JRE_HOME/bin:$JAVA_HOME:$PATH

保存生效
source /etc/profile
