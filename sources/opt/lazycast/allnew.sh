#!/bin/bash
pin="86100000"
cd /opt/lazycast
### Wait until start.sh finished
while ! [ -e /tmp/startFinished.tmp ]
do
echo "waiting for start.sh to be finished" 
done

while [ -e /tmp/startFinished.tmp ]
do
rm /tmp/startFinished.tmp
done
### test if desktop manager is active
test=1
while [ $test -lt  2 ]
do
 test=`ps -aux | grep -i "pcmanfm --desktop --profile LXDE-pi" | wc -l`
 if [ $test -lt 2 ]; then
  pcmanfm --desktop --profile LXDE-pi &
  sleep 1
 fi
 pcmanfm --set-wallpaper="/usr/share/rpd-wallpaper/logo.jpg"
 sleep 2
 test=`ps -aux | grep -i "pcmanfm --desktop --profile LXDE-pi" | wc -l`
done

while :
do      
        ipset="`sudo ifconfig | grep -i 'inet 192.168.173.1' | awk '{print $2}'`"
        if [ -z $ipset ]; then
        test=1
         while [ $test -lt  2 ]
          do
            test=`ps -aux | grep -i "pcmanfm --desktop --profile LXDE-pi" | wc -l`
            if [ $test -lt 2 ]; then
              pcmanfm --desktop --profile LXDE-pi &
              sleep 1
            fi
            pcmanfm --set-wallpaper="/usr/share/rpd-wallpaper/loading.jpg"
            sleep 2
            test=`ps -aux | grep -i "pcmanfm --desktop --profile LXDE-pi" | wc -l`
         done
        sudo /sbin/restoreP2PWlan.sh
        test=1
         while [ $test -lt  2 ]
          do
            test=`ps -aux | grep -i "pcmanfm --desktop --profile LXDE-pi" | wc -l`
            if [ $test -lt 2 ]; then
              pcmanfm --desktop --profile LXDE-pi &
              sleep 1
            fi
            pcmanfm --set-wallpaper="/usr/share/rpd-wallpaper/info.jpg"
            sleep 2
            test=`ps -aux | grep -i "pcmanfm --desktop --profile LXDE-pi" | wc -l`
         done
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
