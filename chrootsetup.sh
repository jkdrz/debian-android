#!/system/xbin/sh

# modified from http://forum.xda-developers.com/showpost.php?p=15168040&postcount=2

echo "SETTING VARIABLES"
export bin=/system/bin ## divine where bin is
export mnt=/sdcard/linux/debian ## set your planned mount point for the chroot
export PATH=$bin:/usr/bin:/usr/sbin:/bin:/sbin:$PATH ## set path so that we can run things anywhere
export TERM=linux ## divine term
export HOME=/root ## divine home

echo "MOUNTING"
losetup /dev/block/loop0 /Removable/MicroSD/debian.img #set up the loop image from uSD
mount -t auto /dev/block/loop0 /sdcard/linux ## mount the filesystem
mount -t devpts devpts $mnt/dev/pts ### mount android devpts in root (mnt/dev/pts)
mount -t proc proc $mnt/proc ## same as above
mount -t sysfs sysfs $mnt/sys ### same as above

echo "SETTING UP NETWORK"
sysctl -w net.ipv4.ip_forward=1 ## ip forward so that we have internet from android
echo "nameserver 208.67.222.222" > $mnt/etc/resolv.conf ### as is
echo "nameserver 208.67.220.220" >> $mnt/etc/resolv.conf ### as is
echo "127.0.0.1 localhost" > $mnt/etc/hosts ## as is

#ready for the chroot
echo "ready to chroot. run \"chroot /sdcard/linux/debian /bin/bash\" to begin"
