#!/bin/bash

# for list in val1 val2 val3 val4 val5; do
#      echo value is $list
# done  

for courses in devops aws gcp azure terraform ansible docker; do
     echo course name is $courses 
done 

#while loop : a conditional loop
i=10
while [ $i -lt 0 ] ; do
   echo "iteration number is $i"
      i=$(($i + 1))
done      