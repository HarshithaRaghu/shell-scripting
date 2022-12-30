#!/bin/bash

LOGFILE="/tmp/$COMPONENT.log"

set -e 
COMPONENT=mongodb
ID=$(id -u)
if [ $ID -ne 0 ] ; then
   echo -e "\e[31m you need to run script either as a root user or with a sudo privilege\e[0m"
   exit 1
fi

stat () {
   if [ $1 -eq 0 ]; then
    echo -e "\e[32m success \e[0m"
   else
    echo -e "\e[31m failure \e[0m"
   fi      
}

echo -n "downloading the $COMPONENT : "
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $?

echo -n "Installing $COMPONENT : "
yum install -y mongodb-org   &>> "${LOFGILE}"
stat $?

echo -n "starting $COMPONENT : "
systemctl enable mongod
systemctl start mongod
stat $?

echo -n "downloading the $COMPONENT schema : "
curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
stat $?

echo -n "extracting the $COMPONENT schema files : "
cd /tmp
unzip -o mongodb.zip   &>> "${LOFGILE}"
stat $?

echo -n "injecting the schema : "
cd mongodb-main
mongo < catalogue.js   &>> "${LOFGILE}"
mongo < users.js       &>> "${LOFGILE}"
stat $?