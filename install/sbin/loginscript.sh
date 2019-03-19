#!/bin/sh
#while [ -z $ipset ]; do
#ipset="`sudo ifconfig | grep -i 'inet 192.168.173.1' | awk '{print $2}'`"
#done
mv /home/mk/.kodi /home/mk/.kodi_old
mv /home/mk/.kodi_old /home/mk/.kodi
chmod -R 777 /home/mk/.kodi
wlanModul1="`ip link show | grep -i 'wlan1' | awk '{print $2}' | sed 's/://g'`"
if ! [ -z $wlanModul1 ]; then
mkdir /home/mk/.config/autostart
touch /home/mk/.config/autostart/lazycast.desktop
echo "[Desktop Entry]" > /home/mk/.config/autostart/lazycast.desktop
echo "Name=lazycast" >> /home/mk/.config/autostart/lazycast.desktop
echo "Exec=/opt/lazycast/allnew.sh">> /home/mk/.config/autostart/lazycast.desktop
echo "Type=application ">> /home/mk/.config/autostart/lazycast.desktop
echo "Terminal=true">> /home/mk/.config/autostart/lazycast.desktop
chmod 755 /home/mk/.config/autostart/lazycast.desktop
else
rm -rf /home/mk/.config/autostart/lazycast.desktop
fi
