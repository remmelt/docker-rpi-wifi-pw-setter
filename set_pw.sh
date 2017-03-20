#! /bin/bash

set -o pipefail
set -o nounset
set -o errexit

if [ $# -ne 1 ]; then
    echo "Please provide the image name"
    exit 1
fi

img="/images/${1}"

echo "HI! I'm going to set SSH access and wifi config in the Raspbian image."
echo
echo -n "Trying to find ${img}... "
if [ -f "${img}" ]; then
    echo found!
else
    echo
    echo "Could not find the image file..."
    exit 2
fi
echo

mkdir -p /mnt/disk1 /mnt/disk2

for nr in 1 2; do
    i=$(fdisk -l "${img}" | grep "${img}${nr}" | awk '{print "offset=" $2*512 ",sizelimit=" $3*512}')
    mount -o loop,${i} "${img}" /mnt/disk${nr}
done

# Enable ssh access by putting a file named 'ssh' in the boot partition
touch $(dirname $(find /mnt -name kernel.img))/ssh

echo -n "Your SSID: "
read ssid
echo -n "Your wifi password: "
read pw

# Find the wpa_supplicant file
wpa_supplicant=$(find /mnt -name wpa_supplicant.conf | grep /etc/wpa_supplicant/wpa_supplicant.conf)

cat << EOF >> ${wpa_supplicant}
network={
ssid="${ssid}"
psk="${pw}"
}
EOF

umount /mnt/disk1 /mnt/disk2

echo
echo "We're done!"
echo "You can now write the image to your SD card, see https://www.raspberrypi.org/documentation/installation/installing-images/README.md"
echo
