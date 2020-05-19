echo "add swap"
cd /
dd if=dev/zero of=swapfile bs=1G count=8
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
echo "cat /proc/sys/vm/swappiness"
cat /proc/sys/vm/swappiness
vm.swappiness= 50
if [ `grep -c "vm\.swappiness=.*" /etc/sysctl.conf` -ne '0' ];then
  sed -i 's/vm\.swappiness=.*/vm.swappiness= 50/g' /etc/sysctl.conf
else
  echo "vm.swappiness=50" | tee -a /etc/sysctl.conf
fi
