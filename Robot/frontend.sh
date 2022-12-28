#!/bin/bash

UID=$(id -u)
if [ $UID -ne 0 ] ; then
   echo -e "\e[31m you need to yun script either as a root user or with a sudo privilege\e[0m"
   exit 1
if 

yum install nginx -y
systemctl enable nginx
systemctl start nginx
