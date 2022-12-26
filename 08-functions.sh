#!/bin/bash

stat() {
    echo "number of opened sessions : $(who | wc -l)"
    echo "today's date is : $(date +%F)"
    echo "load average on the system in last 1 minute :  $(uptime | awk -F : '{print $NF}' | awk -F , '{print $1}')"
}

#calling stat function
stat