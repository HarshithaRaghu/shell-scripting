#!/bin/bash

ID=$(id -u)
if [ $ID -ne 0 ] ; then
   echo -e "\e[31m you need to run script either as a root user or with a sudo privilege\e[0m"
   exit 1
fi

echo "Installing nginx: "
yum install nginx -y    &>> /tmp/frontend.log
if [ $? -eq 0 ]; then
   echo -e "\e[32m success \e[0m"
else
   echo -e "\e[31m failure \e[0m"
fi      


systemctl enable nginx  &>> /tmp/frontend.log
echo "starting nginx: "
systemctl start nginx   &>> /tmp/frontend.log
if [ $? -eq 0 ]; then
   echo -e "\e[32m success \e[0m"
else
   echo -e "\e[31m failure \e[0m"
fi       

