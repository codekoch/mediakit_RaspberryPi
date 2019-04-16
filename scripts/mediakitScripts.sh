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

######## copy lightdm config file (autologin mk, display-setup-script start.sh, session-setup-script loginscript.sh)
sudo cp sources/etc/lightdm/lightdm.conf /etc/lightdm/


######### copying startupscripts

#### copy start.sh which is called by lightdm as display-setup-script 
sudo cp sources/etc/init.d/start.sh /etc/init.d

#### copy info.sh which is called by start.sh and generates wifi and miracast info on info.png desktop background 
sudo cp sources/etc/init.d/info.sh /etc/init.d

#### copy randomWifi.sh which is called by start.sh and generates random wlan passwort and miracast pin and resets/set all network devices and configs
sudo cp sources/etc/init.d/randomWifi.sh /etc/init.d

#### copy loginscript.sh which is called by lightdm as session-setup-script 
sudo cp sources/sbin/loginscript.sh /sbin/
sudo chmod 755 /sbin/loginscript.sh


######## copying mediakits scripts

#### copy restoreP2PWlan.sh which resets all wlan devices and restart miracast and hotspot
sudo cp sources/sbin/restoreP2PWlan.sh /sbin/
sudo chmod 755 /sbin/restoreP2PWlan.sh

#### copy restoreMkProfile.sh which is called by start.sh and resets mk user account, copies berryboot config files and calls checkupdate.sh
sudo cp sources/sbin/restoreMkProfile.sh /sbin/
sudo chmod 755 /sbin/restoreMkProfile.s

#### copy checkupdate.sh which is called by restoreMkProfile.sh and checks for an update file (Mediakit.img256) on all usb-devices 
sudo cp sources/sbin/checkupdate.sh /sbin/
sudo chmod 755 /sbin/checkupdate.sh

#### copy bootIntoUpdate.sh which is called by checkupdate.sh and restarts and boot into berryboot update.img file 
sudo cp sources/sbin/bootIntoUpdate.sh /sbin/
sudo chmod 755 /sbin/bootIntoUpdate.sh

######### install ability to block/unblock internet connection for wlan devices connected to the mediakit

#### copy block.sh which calls python program block.py
sudo cp sources/sbin/block.sh /sbin/
sudo chmod 755 /sbin/block.sh

#### copy block.py which calls blockInternet.sh for choosen IPs
sudo cp sources/sbin/block.py /sbin/
sudo chmod 755 sources/sbin/block.py

#### copy blockInternet.sh which blocks outgoing traffic for choosen IPs by iptables config
sudo cp sources/sbin/blockInternet.sh /sbin/
sudo chmod 755 /sbin/blockInternet.sh

#### copy unblock.sh which calls python program unblock.py
sudo cp sources/sbin/unblock.sh /sbin/
sudo chmod 755 /sbin/unblock.sh

#### copy unblock.py which calls unblockInternet.sh for choosen IPs
sudo cp sources/sbin/unblock.py /sbin/
sudo chmod 755 sources/sbin/unblock.py

#### copy unblockInternet.sh which unblocks outgoing traffic for choosen IPs by iptables config
sudo cp sources/sbin/unblockInternet.sh /sbin/
sudo chmod 755 /sbin/unblockInternet.sh



