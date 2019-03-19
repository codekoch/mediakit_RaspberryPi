#!/bin/sh
n1="`shuf -i0-9 -n1`"
n2="`shuf -i0-9 -n1`"
n3="`shuf -i0-9 -n1`"
#n4="`shuf -i0-9 -n1`"
sudo  sed -i 's/wpa_passphrase=.*$/wpa_passphrase=mediakit'$n1$n2$n3'/g' /etc/hostapd/hostapd.conf.usb
sudo  sed -i 's/wpa_passphrase=.*$/wpa_passphrase=mediakit'$n1$n2$n3'/g' /etc/hostapd/hostapd.conf.intern
sudo  sed -i 's/pin=.*$/pin="'$n1$n2$n3'"/g' /etc/init.d/info.sh

# stop dnsmasq and hosapd
sudo service dnsmasq stop
sudo service hostapd stop
#sudo service networking restart
echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev" > /etc/wpa_supplicant/wpa_supplicant.conf
echo "update_config=1" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "" > /var/lib/misc/dnsmasq.leases
sudo wpa_cli flush
sudo chmod 777 /etc/wpa_supplicant/wpa_supplicant.conf
sudo chmod 777 /var/lib/misc/dnsmasq.leases
sudo chmod 777 /opt/lazycast/d2.py

# set ssid from eth0 mac adress
mac="`sudo /sbin/ifconfig eth0 | grep 'ether ' | awk '{ print $2}'`"
mac2="`echo "$mac" | sed 's/\://g'`"
wlanssid="MK-"$mac2
sudo  sed -i 's/ssid=.*$/ssid='$wlanssid'/g' /etc/hostapd/hostapd.conf
sudo  sed -i 's/wlanssid=.*$/wlanssid="'$wlanssid'"/g' /etc/init.d/info.sh

# check if we have two wlan devices
wlanModul1="`ip link show | grep -i 'wlan1' | awk '{print $2}' | sed 's/://g'`"

# setting up p2p-wlan
mac="`sudo /sbin/ifconfig eth0 | grep 'ether ' | awk '{ print $2}'`"
mac2="`echo "$mac" | sed 's/\://g'`"
wlanssid="MK-"$mac2

## set wlan ssid
sudo  sed -i "s/device_name=.*$/device_name=$wlanssid/g" /etc/wpa_supplicant/wpa_supplicant.conf

if [ -z $wlanModul1 ]; then
### only 1 detected --> use internal wlan device
wlanModul="wlan0"
sudo cp /etc/dhcpcd.conf.intern /etc/dhcpcd.conf
sudo service dhcpcd restart
sudo cp /etc/hostapd/hostapd.conf.intern /etc/hostapd/hostapd.conf
sudo cp /etc/dnsmasq.conf.intern /etc/dnsmasq.conf
else
### 2 detected --> use usb wlan (wlan1) device
 sudo cp /etc/dhcpcd.conf.usb /etc/dhcpcd.conf
 sudo service dhcpcd restart
 sudo ifconfig wlan1 1.1.1.1
 while [ -z $ipset ]; do
  ipset="`sudo ifconfig | grep -i 'inet 1.1.1.1' | awk '{print $2}'` "
 done
 sudo cp /etc/hostapd/hostapd.conf.usb /etc/hostapd/hostapd.conf
 sudo cp /etc/dnsmasq.conf.usb /etc/dnsmasq.conf
fi
sudo  sed -i 's/wps_pin any.*$/wps_pin any '$n1$n2$n3'00000/g' /opt/lazycast/all.sh
sudo  sed -i 's/pin=.*$/pin="'$n1$n2$n3'00000"/g' /opt/lazycast/allnew.sh



if [ -z $wlanModul1 ]; then
/sbin/startHotspot.sh
fi
