#!/system/xbin/sh
# DONT TOUCH FIRST LINE !!!!
echo "SETTING VARIABLES"
export bin=/system/bin ## divine where bin is
export mnt=/sdcard/linux/debian ## divine where mnt is
export PATH=$bin:/usr/bin:/usr/sbin:/bin:/sbin:$PATH ## set path so that we can run things anywhere
export TERM=linux ## divine term
export HOME=/root ## divine home

echo "MOUNTING"
ln -s /dev/block/loop0 /dev/loop0
losetup /dev/loop0 /Removable/MicroSD/debian.img
mount -t auto /dev/loop0 /sdcard/linux ## mount a ext2 loop file from dir to dir
mount -t devpts devpts $mnt/dev/pts ### mount android devpts in root (mnt/dev/pts)
mount -t proc proc $mnt/proc ## same as above
mount -t sysfs sysfs $mnt/sys ### same as above

echo "SETTING UP NETWORK"
sysctl -w net.ipv4.ip_forward=1 ## ip forward so that we have internet from android
echo "nameserver 208.67.222.222" > $mnt/etc/resolv.conf ### as is
echo "nameserver 208.67.220.220" >> $mnt/etc/resolv.conf ### as is
echo "127.0.0.1 localhost" > $mnt/etc/hosts ## as is

chroot $mnt /bin/bash #### finally lets chroot the dir and init /bin/bash meaning lets start a vm on that dir
