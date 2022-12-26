#!/bin/bash

sample() {
    echo " I am a sample function"
    echo "sample function is completed"
}
# calling the function
sample 

# calling the function second time
sample

#calling the function third time
sample 

stat() {
    echo "number of opened sessions : (who | wc -l)"
    echo "today's date is : $(date +%F)"
    echo "load average on the system in last 1 minute :  uptime | awk -F : '{print $NF}' | awk -F , '{print $1}' "
}

#calling the function
stat