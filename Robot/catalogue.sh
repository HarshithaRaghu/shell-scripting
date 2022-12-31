#!/bin/bash

COMPONENT=catalogue

source Robot/common.sh 


echo -n "Configuring Nodejs repo: "
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -  &>> "${LOGFILE}"
yum install nodejs -y  &>> "${LOGFILE}"
stat $?

id $APPUSER &>> "${LOGFILE}"
if [ $? -ne 0 ] ; then 
echo -n "creating application user $APPUSER :"
useradd $APPUSER  &>> "${LOGFILE}"  
stat $?
fi 
echo -n "downloading the $COMPONENT :"
curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip"
stat $?

echo -n "extracting the $COMPONENT: "
cd /home/roboshop
unzip -o /tmp/catalogue.zip  &>> "${LOGFILE}"
stat $?

echo -n "changing the ownership to $APPUSER: "
mv /home/$APPUSER/$COMPONENT-main /home/$APPUSER/$COMPONENT
chown $APPUSER:$APPUSER /home/$APPUSER/$COMPONENT
stat $?

# $ mv catalogue-main catalogue
# $ cd /home/roboshop/catalogue
# $ npm install





