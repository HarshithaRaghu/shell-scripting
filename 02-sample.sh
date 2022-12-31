#!/bin/bash
#SheBang Notation tells the interpretor what the code and based on that it will understand and compile/run the script
#You can have only one SheBang Notation per script and should always be the first file or start of the script
#Apart from the SheBang Notation anything that starts with '#' is referred as a comment

#comments are just for hte human readable purpose only

echo "Hello world" 
echo -e "line1\nline2\nline3\tlinux\tlipe\tlow"

echo show plugins | mysql -uroot -pRoboShop@1 | grep validate_password;   &>> "${LOGFILE}"
if [ $? -eq 0 ]; then 
    echo -n "Uninstalling Password Validate Plugin "
    echo "show plugins;"|  mysql -uroot -pRoboShop@1 | grep validate_password  &>> "${LOGFILE}"
    stat $?
fi 


# This should happen only if the default password is not changed, rest of the times, I don't want to change it.
echo show databases | mysql -uroot -pRoboShop@1 &>> "${LOGFILE}"
if [ $? -ne 0 ]; then 
    echo -n "Resetting the default root password : "
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';" | mysql  --connect-expired-password -uroot -p${DEFAULT_ROOT_PWD} &>> "${LOGFILE}"
    stat $?
fi 