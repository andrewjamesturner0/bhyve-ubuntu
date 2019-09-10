#!/usr/bin/env bash

source common

_MAP=bhyve-ubuntu-14.04.map
_VHD=$(grep hd0 "$_MAP" | awk '{print $2}')

# grub-bhyve
sudo grub-bhyve \
    --device-map="$_MAP" \
    --root=hd0,msdos1 \
    --memory=1024 \
    "$_HOSTNAME"


# bhyve
sudo bhyve -A -H -P \
    -s 0:0,hostbridge \
    -s 1:0,lpc \
    -s 2:0,virtio-net,"$_NET" \
    -s 3:0,virtio-blk,"$_VHD" \
    -l com1,stdio \
    -c 2 \
    -m 1024M \
    "$_HOSTNAME"
