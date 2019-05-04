#!/bin/sh
### wait for all network functions
check=0
while [ $check -lt  3 ]
do
active1=`ps -aux | grep -i "dhcpcd" | wc -l`
active2=`ps -aux | grep -i "hostapd" | wc -l`
active3=`ps -aux | grep -i "dnsmasq" | wc -l`
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
