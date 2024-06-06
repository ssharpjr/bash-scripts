#!/bin/bash
# ID this Pi!

echo""
echo "Raspberry Pi Name:"
hostname

echo ""
echo "Raspberry Pi Model:"
cat /proc/cpuinfo | grep Hardware
cat /proc/cpuinfo | grep Revision
cat /proc/cpuinfo | grep Serial

echo ""
echo "Networking:"
# echo IP Address: `hostname -I`
ifconfig | grep Bcast | awk '{ print $2 "\t" $4 }'
ifconfig | grep HWaddr | awk '{ print $1 ": " $4 " " $5 }'

echo ""
echo "Storage:"
df -h | grep /dev/root
df -h | grep /dev/mmc

echo ""
