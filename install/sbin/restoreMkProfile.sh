#!/bin/sh
dataDevice="`cat /boot/cmdline.txt | awk -F'datadev=' '{print $2}' | awk '{print $1}'`"
if [ $dataDevice = "sda2" ]; then
    sudo  sed -i 's/datadev=mmcblk0p2/datadev=sda2/g' /sbin/cmdline.txt
fi
if [ $dataDevice = "mmcblk0p2" ]; then
    sudo  sed -i 's/datadev=sda2/datadev=mmcblk0p2/g' /sbin/cmdline.txt 
fi
exit

if [ -e /dev/mmcblk0p2 ]
  then
    echo "SD Filesystem exists." >>  /home/pi/start.log
    sudo mount /dev/$dataDevice /tmp
    sudo mount /dev/mmcblk0p1 /media/mk/boot
    sudo cp /sbin/cmdline.txt /media/mk/boot/
    sudo cp /sbin/config.txt /media/mk/boot/
    sudo /sbin/checkupdate.sh
    sudo rm -R /tmp/data/Mediakit.img256/home/mk/* #Remove the mk folder.
    sudo rm -R /tmp/data/Mediakit.img256/home/mk/.* #Remove the mk folder.
    sudo umount /dev/$dataDevice
    sudo umount /dev/mmcblk0p1
else
    echo "HD Filesystem exists." >>  /home/pi/start.log
    sudo mount /dev/$dataDevice /tmp
    sudo mount /dev/sda1 /media/mk/boot
    sudo cp /sbin/cmdline.txt /media/mk/boot/ 
    sudo cp /sbin/config.txt /media/mk/boot/
    sudo /sbin/checkupdate.sh
    sudo rm -R /tmp/data/Mediakit.img256/home/mk/* #Remove the mk folder.
    sudo rm -R /tmp/data/Mediakit.img256/home/mk/.* #Remove the mk folder.
    sudo umount /dev/$dataDevice
    sudo umount /dev/sda1
fi

