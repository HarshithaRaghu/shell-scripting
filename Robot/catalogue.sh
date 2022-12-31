#!/bin/bash

COMPONENT=catalogue

source Robot/common.sh 


echo -n "Configuring Nodejs repo: "
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -  &>> "${LOGFILE}"
yum install nodejs -y  &>> "${LOGFILE}"
stat $?

echo -n "creating application user $APPUSER :"
useradd $APPUSER  &>> "${LOGFILE}"  
stat $?

echo -n "downloading the $COMPONENT :"
curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip"
stat $?

echo -n "extracting the $COMPONENT: "
cd /home/roboshop
unzip -o /tmp/catalogue.zip  &>> "${LOGFILE}"
stat $?


# $ mv catalogue-main catalogue
# $ cd /home/roboshop/catalogue
# $ npm install





