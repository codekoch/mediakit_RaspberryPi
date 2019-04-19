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
sudo chmod 755 /opt/serverQRCode.png

#### copy stopMkServer.sh which stops all running nodejs servers
sudo cp sources/sbin/stopMkServer.sh /sbin/
sudo chmod 755 /sbin/stopMkServer.sh

######### install workspace ability

#### copy activateWorspace.sh which calls startWorkspace.sh and stops running nodejs servers by calling stopMkServer.sh and shows the qrcode for the server connection
sudo cp sources/sbin/activateWorkspace.sh /sbin/
sudo chmod 755 /sbin/activateWorkspace.sh

#### copy startWorkspace.sh which calls node-file-manager script
sudo cp sources/sbin/startWorkspace.sh /sbin/
sudo chmod 755 /sbin/startWorkspace.sh

#### copy node-file-manager script which calls node-file-manager 
sudo cp sources/usr/bin/node-file-manager /usr/bin/
sudo chmod 755 /usr/bin/node-file-manager

#### copy node-file-manager  
sudo cp -R sources/usr/lib/node_modules/node-file-manager /usr/lib/node_modules/
sudo chmod -R 755 /usr/lib/node_modules/node-file-manager

######## install FileBrowser ability

#### copy activateFileBrowser.sh which calls startFileBrowser.sh and stops running nodejs servers by calling stopMkServer.sh and s$
sudo cp sources/sbin/activateFileBrowser.sh /sbin/
sudo chmod 755 /sbin/activateFileBrowser.sh

#### copy startFileBrowser.sh which calls file-Browser script
sudo cp sources/sbin/startFileBrowser.sh /sbin/
sudo chmod 755 /sbin/startFileBrowser.sh

#### copy file-browser script 
sudo cp sources/usr/bin/file-browser /usr/bin/
sudo chmod 755 /usr/bin/file-browser

######## install FileUpload
sudo cp sources/sbin/activateFileUpload.sh /sbin/
sudo chmod 755 /sbin/activateFileUpload.sh
sudo cp sources/sbin/startnode.sh /sbin/
sudo chmod 755 /sbin/startnode.sh 
sudo cp -R sources/usr/lib/node_modules/mkServer /usr/lib/node_modules/
sudo chmod -R 755 /usr/lib/node_modules/mkServer
sudo mkdir /home/mk/Uploads
sudo chown mk:mk /home/mk/Uploads
