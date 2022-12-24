#!/bin/bash

DATE="24-12-2022"
DATE=$(date +%F)

echo "GoodMorning todays date is $DATE"
echo "Total number of opened sessions is $(who | wc -l)"

echo -e "Total number of opened sessions is \e[31m $(who | wc -l) \e[0m"

