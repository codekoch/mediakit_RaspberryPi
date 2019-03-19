#!/bin/sh
## settings: NNN should be set by /etc/init.d/randomWifi.sh
pin="NNN"
password="mediakit$pin"
wlanssid="NNN"
wlanModul1="`ip link show | grep -i 'wlan1' | awk '{print $2}' | sed 's/://g'`"
lanIP="`sudo /sbin/ifconfig eth0 | grep 'inet' | awk '{ print $2}' | head -1`"
if [ -z $wlanModul1 ]; then
wlanIP="`sudo /sbin/ifconfig wlan0 | grep 'inet' | awk '{ print $2}' | head -1`"
else
wlanIP="`sudo /sbin/ifconfig wlan1 | grep 'inet' | awk '{ print $2}' | head -1`"
fi
version="`cat /usr/share/plymouth/themes/pix/pix.script | grep -i 'Copyright' | awk '{ print $3}' | sed 's/.*(\"//'`"

## set up the background image
pointsize=30
bigpointsize=50
yp=10
sudo convert /usr/share/rpd-wallpaper/logo.jpg -fill white -gravity NorthEast -font FreeMono -pointsize 30 -draw "text 0,10 'mediakit "$version"'" /usr/share/rpd-wallpaper/info.jpg
yp=$(($yp+$pointsize))
#if [ -z $wlanModul1 ]; then
#sudo mogrify -fill yellow -gravity NorthEast -font FreeMono -pointsize $pointsize -draw "text 0,"$yp" 'WLAN SSID:'" /usr/share/rpd-wallpaper/info.jpg
#else
sudo mogrify -fill yellow -gravity NorthEast -font FreeMono -pointsize $pointsize -draw "text 0,"$yp" 'WLAN / MIRACAST SSID:" /usr/share/rpd-wallpaper/info.jpg
#fi
yp=$(($yp+$pointsize))
sudo mogrify -fill yellow -gravity NorthEast -font FreeMono -pointsize $bigpointsize -draw "text 0,"$yp" '"$wlanssid"'" /usr/share/rpd-wallpaper/info.jpg
yp=$(($yp+$bigpointsize))
sudo mogrify -fill yellow -gravity NorthEast -font FreeMono -pointsize $bigpointsize -draw "text 0,"$yp" 'KEY:"$password"'" /usr/share/rpd-wallpaper/info.jpg
#if ! [ -z $wlanModul1 ]; then
yp=$(($yp+$bigpointsize))
sudo mogrify -fill yellow -gravity NorthEast -font FreeMono -pointsize $bigpointsize -draw "text 0,"$yp" 'PIN:"$pin"00000'" /usr/share/rpd-wallpaper/info.jpg
#fi

if  [ -z $lanIP ]; then
yp=$(($yp+$bigpointsize))
sudo mogrify -fill red -gravity NorthEast -font FreeMono -pointsize $pointsize -draw "text 0,"$yp" 'No LAN Connection!'" /usr/share/rpd-wallpaper/info.jpg
fi

sudo chmod 777 /usr/share/rpd-wallpaper/info.jpg
