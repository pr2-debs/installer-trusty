#!/bin/bash

# because the python script was pretty much just:
# subprocess.call(...)

isofile="/dev/null"
force=1

usage ()
{
    echo "usage: ./createiso.sh isofile"
}

for i in "$@"
do
    if [ $i == "--help" ]; then
        usage
        exit
    elif [ $i == "-f" ]; then
        force=0
    else
        isofile=$i
    fi
done

if [ $isofile == "/dev/null" ]; then
    usage
    exit
fi

./verifyinstaller

if [ $? -eq 0 ] || [ $force -eq 0 ]; then
    genisoimage -R -o $isofile -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table install_dev1
fi
