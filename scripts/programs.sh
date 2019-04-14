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
sudo apt-get install -y zenity
sudo apt-get install -y pinta
## pip, pymsgbox

