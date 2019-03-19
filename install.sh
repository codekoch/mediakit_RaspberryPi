#!/bin/sh
echo "install and configure everything..."
sudo rm /etc/rc3.d/S01randomWifi.sh
sudo update-rc.d -f randomWifi remove
sudo update-rc.d -f restoreTpProfile.sh remove
sudo apt-get update; sudo apt-get dist-upgrade -y
sudo apt-get install mesa-vdpau-drivers -y
echo "Then, open Chromium browser and write in address line:"
echo "chrome://flags"
echo "Here find and set enabled next flags:"
echo "enable-gpu-rasterization"
echo "enable-zero-copy"
echo "ignore-gpu-blacklist"
#Next open in the editor Chromium shortcut (chromium-browser.desktop) and find the line:

#Exec=chromium-browser %U

#Edit it like this:

#Exec=chromium-browser --enable-native-gpu-memory-buffers %U


echo "copying every script to the right place..."
sudo cp -R ./install/* /
echo "done! A restart is necessary!"
echo "sudo shutdown -r now" 
