#!/bin/bash

COMPONENT=mysql

source Robot/common.sh

echo -n "downloading the $COMPONENT : "
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/stans-robot-project/mysql/main/mysql.repo &>> "${LOGFILE}"
stat $?

echo -n "Installing $COMPONENT : "
yum install mysql-community-server -y 
stat $?

echo -n "starting $COMPONENT : "
systemctl enable mysqld 
systemctl start mysqld 
stat $?
