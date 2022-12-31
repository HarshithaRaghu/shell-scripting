#!/bin/bash

COMPONENT=user

source Robot/common.sh 

echo -n "Configuring and installing Nodejs repo: "
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> "${LOGFILE}"
yum install nodejs -y &>> "${LOGFILE}"
stat $?

id $APPUSER &>> "${LOGFILE}"
if [ $? -ne 0 ] ; then 
echo -n "creating application user $APPUSER :"
useradd $APPUSER  &>> "${LOGFILE}"  
stat $?
fi 

echo -n "downloading the $COMPONENT :"
curl -s -L -o /tmp/user.zip "https://github.com/stans-robot-project/user/archive/main.zip"
stat $?

echo -n "cleanup and extracting the $COMPONENT: "
rm -rf /home/$APPUSER/$COMPONENT/ 
cd /home/$APPUSER
unzip -o /tmp/user.zip &>>"${LOGFILE}"
stat $?

echo -n "changing the ownership to $APPUSER: "
mv /home/$APPUSER/$COMPONENT-main /home/$APPUSER/$COMPONENT
chown -R $APPUSER:$APPUSER /home/$APPUSER/$COMPONENT
stat $?

echo -n "installing $COMPONENT Dependencies: "
cd $COMPONENT
npm install &>> "${LOGFILE}"
stat $?

echo -n "configuring the $COMPONENT service: "
sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' /home/$APPUSER/$COMPONENT/systemd.service
mv /home/$APPUSER/$COMPONENT/systemd.service /etc/systemd/system/$COMPONENT.service 
stat $?

echo -n "starting $COMPONENT service: "
systemctl daemon-reload &>> "${LOGFILE}" 
systemctl enable $COMPONENT &>> "${LOGFILE}"
systemctl restart $COMPONENT &>> "${LOGFILE}"
stat $?

