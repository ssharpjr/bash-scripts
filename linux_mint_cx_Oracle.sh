#!/bin/bash

# SPECIFY THE VIRTUALENV YOU WANT TO INSTALL cx_Oracle TO #
###########################################################

# Change this to whatever you want, but note that this script isn't going to make the virtualenv for you.
# It assumes the environment already exists.
MY_VIRTUAL_ENV='dynamic'

# INSTALL ORACLE INSTANT CLIENT'S DEPENDENCIES #
################################################

sudo apt-get install libaio-dev
 
# INSTALL ORACLE INSTANT CLIENT #
#################################

# Source for this section: http://www.gena01.com/forum/gena01-blog/oracle-instant-client-11g-on-ubuntu/
 
echo "
Go to the following URL: http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html
and get the following RPMs (we're going to convert them to debs):

    oracle-instantclient11.2-basic-11.2.0.3.0-1.x86_64.rpm
    oracle-instantclient11.2-sqlplus-11.2.0.3.0-1.x86_64.rpm
    oracle-instantclient11.2-devel-11.2.0.3.0-1.x86_64.rpm

WARNING: It's pretty annoying, they make you sign up for an Oracle account, etc.
I will assume you've put them in ~/Downloads.


Press any key once you're ready...
" && read -n 1 -s

cd ~/Downloads/oracleinstantclient
sudo alien oracle-instantclient11.2-basic-*.rpm
sudo alien oracle-instantclient11.2-devel-*.rpm
sudo alien oracle-instantclient11.2-sqlplus-*.rpm
sudo dpkg -i oracle-instantclient11.2-basic*.deb
sudo dpkg -i oracle-instantclient11.2-devel*.deb
sudo dpkg -i oracle-instantclient11.2-sqlplus*.deb

 
# SET ENVIRONMENT VARIABLES (ETC.) #
####################################
 
# Sources for this section:
# - http://cx-oracle.sourceforge.net/BUILD.txt
# - http://xiuxixiuxi.blogspot.com/2011/11/how-to-install-cxoracle-and-oracle.html
 
echo '
export ORACLE_HOME=/usr/local/lib/instantclient_11_2
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME
export PATH=$ORACLE_HOME:$PATH
' >> $HOME/.bashrc
. $HOME/.bashrc

ln -s $ORACLE_HOME/libclntsh.so.* $ORACLE_HOME/libclntsh.so
 
# ACTIVATE A VIRTUALENV THEN INSTALL cx_Oracle #
################################################

echo "
Here's a conundrum:
If you do 'pip install cx_Oracle',
you'll get a 'Permission denied' error.
But if you do 'sudo pip install cx_Oracle',
you'll get an error stating that your Oracle installation could not be found.
Unless you like to waste time,
I suggest you just start/activate a virtualenv,
and install there.
"

# workon $MY_VIRTUAL_ENV && pip install cx_Oracle
