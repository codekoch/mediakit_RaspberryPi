#!/bin/bash
pin="65100000"
cd /opt/lazycast
### test if desktop manager is active
test=1
while [ $test -lt  2 ]
do
test=`ps -aux | grep -i "pcmanfm --desktop --profile LXDE-pi" | wc -l`
if [ $test -lt 2 ]; then
pcmanfm --desktop --profile LXDE-pi &
fi
done

while :
do      
        ipset="`sudo ifconfig | grep -i 'inet 192.168.173.1' | awk '{print $2}'`"
        if [ -z $ipset ]; then
        pcmanfm --set-wallpaper="/usr/share/rpd-wallpaper/loading.jpg"
        sudo /sbin/restoreP2PWlan.sh
        pcmanfm --set-wallpaper="/usr/share/rpd-wallpaper/info.jpg"
        else
        echo "" > /var/lib/misc/dnsmasq.leases
        sudo service dnsmasq restart
        fi
        p2pinterface="`sudo ifconfig | grep -i 'p2p-wlan' | awk '{print $1}' | sed 's/://g'`"
        echo "PIN:"     
        sudo wpa_cli -i$p2pinterface wps_pin any $pin
        echo ""
        ./d2.py
done
