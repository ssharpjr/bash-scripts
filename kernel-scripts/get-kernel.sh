#!/bin/bash

# Cheap and dirty script to get, verify, and decompress the Linux kernel source code.
# Prerequisites:
# - Programs: wget, gpg2, xz, tar
# - GPG keys: `gpg2 --locate-keys torvalds@kernel.org gregkh@kernel.org`


URL_PREFIX="https://cdn.kernel.org/pub/linux/kernel"
KVERSION=$1
KSERIES="v$(echo $KVERSION | awk -F '.' '{print $1}').x"
KXZFILE=linux-$KVERSION.tar.xz
KTFILE=linux-$KVERSION.tar
KSFILE=linux-$KVERSION.tar.sign
KURL=$URL_PREFIX/$KSERIES/$KXZFILE
KSURL=$URL_PREFIX/$KSERIES/$KSFILE

# Verify user input
if [ -z $1 ]; then
  echo -e "\n*** Missing kernel version."
  echo -e "Usage: $0 <KERNEL_VERSION>"
  echo -e "Example: $0 6.6.10\n"
  exit 1
fi

# The next steps are all done in sequence so that if one step fails, it stops.
# Get source and sign file, decompress source, verify signature, untar source, delete downloads.
# echo -e "\n*** Downloading kernel source and signature file" && wget $KURL && wget $KSURL && echo -e "\n*** Decompressing kernel source"  && unxz -v $KXZFILE && echo -e "\n*** Verifying source"  && gpg2 --verify $KSFILE && echo -e "\n*** Untarring source"  && tar xf $KTFILE && echo -e "\n*** Cleaning up"  && rm $KTFILE $KSFILE && echo -e "\n*** Done"
echo $KVERSION
echo $KSERIES
echo $KURL

exit 0
