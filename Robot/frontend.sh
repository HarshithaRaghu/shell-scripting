#!/bin/bash

LOGFILE="/tmp/$COMPONENT.log"

set -e 
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

echo -n -e "\e[32m ________ $COMPONENT Configuration is starting ________ \e[0m"


echo -n "Installing nginx: "
yum install nginx -y    &>> "${LOGFILE}"
stat $?    


systemctl enable nginx  &>> "${LOGFILE}"
echo -n "starting nginx: "
systemctl start nginx   &>> "${LOGFILE}"
stat $?     

echo -n "downloading the $COMPONENT"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?  

echo -n "clearing the default content :" 
cd /usr/share/nginx/html
rm -rf * &>> "${LOGFILE}"
stat $?

echo -n "extracting $COMPONENT :"
unzip -o /tmp/frontend.zip &>> "${LOGFILE}"
stat $?

echo -n "copying $COMPONENT : "
mv frontend-main/* . &>> "${LOGFILE}"
mv static/* . &>> "${LOGFILE}"
rm -rf frontend-main README.md &>> "${LOGFILE}"
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>> "${LOGFILE}"
stat $?

for component in catalogue cart user shipping payment; do     # for loop 
    echo -n "Updating the $component backend reverse proxy dns records:"
    sed -i -e "/$component/s/localhost/$component.roboshop.internal/"  /etc/nginx/default.d/roboshop.conf  
    stat $? 
done

echo -n "restarting nginx: "
systemctl enable nginx  &>> "${LOGFILE}"
systemctl restart nginx   &>> "${LOGFILE}"
stat $? 







