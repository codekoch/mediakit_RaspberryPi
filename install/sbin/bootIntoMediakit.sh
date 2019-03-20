#!/bin/bash
WANTOS=Mediakit
dataDevice="`cat /boot/cmdline.txt | awk -F'datadev=' '{print $2}' | awk '{print $1}'`"
if [[ -z $WANTOS ]]; then
  echo Usage: ./reboot-into.sh osname
  exit 2
fi

sudo mount /dev/$dataDevice /media/pi/berryboot
cd /media/pi/berryboot/images
IMGNAME=$(ls $WANTOS.img*)

if [[ -z $IMGNAME ]]; then
  echo OS not found. Available images:
  ls *.img*
  cd
  sudo umount /dev/$dataDevice
  exit 3
fi

echo $IMGNAME | sudo tee ../data/runonce

echo -n 'Rebooting into '$IMGNAME' '
for I in $(seq 5); do sleep 1; echo -n .; done

cd
sudo umount /dev/$dataDevice
sudo shutdown -r now
