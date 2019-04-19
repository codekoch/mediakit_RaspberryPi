#!/bin/sh

if ! [ -e /a ]
  then
  sudo mkdir /a
fi

if ! [ -e /b ]
  then
  sudo mkdir /b
fi

if [ -e /dev/mmcblk0p1 ]
  then
    sudo mount /dev/mmcblk0p1 /a
    dataDevice="`cat /a/cmdline.txt | awk -F'datadev=' '{print $2}' | awk '{print $1}'`"
    if [ $dataDevice = "sda2" ]; then
      sudo  sed -i 's/datadev=mmcblk0p2/datadev=sda2/g' /sbin/cmdline.txt
    fi
    if [ $dataDevice = "mmcblk0p2" ]; then
      sudo  sed -i 's/datadev=sda2/datadev=mmcblk0p2/g' /sbin/cmdline.txt 
    fi
    sudo mount /dev/$dataDevice /b
    sudo cp /sbin/cmdline.txt /a
    sudo cp /sbin/config.txt /a
    echo "cmdline.txt and confg.txt updated!"
    sudo /sbin/checkupdate.sh
    sudo rm -R /b/data/Mediakit.img*/home/mk/* #Remove the mk folder.
    sudo rm -R /b/data/Mediakit.img*/home/mk/.* #Remove the mk folder.
    if [ -d "/home/pi/backup/mk" ]; then
       sudo cp -R /home/pi/backup/mk /home/
       sudo chown -R mk:mk /home/mk 
       sleep 1
    fi  
    sudo umount /dev/$dataDevice
    sudo umount /dev/mmcblk0p1
    sudo mount /dev/mmcblk0p1 /boot
else
    sudo mount /dev/sda1 /a
    dataDevice="`cat /a/cmdline.txt | awk -F'datadev=' '{print $2}' | awk '{print $1}'`"
    if [ $dataDevice = "sda2" ]; then
      sudo  sed -i 's/datadev=mmcblk0p2/datadev=sda2/g' /sbin/cmdline.txt
    fi
    if [ $dataDevice = "mmcblk0p2" ]; then
      sudo  sed -i 's/datadev=sda2/datadev=mmcblk0p2/g' /sbin/cmdline.txt 
    fi
    sudo mount /dev/$dataDevice /b
    sudo cp /sbin/cmdline.txt /a 
    sudo cp /sbin/config.txt /a
    sudo /sbin/checkupdate.sh
    sudo rm -R /b/data/Mediakit.img*/home/mk/* #Remove the mk folder.
    sudo rm -R /b/data/Mediakit.img*/home/mk/.* #Remove the mk folder.
    if [ -d "/home/pi/backup/mk" ]; then
       sudo cp -R /home/pi/backup/mk /home/
       sudo chown -R mk:mk /home/mk
       sleep 1 
    fi 
    sudo umount /dev/$dataDevice
    sudo umount /dev/sda1
    sudo mount /dev/sda1 /boot
fi

