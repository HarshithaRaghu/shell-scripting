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

echo -n "clearing the default content :" 
cd /usr/share/nginx/html
rm -rf * &>> /tmp/frontend.log
stat $?

echo -n "extracting $COMPONENT :"
unzip /tmp/frontend.zip &>> /tmp/frontend.log
stat $?

echo -n "copying $COMPONENT : "
mv frontend-main/* . &>> /tmp/frontend.log
mv static/* . &>> /tmp/frontend.log
rm -rf frontend-main README.md &>> /tmp/frontend.log
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>> /tmp/frontend.log


