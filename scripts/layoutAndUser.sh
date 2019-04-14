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
#### add user mk
echo "add user mk..." 
sudo adduser mk << EOF 
mediakit
mediakit
mediakit




Y
EOF
sudo mkdir /home/mk/.config
sudo chown -R mk:mk /home/mk/.config

#### setting up mediakit layout
echo "copying layout files..."
pwd
#### menu launch button
sudo cp ../sources/usr/share/raspberrypi-artwork/launch.png /usr/share/raspberrypi-artwork/ 
#### splashscreen at startup
sudo cp ../sources/usr/share/plymouth/themes/pix/splash.png /usr/share/plymouth/themes/pix/ 
#### show Version on splashscreen at startup
sudo cp ../sources/usr/share/plymouth/themes/pix/pix.script /usr/share/plymouth/themes/pix/
#### desktop background (mediakit logo)
sudo cp ../sources/usr/share/rpd-wallpaper/logo.jpg /usr/share/rpd-wallpaper/
#### desktop background (loading mediakit logo)
sudo cp ../sources/usr/share/rpd-wallpaper/loading.jpg /usr/share/rpd-wallpaper/
#### all desktop settings and icon arrangements
sudo cp -R ../sources/home/mk/.config/pcmanfm /home/mk/.config/
sudo cp -R ../sources/home/mk/Desktop /home/mk/
#### copying all mediakit desktop icons
sudo cp ../sources/usr/share/pixmaps/* /usr/share/pixmaps/

sudo chown -R mk:mk /home/mk/*
