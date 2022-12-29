#!/bin/bash

COMPONENT=frontend
ID=$(id -u)
if [ $ID -ne 0 ] ; then
   echo -e "\e[31m you need to run script either as a root user or with a sudo privilege\e[0m"
   exit 1
fi

stat () {
   if [ $1 -eq 0 ]; then
    echo -e "\e[32m success \e[0m"
   else
    echo -e "\e[31m failure \e[0m"
   fi      
}

echo -n "Installing nginx: "
yum install nginx -y    &>> /tmp/frontend.log
stat $?    


systemctl enable nginx  &>> /tmp/frontend.log
echo -n "starting nginx: "
systemctl start nginx   &>> /tmp/frontend.log
stat $?     

echo -n "downloading the $COMPONENT"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?    
 
# cd /usr/share/nginx/html
# rm -rf *
# unzip /tmp/frontend.zip
# mv frontend-main/* .
# mv static/* .
# rm -rf frontend-main README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf


