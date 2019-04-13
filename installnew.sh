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

green_msg "install and configure everything..."

######## install mediakit layout
yellow_msg "-install mediakit layout"

######## install router ability
yellow_msg "-install router ability"
#### Firewall settings
yellow_msg "->install firewall settings"
#### Hotspot
yellow_msg "->install hotspot"

######## install miracast ability
yellow_msg "-install miracast ability"

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



green_msg "Done! A restart is necessary!"
green_msg "sudo shutdown -r now" 
