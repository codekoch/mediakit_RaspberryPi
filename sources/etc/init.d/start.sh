#!/bin/sh
sudo /sbin/restoreMkProfile.sh
#sudo service smbd stop
#sudo service nmbd stop
#/sbin/blockAtStartup.sh 
sudo /etc/init.d/randomWifi.sh
sudo /etc/init.d/info.sh
sudo rm /tmp/startFinished.tmp
echo "1" > /tmp/startFinished.tmp
sudo chmod 777 /tmp/startFinished.tmp
