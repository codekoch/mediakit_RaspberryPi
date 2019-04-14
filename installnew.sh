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

green_msg "Done! A restart is necessary!"
green_msg "sudo shutdown -r now" 
