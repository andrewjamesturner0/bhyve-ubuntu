#!/usr/bin/env bash

source common

_MAP=bhyve-ubuntu-14.04_install.map
_VHD=$(grep hd0 "$_MAP" | awk '{print $2}')
_ISO=$(grep cd0 "$_MAP" | awk '{print $2}')

# grub-bhyve
sudo grub-bhyve \
    --device-map="$_MAP" \
    --root=cd0 \
    --memory=1024 \
    "$_HOSTNAME"


# bhyve
sudo bhyve -A -H -P \
    -s 0:0,hostbridge \
    -s 1:0,lpc \
    -s 2:0,virtio-net,"$_NET" \
    -s 3:0,virtio-blk,"$_VHD" \
    -s 4:0,ahci-cd,"$_ISO" \
    -l com1,stdio \
    -c 2 \
    -m 1024M \
    "$_HOSTNAME"
