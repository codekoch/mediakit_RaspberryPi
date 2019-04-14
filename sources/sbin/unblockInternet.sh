#!/bin/bash
if [ $1 == "all" ] ; then
sudo iptables -F
zenity --width=400 --height=100 --info --text="Internet for all devices unblocked!" --timeout=2 2> /dev/null  &
else
sudo iptables -I FORWARD -s $1 -j ACCEPT
zenity --width=400 --height=100 --info --text="Internet for $1 unblocked!" --timeout=2 2> /dev/null  &
fi



