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

version=`git tag | tail -1`
yellow_msg "Installing mediakit_RaspberryPi Version $version..."

if ! [ -e "/boot/berryboot.img" ] ; then
red_msg "ERROR! mediakit can only be installed on a berryboot system!"
yellow_msg "https://berryterminal.com/doku.php/berryboot"
exit
fi  
green_msg "install and configure everything..."

######## install mediakit layout and user
yellow_msg "-install mediakit layout and mediakit user..."
scripts/layoutAndUser.sh

######## install router and miracast ability
yellow_msg "-install router and miracast ability..."
scripts/routerAndMiracast.sh

######## install update ability
yellow_msg "-install update ability..."

######## install startup and mediakit scripts
yellow_msg "-install startup and mediakit scripts..."
scripts/mediakitScripts.sh

######## install server ability
yellow_msg "-install server functions..."
scripts/server.sh

#### Workspace
yellow_msg "->install Workspace"
#### Fileupload
yellow_msg "->install Fileupload"
#### FileBrowser
yellow_msg "->install FileBrowser"
#### Guacamole clientless remote desktop
yellow_msg "->install guacamole clientless remote desktop"
#### activate ssh

#### install x11VNC Server (disable real vnc server)

#### install smb server

######## install mediakit selfhealing abitily
yellow_msg "-install mediakit selfhealing ability"

######## install some useful programs
yellow_msg "-install some useful programs"
scripts/programs.sh
#### openboard
#### python
#### geogebra
#### pinta
#### java
#### gparted
#### ballerburg
#### simplescreenrecorder
#### youtube-dl

######## copying sudoers file to give all necessary rights to user mk
yellow_msg "-copying sudoers file to give all necessary rights to user mk"
sudo cp sources/etc/sudoers /etc/
#### create a copy of /home/mk which is used by restoreMkProfile.sh
yellow_msg "-create copy of /home/mk"
sudo chown -R mk:mk /home/mk
sudo chmod -R 755 /home/mk
sudo mkdir /home/pi/backup
sudo cp -R /home/mk /home/pi/backup/

#### set Version
sudo  sed -i 's/my_image = Image.Text(\"v.*$/my_image = Image\.Text(\"'$version' Copyright Olaf Koch \& Simon Zander 2018\"\, 1\, 1\, 1)\;/g' /usr/share/plymouth/themes/pix/pix.script

green_msg "Done! A restart is necessary!"
green_msg "sudo shutdown -r now" 
blue_msg "(its recommended to make a copy of the current berryboot system including all data"
blue_msg "by this you can allways return to a fresh mediakit install ...)"
