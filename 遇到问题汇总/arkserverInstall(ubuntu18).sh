echo "start install"
echo "安装依赖"
dpkg --add-architecture i386; sudo apt update; sudo apt install mailutils postfix curl wget file tar bzip2 gzip unzip bsdmainutils python util-linux ca-certificates binutils bc jq tmux lib32gcc1 libstdc++6 lib32stdc++6 steamcmd netcat
echo "199.232.4.133 raw.githubusercontent.com" >> /etc/hosts
echo "设置新账户"
adduser arkserveradmin
echo "DenyUsers arkserveradmin" >> /etc/ssh/sshd_config
service sshd restart
echo "配置防火墙"
ufw allow 7777
ufw allow 7778
ufw allow 27015
echo "去掉文件限制"
echo "fs.file-max=100000" >> /etc/sysctl.conf
sysctl -p /etc/sysctl.conf
echo "* soft nofile 1000000" >> /etc/security/limits.conf
echo "* hard nofile 1000000" >> /etc/security/limits.conf
su arkserveradmin
cd /home/arkserveradmin
mkdir arkserver
cd arkserver
wget -O linuxgsm.sh https://linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh arkserver
./arkserver install
read -p "输入服务器密码:" serverpass
sed -i 's/ServerPassword=*/ServerPassword=${serverpass}/g' /home/arkserveradmin/arkserver/serverfiles/ShooterGame/Saved/Config/LinuxServer/GameUserSettings.ini
read -p "输入管理员密码:" adminpass
sed -i 's/ServerAdminPassword=*/ServerAdminPassword=${adminpass}/g' /home/arkserveradmin/arkserver/serverfiles/ShooterGame/Saved/Config/LinuxServer/GameUserSettings.ini
read -p "输入服务名称:" servername
sed -i 's/SessionName=*/SessionName=${servername}/g' /home/arkserveradmin/arkserver/serverfiles/ShooterGame/Saved/Config/LinuxServer/GameUserSettings.ini

echo "fn_parms(){
parms="\"${defaultmap}?AltSaveDirectoryName=${defaultmap}?listen?MultiHome=${ip}?MaxPlayers=${maxplayers}?QueryPort=${queryport}?RCONPort=${rconport}?Port=${port}?bRawSockets -automanagedmods\""}" >> /home/arkserveradmin/arkserver/lgsm/config-lgsm/arkserver/arkserver.cfg

echo "updateonstart=\"on\"" >>  /home/arkserveradmin/arkserver/lgsm/config-lgsm/arkserver/arkserver.cfg
