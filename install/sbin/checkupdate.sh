#!/bin/bash
### Settings
path="/tmp/data/FILES"
#path="/media/mk/berryboot/data/FILES"
file="Mediakit.img256"
server="http://images.mediakit.education"
license="`cat /media/mk/boot/mediakit.lic`"
###
rm $path/update.txt
### check if Image exists on USB Stick
dataDevice="`cat /boot/cmdline.txt | awk -F'datadev=' '{print $2}' | awk '{print $1}'`"
### get usb-device-links
mapfile -t usbLinks < <(ls /dev/disk/by-id | grep -i 'usb' | grep -v 'part')
#usbLink=(`ls /dev/disk/by-id | grep -i 'usb' | grep -v 'part'`)
for entry in "${usbLinks[@]}"
do
usbDevice="`readlink -e /dev/disk/by-id/$entry`"
usbDevice="`ls $usbDevice* | tail -1`"
echo "check usbDevice=$usbDevice"
if ! [[ $usbDevice == *"$dataDevice"* ]]; then
ubsLink=$entry 
break 
fi
echo "Skipped!It's the data device!"
done

echo "usblink="$usbLink
echo "usbDevice="$usbDevice
mkdir /media/pi/usbImage
sudo mount $usbDevice /media/pi/usbImage
if [ -e /media/pi/usbImage/$file ]; then
   #echo "found imagefile"
   questiontext="Update from USB possible!\nStart update?\nUpdate will take a few minutes.\n(Be sure it is the right image file!)"
   zenity --width=600 --height=400 --question --text "$questiontext" 2> /dev/null
   case $? in 
    0) update=0
    ;; 
    1) echo "Aborting update process!"
    ;;  
   esac
   if  [ $update = 0 ]; then
   # (
   #  sudo cp /media/pi/usbImage/$file $path/ 
   # ) | zenity --title "Filecopy" --text "Copying image file. Please Wait..."  --ok-label="Continue" --progress --pulsate --auto-close 2> /dev/null 
    #(
    #PID_ZENITY=${!}
    # get firstly created child process id, which is running all tasks
    #PID_CHILD=$(pgrep -o -P $$)
    #while [ "$PID_ZENITY" != "" ]
    #do
      # get PID of all running tasks
    #  PID_TASKS=$(pgrep -d ' ' -P ${PID_CHILD})
    #  # check if zenity PID is still there (dialog box still open)
    #  PID_ZENITY=$(ps h -o pid --pid ${PID_ZENITY} | xargs)
    #  # sleep for 2 second
    #  sleep 2
    #done
    #)
    #pid=$(ps -e | grep cp | awk '{print $1}')
    #if [ "$pid" != "" ]; then#
    #  kill -9 $pid
    #  zenity --info --title "Filecopy" --text "Filecopy was not finished ... try again later!" 2> /dev/null
    #  sudo umount $usbDevice
    #  exit
    # fi
    echo "USB" > $path/update.txt
    sudo umount $usbDevice
    /sbin/bootIntoUpdate.sh
    exit
   fi
   sudo umount $usbDevice 
   exit
fi
sudo umount $usbDevice 

### deactivate InternetUpdate
exit
### 
#localVersion="`cat /etc/init.d/info.sh | grep -i "Mediakit V" | awk '{ print $4}'`"
localVersion="`cat /usr/share/plymouth/themes/pix/pix.script | grep -i 'Copyright' | awk '{ print $3}' | sed 's/.*(\"//'`"
rm $path/version.txt
curl -u $license -o $path/version.txt -C - -O $server/version.txt
lines="`cat $path/version.txt | wc -l`"
if [ $lines != "0" ]; then
  zenity --width=600 --height=400 --info --title "Update Check" --text "IP or license not ok! Get a valid license for your IP-adress...\nUpdate check cancelled." --timeout 3 2> /dev/null
  exit
fi
externalVersion="`cat $path/version.txt`"
rm $path/version.txt
if [ $externalVersion != $localVersion ]; then
  update=1
  installUpdate=1
  questiontext="Online update from Mediakit $localVersion to Mediakit $externalVersion possible!\nStart/Continue update?\n(Update will take more than 10min.\nYou can cancel the update at any time,\nit can be continued at the next reboot)"
  zenity --width=600 --height=400 --question --text "$questiontext" 2> /dev/null
  case $? in 
    0) update=0
    ;; 
    1) echo "Aborting update process!"
    ;;  
  esac
  if  [ $update = 0 ]; then
    finished="no"
    hashok="no"
    (
    curl -u $license -o $path/$file -C - -O $server/$file 2>&1 
    ) | stdbuf -oL tr '\r' '\n' | sed -u 's/^ *\([0-9][0-9]*\).*\( [0-9].*$\)/\1\n#Download Speed\:\2/' | zenity --progress --title "Downloading Update $externalVersion"  --ok-label="Continue" --cancel-label="Cancel Update" --auto-close 2> /dev/null &
    (
    # get zenity process id
    PID_ZENITY=${!}
    echo "PID="$PID_ZENITY
    # get firstly created child process id, which is running all tasks
    PID_CHILD=$(pgrep -o -P $$)
    echo "PID="$PID_CHILD
    while [ "$PID_ZENITY" != "" ]
    do
      # get PID of all running tasks
      PID_TASKS=$(pgrep -d ' ' -P ${PID_CHILD})
      # check if zenity PID is still there (dialog box still open)
      PID_ZENITY=$(ps h -o pid --pid ${PID_ZENITY} | xargs)
      # sleep for 2 second
      sleep 2
    done
    )
    pid=$(ps -e | grep curl | awk '{print $1}')
    if [ "$pid" != "" ]; then
     kill -9 $pid
     zenity --width=600 --height=400 --info --title "Update" --text "Update download was not finished ... try again later!" 2> /dev/null
     exit
    fi
    if [ "$pid" = "" ]; then
     finished="yes"
    fi
    # Check if File allready is finished
    hash=1
    hashcheck="no"
    sudo rm $path/Mediakit.hash
    sudo rm $path/Mediakitlocal.hash
    curl -u $license -o $path/Mediakit.hash -C - -O $server/Mediakit.hash
    hash="`cat $path/Mediakit.hash`"
    localHash="bla"
    (
    md5sum $path/$file | awk '{ print $1}' > $path/Mediakitlocal.hash 
    ) | zenity --width=500 --height=100 --title "Filecheck" --text "Checking downloaded File. Please Wait..."  --ok-label="Continue" --progress --pulsate --auto-close 2> /dev/null &
    (
    PID_ZENITY=${!}
    # get firstly created child process id, which is running all tasks
    PID_CHILD=$(pgrep -o -P $$)
    while [ "$PID_ZENITY" != "" ]
    do
      # get PID of all running tasks
      PID_TASKS=$(pgrep -d ' ' -P ${PID_CHILD})
      # check if zenity PID is still there (dialog box still open)
      PID_ZENITY=$(ps h -o pid --pid ${PID_ZENITY} | xargs)
      # sleep for 2 second
      sleep 2
    done
    )
    pid=$(ps -e | grep md5sum | awk '{print $1}')
    if [ "$pid" != "" ]; then
      kill -9 $pid
      zenity --width=600 --height=400 --info --title "Filecheck" --text "Update check was not finished ... repeat again later!" 2> /dev/null
      exit
    fi
    if [ "$pid" = "" ]; then
      hashcheck="yes"
    fi
    localHash="`cat $path/Mediakitlocal.hash`"
    if [ $hash != $localHash ]; then
      zenity --width=600 --height=400 --info --title "Filecheck" --text "Update download was not finished ... try again later!" 2> /dev/null 
      if [ $finished = "yes" ] && [ $hashcheck = "yes" ]; then
        echo "removing corrupted update file!"
        rm $path/$file
      fi
      exit
    fi
    if [ $hash = $localHash ]; then
      hashok="yes"
    fi
    zenity --width=600 --height=400 --question --text "Update ready for install! Do you want to restart to install the update?" 2> /dev/null
    case $? in
      0) installUpdate=0
      ;;
      1) echo "Aborting update install!" | exit
      ;;
    esac
    if  [ $installUpdate = 0 ]; then
      echo "Mediakit $externalVersion" > $path/update.txt
      /sbin/bootIntoUpdate.sh
    fi
  fi
  zenity --width=400 --height=100 --info --title "Update" --text "Update cancelled!" --timeout 3 2> /dev/$
fi

