#!/bin/bash
# remove_old_kernels.sh
#
# http://markmcb.com/2013/02/04/cleanup-unused-linux-kernels-in-ubuntu/
#
# Lists all kernels, excludes installed kernel from the list, removes list of installed kernels
#
# NOTE: ONLY RUN AFTER INSTALLING A NEW KERNEL!

sudo dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge
