#!/bin/bash

COMPONENT=mysql

source Robot/common.sh

echo -n "downloading the $COMPONENT : "
curl -s -L -o /etc/yum.repos.d/$COMPONENT.repo https://raw.githubusercontent.com/stans-robot-project/$COMPONENT/main/$COMPONENT.repo &>> "${LOGFILE}"
stat $?

echo -n "Installing $COMPONENT : "
yum install mysql-community-server -y &>> "${LOGFILE}"
stat $?

echo -n "starting $COMPONENT : "
systemctl enable mysqld &>> "${LOGFILE}"
systemctl start mysqld &>> "${LOGFILE}"
stat $?


