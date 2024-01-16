#!/bin/bash

# Cheap and dirty script to get, verify, and decompress the Linux kernel source code.
# Prerequisites:
# - Programs: wget, gpg2, xz, tar
# - GPG keys: `gpg2 --locate-keys torvalds@kernel.org gregkh@kernel.org`


URL_PREFIX="https://cdn.kernel.org/pub/linux/kernel"
KSERIES="v4.x"
KVERSION=$1
KXZFILE=linux-$KVERSION.tar.xz
KTFILE=linux-$KVERSION.tar
KSFILE=linux-$KVERSION.tar.sign
KURL=$URL_PREFIX/$KSERIES/$KXZFILE
KSURL=$URL_PREFIX/$KSERIES/$KSFILE

# The next steps are all done in sequence so that if one step fails, it stops.
# Get source and sign file, decompress source, verify signature, untar source, delete downloads.
echo -e "\n*** Downloading kernel source and signature file" && wget $KURL && wget $KSURL && echo -e "\n*** Decompressing kernel source"  && unxz -v $KXZFILE && echo -e "\n*** Verifying source"  && gpg2 --verify $KSFILE && echo -e "\n*** Untarring source"  && tar xf $KTFILE && echo -e "\n*** Cleaning up"  && rm $KTFILE $KSFILE && echo -e "\n*** Done"

