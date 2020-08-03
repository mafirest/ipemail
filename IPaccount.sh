#!/bin/bash

read -p "The domain name: " domain  
read -p  "input your name: " name
read -p "input your account: " account
###CAUTION!
#should compare with exiting account list in here to check available account name, this is just demo
read -sp  "password for initial: " password

#########################################################
#####CREAT USER ACCOUNT #### 

echo "creating your account ..."
sudo docker-compose -p mailu exec admin flask mailu user $account $domain $password

echo "done."

############################################################
##### CREAT ALIAS ACCOUNT #####
read -p "The number of alias:" number  
echo "The start point in the range of alias IP emails: " 
read -a ipArr

for ((i=0;i<$number;i+=1));
do
        ipmail="${ipArr[0]}.${ipArr[1]}.${ipArr[2]}.${ipArr[3]}"
        echo "Creating the IP email: $ipmail@$domain ..."
        sudo docker-compose -p mailu exec admin flask mailu alias $ipmail $domain "$account@$domain"
        (( ipArr[3]++ ))
done
echo "done."
