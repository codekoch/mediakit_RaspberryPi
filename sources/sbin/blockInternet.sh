#!/bin/bash
if [ $1 == "all" ] ; then
if [ -e /tmp/freeips.txt ]; then
readarray freeips < /tmp/freeips.txt
else
freeips=("" "")
fi
sudo iptables -F
sudo iptables -I FORWARD -s 1.1.1.0/24 -j DROP


for((i=2; i<=62; i++)) 
{
blockip="1.1.1."$i
if `echo ${freeips[@]} | grep -q $blockip` ; then
## IP
sudo iptables -I FORWARD-s $blockip -j ACCEPT
fi
}
zenity --width=400 --height=100 --info --text="Internet for all devices blocked!" --timeout=2 2> /dev/null  &
else 
blockip=$1 
sudo iptables -I FORWARD -s $1 -j DROP
zenity --width=400 --height=100 --info --text="Internet for $1 blocked!" --timeout=2 2> /dev/null  &
fi



