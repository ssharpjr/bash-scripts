#!/bin/bash

BD=$1
PART="${BD}1"

# Welcome
echo ""
echo "Fight Flash Fraud (F3) SD Card Checker"
echo "--------------------------------------"
echo ""
echo "This script runs the following tasks:"
echo "- Mount selected partition to /media"
echo "- Run f3write on /media"
echo "- Run f3read on /media"
echo "- Unmounts /media"
echo "- Runs f3probe on selected block device"

# Must be run as root!
if [[ $EUID -ne 0 ]]; then
    echo ""
    echo "*** ERROR: Must be run as root! ***"
    echo ""
    exit 1
fi

# Usage check
if [[ -z "$1" ]]; then
    echo ""
    echo "Usage $0 /dev/<BLOCK_DEVICE>"
    echo ""
    echo "Run with the device you are testing."
    echo "Example: $0 /dev/sdb"
    echo "Use 'lsblk' to find your block device"
    echo ""
    exit 1
fi

# Check for f3
F3=$(which f3write)
if [[ -z "$F3" ]]; then
  echo "*** ERROR: f3 does not appear to be installed. ***"
  echo "Run 'sudo apt install f3 -y' to install it."
  exit 1
fi

# Send warning and give an option to abort
echo ""
echo "WARNING: This script will destroy all data on $BD !"
read -p "Press ENTER to continue or CTRL+C to cancel."
echo ""

# Run the commands in one line so it stops if a command fails
sudo mount $PART /media && sudo f3write /media && sudo f3read /media && sudo umount /media && sudo f3probe --destructive --time-ops $BD
