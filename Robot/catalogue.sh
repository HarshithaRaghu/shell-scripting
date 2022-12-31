#!/bin/bash

COMPONENT=catalogue

source Robot/common.sh

echo -n "Configuring Nodejs repo: "
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -  &>> "${LOGFILE}"
yum install nodejs -y  &>> "${LOGFILE}"
stat $?

echo -n "creating application user $APPUSER :"
useradd $APPUSER &>> "${logfile}"
stat $?





