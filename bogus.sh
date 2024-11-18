#!/bin/bash

cat /etc/hosts | while read line; do
	
	if [ "${line:0:1}" == "" ]; then
		break
	fi
	
	ip=$(echo $line | cut -d " " -f 1)
	address=$(echo $line | cut -d " " -f 2)
	
	i=1
	nslookup $address | while read line2; do
		
		if [ $i -lt 5 ]; then
			((i++))
			continue
		fi
		
		ip2=$(echo $line2 | cut -d " " -f 2)
		
		if [ ! "$ip" == "$ip2" ]; then
			echo "Bogus IP for $address in /etc/hosts !"
		else
			echo "$address has good ip"
		fi
		break
	done
done 

