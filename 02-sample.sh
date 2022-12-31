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
