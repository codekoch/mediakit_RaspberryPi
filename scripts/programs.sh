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

######## get latest updates and upgrades 
#sudo apt-get update
#sudo apt-get upgrade

######## install needed programs
sudo apt-get install -y imagemagick
sudo apt-get install -y qrencode
sudo apt-get install -y flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install -y flathub ch.openboard.OpenBoard
#### parsec
wget https://s3.amazonaws.com/parsec-build/package/parsec-rpi.deb
sudo dpkg -i parsec-rpi.deb
sudo apt-get install -y xboxdrv


#### instal guacamole clientsless remote desktop
#sudo apt-get remove -y realvnc*
sudo apt-get purge -y realvnc*
sudo apt-get install -y libcairo2-dev
sudo apt-get install -y libjpeg62-turbo-dev
sudo apt-get install -y libpng12-dev
sudo apt-get install -y libossp-uuid-dev
sudo apt-get install -y libavcodec-dev libavutil-dev libswscale-dev
sudo apt-get install -y libpango1.0-dev
sudo apt-get install -y libssh2-1-dev
sudo apt-get install -y libtelnet-dev
sudo apt-get install -y libvncserver-dev
sudo apt-get install -y libpulse-dev
sudo apt-get install -y libssl-dev
sudo apt-get install -y libvorbis-dev
sudo apt-get install -y libwebp-dev
sudo apt-get install -y jetty9
sudo apt-get install -y x11vnc

tar xzf guacamole-server-0.9.14.tar.gz
cd guacamole-server-0.9.14
./configure --with-init-dir=/etc/init.d
make
sudo make install
sudo update-rc.d guacd defaults
sudo ldconfig
cd ..

sudo cp -R sources/etc/guacamole /etc/
sudo chmod -R 755 /etc/guacamole
sudo cp sources/home/mk/.config/autostart/x11vnc.desktop /home/mk/.config/autostart/
sudo chmod 777 /home/mk/.config/autostart/x11vnc.desktop
sudo cp sources/var/lib/jetty9/webapps/guacamole.war /var/lib/jetty9/webapps/


## pip, pymsgbox

