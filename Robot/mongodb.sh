#!/bin/bash

 COMPONENT=mongodb

source common.sh

echo -n "downloading the $COMPONENT : "
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $?

echo -n "Installing $COMPONENT : "
yum install -y mongodb-org   &>> "${LOGFILE}"
stat $?

echo -n "starting $COMPONENT : "
systemctl enable mongod &>> "${LOGFILE}"
systemctl start mongod &>> "${LOGFILE}"
stat $?

echo -n "downloading the $COMPONENT schema : "
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?

echo -n "extracting the $COMPONENT schema files : "
cd /tmp
unzip -o mongodb.zip   &>> "${LOGFILE}"
stat $?

echo -n "injecting the schema : "
cd mongodb-main
mongo < catalogue.js   &>> "${LOGFILE}"
mongo < users.js       &>> "${LOGFILE}"
stat $?

