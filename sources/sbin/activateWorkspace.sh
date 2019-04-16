#!/bin/bash
pcmanfm /home/mk/Public/Workspace &
sleep 1
cd /home/mk/Public
mkdir Workspace
#node-file-manager -p 3000 -d /home/tp/Public/Workspace &

name="node"
test=`/bin/ps -aux | grep -i $name | wc -l`
if [ $test == 1 ]
then
/sbin/startWorkspace.sh &
fi

if [ $test != 1 ]
then
stopMkServer.sh
/sbin/startWorkspace.sh &
fi

name="serverQRCode.png"
test=`/bin/ps -aux | grep -i $name | wc -l`
if [ $test == 1 ]
then
qrencode -s 30 -o $name "http://1.1.1.1:3000" | mogrify -fill black -gravity North -font FreeMono -pointsize 60 -draw "text 0,0 'https://1.1.1.1:3000'" $name
gpicview $name &
fi



zenity --width=600 --height=100 --info --text "workspace /home/mk/Public/Workspace activated. Press button to deactivate." --ok-label="Deactivate Workspace" 2> /dev/null 
stopMkServer.sh
rm $name
