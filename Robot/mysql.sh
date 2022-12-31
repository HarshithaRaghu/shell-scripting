#!/bin/bash

COMPONENT=mysql

source Robot/common.sh

echo -n "Configuring the $COMPONENT repo  : "
curl -s -L -o /etc/yum.repos.d/mysqld.repo https://raw.githubusercontent.com/stans-robot-project/mysql/main/mysql.repo  &>> "${LOGFILE}"
stat $? 

echo -n "Installing $COMPONENT: "
yum install mysql-community-server -y   &>> "${LOGFILE}"
stat $? 

echo -n "Starting $COMPONENT : "
systemctl enable mysqld
systemctl start mysqld 
stat $? 

echo -n "fetching the default password: "
DEFAULT_ROOT_PWD=$(grep 'A temporary password' /var/log/mysqld.log | awk '{print $NF}')
stat $?

# This should happen only if the default password is not changed, rest of the times, I don't want to change it.
echo show databases | mysql -uroot -pRoboShop@1 &>> "${LOGFILE}"
if [ $? -ne 0 ]; then 
    echo -n "Resetting the default root password : "
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';" | mysql  --connect-expired-password -uroot -p${DEFAULT_ROOT_PWD} &>> "${LOGFILE}"
    stat $?
fi     