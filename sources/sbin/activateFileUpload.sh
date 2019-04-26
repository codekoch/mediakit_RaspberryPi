#!/bin/bash
pcmanfm /home/mk/Uploads &
sleep 1
#cp /usr/lib/node_modules/mkServer/fileTemplates.js /usr/lib/node_modules/mkServer/templates.js
#cp /usr/lib/node_modules/mkServer/fileConfig.js /usr/lib/node_modules/mkServer/config.js
name="node"
test=`/bin/ps -aux | grep -i $name | wc -l`
if [ $test == 1 ]
then
/sbin/startnode.sh /usr/lib/node_modules/mkServer/index.js &
fi

if [ $test != 1 ]
then
stopMkServer.sh
/sbin/startnode.sh /usr/lib/node_modules/mkServer/index.js &
fi

name="serverQRCode.png"
test=`/bin/ps -aux | grep -i $name | wc -l`
if [ $test == 1 ]
then
#gpicview /opt/serverQRCode.png &
qrencode -s 30 -o $name "http://mk:3000" | mogrify -fill black -gravity North -font FreeMono -pointsize 60 -draw "text 0,0 'http://mk:3000'" $name
gpicview $name &
fi
zenity --width=600 --height=100 --info --text "File Upload for /home/mk/Uploads activated. Press button to deactivate." --ok-label="Deactivate File Upload" 2> /dev/null 
stopMkServer.sh
rm $name
