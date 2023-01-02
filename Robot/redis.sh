#!/bin/bash

COMPONENT=redis
source Robot/common.sh


echo -n "downloading the $COMPONENT repo : "
curl -L https://raw.githubusercontent.com/stans-robot-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo &>> "${LOGFILE}"
stat $?

echo -n "installing $COMPONENT: "
yum install redis-6.2.7 -y &>> "${LOGFILE}"
stat $?

echo -n "whitelisting the $COMPONENT: " 
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf
stat $?

echo -n "starting $COMPONENT service: "
systemctl daemon-reload &>> "${LOGFILE}" 
systemctl enable $COMPONENT &>> "${LOGFILE}"
systemctl restart $COMPONENT &>> "${LOGFILE}"
stat $?


