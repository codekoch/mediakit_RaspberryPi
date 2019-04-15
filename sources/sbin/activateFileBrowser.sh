#!/bin/bash
pcmanfm /home/mk/Public &
sleep 1
cd /home/mk/Public

name="node"
test=`/bin/ps -aux | grep -i $name | wc -l`
if [ $test == 1 ]
then
/sbin/startFileBrowser.sh &
fi

if [ $test != 1 ]
then
stopMkServer.sh
/sbin/startFileBrowser.sh &
fi


name="serverQRCode.png"
test=`/bin/ps -aux | grep -i $name | wc -l`
if [ $test == 1 ]
then
gpicview /opt/serverQRCode.png &
fi


zenity --width=600 --height=100 --info --text "Filebrowser for /home/mk/Public activated. Press button to deactivate." --ok-label="Deactivate Filebrowser" 2> /dev/null 
stopMkServer.sh
