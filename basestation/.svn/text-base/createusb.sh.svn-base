#!/bin/bash

usage()
{
    echo "usage: createusb.sh device"
}

device="/dev/null"
force=1

for i in "$@"
do
    if [ $i == "--help" ]; then
        usage
        exit
    elif [ $i == "-f" ]; then
        force=0
    else
        device=$i
    fi
done

if [ $device == "/dev/null" ]; then
    usage
    exit
fi

./verifyinstaller

if [ $? -eq 0 ] || [ $force -eq 0 ]; then
    echo "Unmounting device"
    umount $device
    dev1=$device\1
    for i in `seq 4`
    do
        if grep $device$i /proc/mounts
        then
            umount $device$i
        fi
    done

    echo "Partitioning"
    fdisk $device <<EOF
o
n
p
1


t
c
a
1
w
EOF

    echo "Creating filesystem"
    mkdosfs $dev1
    echo "*********** Copying data"
    mkdir -p tmp
    mount $dev1 tmp
    if [ $? -ne 0 ]; then
        echo "cannot mount dev1"
        exit
    fi
    rsync -a /tmp/image_dir/ tmp
    grub-install --boot-directory tmp/boot $device
    umount $dev1
    eject $device
    rmdir tmp
fi

