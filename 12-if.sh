#!/bin/bash

# if condition
a="XYZ"
if [ "$a" == "XYZ" ]; then
   echo -e "\e[32m Both of them are equal \e[0m"
fi

# Demo on else if
c=$1
if [ "$c" -eq "10" ] ; then
    echo "value is c 10"
elif [ "$c" -eq "20" ] ; then
    echo "value is c 30"
elif [ "$c" -eq "30" ] ; then
    echo "value is c 30"
else 
    echo "value if not 10 or 20 or 30"
fi    
  