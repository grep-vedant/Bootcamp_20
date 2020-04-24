#!/bin/bash
num=$(sudo docker images | awk '{ print $3 }' | sed '1d' | wc -l)
array=($(sudo docker images | awk '{ print $3 }' | sed '1d' | sort))
count=100
for (( i=0; $i<$num; i++ ))
do
            for ((j=$i+1; $j<$num; j++))
            do
                       if [[ ${array[$i]} == ${array[$j]} ]]
                        then
                              img_id=${array[$i]}
                              array[$j]=$count
                              img_name=$(sudo docker images | awk '{ print $1" "$3 }'| sed '1d' | grep $img_id | awk '{print $1}' | head -n 1)
                              sudo docker rmi $img_name
                              echo $img_id
                              count=`expr $count + 1`
                       fi
                done
done
