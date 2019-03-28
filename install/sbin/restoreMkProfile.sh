#!/bin/sh
dataDevice="`cat /boot/cmdline.txt | awk -F'datadev=' '{print $2}' | awk '{print $1}'`"
if [ $dataDevice = "sda2" ]; then
    sudo  sed -i 's/datadev=mmcblk0p2/datadev=sda2/g' /sbin/cmdline.txt
fi
if [ $dataDevice = "mmcblk0p2" ]; then
    sudo  sed -i 's/datadev=sda2/datadev=mmcblk0p2/g' /sbin/cmdline.txt 
fi

if ! [ -e /a ]
  then
  sudo mkdir /a
fi

if ! [ -e /b ]
  then
  sudo mkdir /b
fi

if [ -e /dev/mmcblk0p2 ]
  then
    sudo mount /dev/$dataDevice /b
    sudo mount /dev/mmcblk0p1 /a
    sudo cp /sbin/cmdline.txt /a
    sudo cp /sbin/config.txt /a
#    sudo /sbin/checkupdate.sh
    sudo rm -R /b/data/Mediakit.img*/home/mk/* #Remove the mk folder.
    sudo rm -R /b/data/Mediakit.img*/home/mk/.* #Remove the mk folder.
    sudo umount /dev/$dataDevice
    sudo umount /dev/mmcblk0p1
else
    sudo mount /dev/$dataDevice /b
    sudo mount /dev/sda1 /a
    sudo cp /sbin/cmdline.txt /a 
    sudo cp /sbin/config.txt /a
#    sudo /sbin/checkupdate.sh
    sudo rm -R /b/data/Mediakit.img*/home/mk/* #Remove the mk folder.
    sudo rm -R /b/data/Mediakit.img*/home/mk/.* #Remove the mk folder.
    sudo umount /dev/$dataDevice
    sudo umount /dev/sda1
fi

