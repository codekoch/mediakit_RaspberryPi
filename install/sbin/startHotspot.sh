#!/bin/sh
sudo service dnsmasq stop
sudo service hostapd stop
sudo service dhcpcd stop
sudo cp /etc/dhcpcd.conf.intern /etc/dhcpcd.conf
sudo service dhcpcd start
sudo /sbin/iptables -F
sudo /sbin/iptables -X
sudo /sbin/iptables -t nat -F
sudo sysctl -w net.ipv4.ip_forward=1
sudo sysctl -w net.ipv6.conf.all.forwarding=1
sudo iptables -t nat -A  POSTROUTING -o eth0 -j MASQUERADE
sudo service dnsmasq start
sudo service hostapd start

