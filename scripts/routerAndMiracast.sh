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
sudo cp -R sources/opt/lazycast /opt/

#### copy hotspot config files
sudo cp -R sources/etc/hostapd /etc/ #### copy hostapd.conf,hostapd.conf.intern, hostapd.conf.usb

#### copy dnsmasq config files
sudo cp sources/etc/dnsmasq.conf* /etc/ #### copy dnsmasq.conf,dnsmasq.conf.intern, dnsmasq.conf.usb, dnsmasq.conf.normal

#### copy dhcpcd config files
sudo cp sources/etc/dhcpcd.conf* /etc/ #### copy dhcpcd.conf,dhcpcd.conf.intern, dhcpcd.conf.usb,dhcpcd.ocnf.normal

#### wpa_supplicant config files  
sudo cp sources/etc/wpa_supplicant/* /etc/wpa_supplicant/ #### copy wpa_supplicant.conf, wpa_supplicant.conf.normal

######## see also scripts/mediakitScripts.sh start.sh, info.sh, restoreMKProfile.sh, restoreP2PWlan.sh, randomWifi.sh 
######## these scripts interact with mediakits miracast and hotspot ability
