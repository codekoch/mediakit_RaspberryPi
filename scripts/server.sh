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

#### copy hosts file (http://1.1.1.1 can be reached by http://mk)
sudo cp sources/etc/hosts /etc/

#### copy qr-code with server connection
sudo cp sources/opt/serverQRCode.png /opt/

#### copy stopMkServer.sh which stops all running nodejs servers
sudo cp sources/sbin/stopMkServer.sh /sbin/


######### install workspace ability

#### copy activateWorspace.sh which calls startWorkspace.sh and stops running nodejs servers by calling stopMkServer.sh and shows the qrcode for the server connection
sudo cp sources/sbin/activateWorkspace.sh /sbin/

#### copy startWorkspace.sh which calls node-file-manager script
sudo cp sources/sbin/startWorkspace.sh /sbin/

#### copy node-file-manager script which calls node-file-manager 
sudo cp sources/usr/bin/node-file-manager /usr/bin/

#### copy node-file-manager  
sudo cp -R sources/usr/lib/node_modules/node-file-manager /usr/lib/node_modules/
