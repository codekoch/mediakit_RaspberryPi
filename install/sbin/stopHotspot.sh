#!/bin/sh
sudo service hostapd stop
sudo service dnsmasq stop
echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev" > /etc/wpa_supplicant/wpa_supplicant.conf
echo "update_config=1" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "" > /var/lib/misc/dnsmasq.leases
sudo wpa_cli flush
sudo cp /etc/dhcpcd.conf.normal /etc/dhcpcd.conf
sudo service dhcpcd restart

