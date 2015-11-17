#!/bin/bash
# author:wdfang
# date:2015-11-17
# version:1.0

# weblogic installation user
user=oracle
group=oracle

# weblogic installation directory
weblogic_home=/u01/app/oracle/Middleware

# check if user is root
if [ $(id -u) != "0" ]; then
    echo -e "\e[1;31;1m[Error]: You must be root to run this script, please use root to run it!\e[0m"
    exit 1
fi

# create group if not exists
egrep "^$group" /etc/group >& /dev/null
if [ $? -ne 0 ]
then
    groupadd $group
fi

# create user if not exists
egrep "^$user" /etc/passwd >& /dev/null
if [ $? -ne 0 ]; then
useradd -g $group $user
passwd $user << EOF
wisedu
wisedu
EOF
fi

# create installation directory
if [ ! -d "$weblogic_home" ]; then
mkdir -p /u01/jdk
mkdir -p /u01/backup
mkdir -p /u01/app/oracle
mkdir -p /u01/app/oracle/Middleware
mkdir -p /u01/app/oracle/oraInventory
chmod -R 755 /u01
chmod -R 755 /u01/jdk
chmod -R 755 /u01/app/oracle
chmod -R 755 /u01/app/oracle/Middleware
chmod -R 755 /u01/app/oracle/oraInventory
chown -R oracle:oracle /u01
chown -R oracle:oracle /u01/jdk
chown -R oracle:oracle /u01/backup
chown -R oracle:oracle /u01/app
chown -R oracle:oracle /u01/app/oracle
chown -R oracle:oracle /u01/app/oracle/Middleware
chown -R oracle:oracle /u01/app/oracle/oraInventory
echo -e "\e[1;32;1m[Success]:Weblogic installation directory to create success!\e[0m"
else
echo -e "\e[1;33;5m[Warning]:Weblogic installation directory already exists!\e[0m"
fi