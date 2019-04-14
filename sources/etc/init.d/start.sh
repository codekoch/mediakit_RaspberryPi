#!/bin/sh
sudo /sbin/restoreMkProfile.sh
#sudo service smbd stop
#sudo service nmbd stop
#/sbin/blockAtStartup.sh 
sudo /etc/init.d/randomWifi.sh
sudo /etc/init.d/info.sh
