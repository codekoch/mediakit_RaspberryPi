#!/bin/bash
##zenity --info --text="Starting Screencast ..." --timeout=6 2> /dev/null  &

##ip=`cat /var/log/auth.log | grep -i "ssh2" | awk END'{print $11}'`
##echo $ip
##adress=$ip":8888/browserfs.html"
##echo "openening "$adress
##chromium-browser $adress --start-fullscreen &
wlanModul1="`ip link show | grep -i 'wlan1' | awk '{print $2}' | sed 's/://g'`"
if [ -z $wlanModul1 ]; then
zenity --info --text="Activating mirarcast and stopping the hoptspot..." --timeout=6 2> /dev/null  &
cd /opt/lazycast
pointsize=30
bigpointsize=50
yp=10
./start.sh
else
python /sbin/screencast.py 
fi
