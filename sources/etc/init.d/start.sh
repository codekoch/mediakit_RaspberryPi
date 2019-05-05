#!/bin/sh
### wait for all network functions
check=0
while [ $check -lt  3 ]
do
active1=`ps -aux | grep -i "dhcpcd" | wc -l`
if [ $active1 -lt 2 ]; then
sudo service dhcpcd restart
fi
active2=`ps -aux | grep -i "hostapd" | wc -l`
if [ $active2 -lt 2 ]; then
sudo service hostapd restart
fi
active3=`ps -aux | grep -i "dnsmasq" | wc -l`
if [ $active3 -lt 2 ]; then
sudo service dnsmasq restart
fi
check=$(($active1+$active2+$active3-3))
done
sudo /sbin/restoreMkProfile.sh
### optional
#sudo service smbd stop
#sudo service nmbd stop
#/sbin/blockAtStartup.sh 
sudo /etc/init.d/randomWifi.sh
sudo /etc/init.d/info.sh
sudo rm /tmp/startFinished.tmp
echo "1" > /tmp/startFinished.tmp
sudo chmod 777 /tmp/startFinished.tmp
sudo chown mk:mk /tmp/startFinished.tmp
