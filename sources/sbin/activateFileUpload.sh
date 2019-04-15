#!/bin/bash
pcmanfm /home/mk/Uploads &
sleep 1
cp /opt/mkServer/fileTemplates.js /opt/mkServer/templates.js
cp /opt/mkServer/fileConfig.js /opt/mkServer/config.js
name="node"
test=`/bin/ps -aux | grep -i $name | wc -l`
if [ $test == 1 ]
then
/sbin/startnode.sh /opt/mkServer/index.js &
fi

if [ $test != 1 ]
then
stopMkServer.sh
/sbin/startnode.sh /opt/mkServer/index.js &
fi

name="serverQRCode.png"
test=`/bin/ps -aux | grep -i $name | wc -l`
if [ $test == 1 ]
then
gpicview /opt/serverQRCode.png &
fi
zenity --width=600 --height=100 --info --text "File Upload for /home/mk/Uploads activated. Press button to deactivate." --ok-label="Deactivate File Upload" 2> /dev/null 
stopMkServer.sh
