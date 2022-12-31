#!/bin/bash

COMPONENT=mysql

source Robot/common.sh

echo -n "Configuring the $COMPONENT repo  : "
curl -s -L -o /etc/yum.repos.d/$COMPONENT.repo https://raw.githubusercontent.com/stans-robot-project/$COMPONENT/main/$COMPONENT.repo  &>> "${LOFGILE}"
stat $? 

echo -n "Installing $COMPONENT: "
yum install mysql-community-server -y   &>> "${LOFGILE}"
stat $? 

echo -n "Starting $COMPONENT : "
systemctl enable mysqld
systemctl start mysqld 
stat $? 

