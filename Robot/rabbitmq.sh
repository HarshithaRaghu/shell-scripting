#!/bin/bash

COMPONENT-rabbitmq

source Robot/common.sh

echo -n "Installing and configuring $COMPONENT repo"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash  &>> "${LOGFILE}"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>> "${LOGFILE}"
stat $? 

echo -n "Installing $COMPONENT : "
yum install rabbitmq-server -y &>> "${LOGFILE}"
stat $?

echo -n "Starting $COMPONENT :"
systemctl enable rabbitmq-server &>> "${LOGFILE}"
systemctl start rabbitmq-server  &>> "${LOGFILE}"
stat $? 
