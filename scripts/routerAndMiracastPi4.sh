#!/bin/bash
function red_msg() {
echo -e "\\033[31;1m${@}\033[0m"
}
 
function green_msg() {
echo -e "\\033[32;1m${@}\033[0m"
}
function yellow_msg() {
echo -e "\\033[33;1m${@}\033[0m"
}
 
function blue_msg() {
echo -e "\\033[34;1m${@}\033[0m"
}
#### update package list
sudo apt-get update
#### install dnsmasq 
sudo apt-get install -y dnsmasq
#### install hostapd
sudo apt-get install -y hostapd

#### install miracast ability 
sudo cp -R sources/opt/lazycastPi4/lazycast /opt/
sudo chmod -R 755 /opt/lazycast
wget http://ftp.us.debian.org/debian/pool/main/w/wpa/wpasupplicant_2.4-1+deb9u4_armhf.deb
sudo apt --allow-downgrades install -y ./wpasupplicant_2.4-1+deb9u4_armhf.deb

#### copy hotspot config files
sudo cp -R sources/etc/hostapd /etc/ #### copy hostapd.conf,hostapd.conf.intern, hostapd.conf.usb
sudo cp sources/etc/default/hostapd /etc/default/ #### Defaults for hostapd initscript

#### unmask hostapd.service, it seems to be necessary ;-) 
sudo systemctl unmask hostapd.service

#### disable hostapd to boot at startup
sudo systemctl disable hostapd

#### copy dnsmasq config files
sudo cp sources/etc/dnsmasq.conf* /etc/ #### copy dnsmasq.conf,dnsmasq.conf.intern, dnsmasq.conf.usb, dnsmasq.conf.normal

#### copy dhcpcd config files
sudo cp sources/etc/dhcpcd.conf* /etc/ #### copy dhcpcd.conf,dhcpcd.conf.intern, dhcpcd.conf.usb,dhcpcd.ocnf.normal

#### copy current wpa_supplicant config file  
sudo cp /etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf.normal


#### network interfaces config files
sudo cp sources/etc/network/* /etc/network/ #### copy interfaces, interfaces.intern, interfaces.normal, interfaces.usb

######## see also scripts/mediakitScripts.sh start.sh, info.sh, restoreMKProfile.sh, restoreP2PWlan.sh, randomWifi.sh 
######## these scripts interact with mediakits miracast and hotspot ability
