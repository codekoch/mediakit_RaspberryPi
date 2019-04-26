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
#gpicview /opt/serverQRCode.png &
qrencode -s 30 -o $name "http://mk:3000" | mogrify -fill black -gravity North -font FreeMono -pointsize 60 -draw "text 0,0 'http://mk:3000'" $name
gpicview $name &
fi


zenity --width=600 --height=100 --info --text "Filebrowser for /home/mk/Public activated. Press button to deactivate." --ok-label="Deactivate Filebrowser" 2> /dev/null 
stopMkServer.sh
rm $name
