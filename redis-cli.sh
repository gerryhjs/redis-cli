#!/bin/bash

ip=$1
port=$2
password=$3

file="redis@""$ip"":""$port"".csv"
split="\""
rm ./"$file"
#test connection
echo "exit" | redis-cli -h "$ip" -p "$port" -a "$password"
#connect for keys*
echo "keys '*'" | redis-cli -h "$ip" -p "$port" -a "$password" 2>/dev/null >./keys.txt

echo "key,value,ttl" >>./"$file"
for line in $(cat "./keys.txt"); do
  echo -e "$split""$line""$split"",\c" >>./"$file"
  #  echo -e "     ""\c"
  value=$(echo "get $line" | redis-cli -h "$ip" -p "$port" -a "$password" 2>/dev/null)
  value="${value//$split/\"\"}"
  echo -e "$split""$value""$split"",\c">>./"$file"
  ttl=$(echo "ttl $line" | redis-cli -h "$ip" -p "$port" -a "$password" 2>/dev/null)
  echo "$split""$ttl""    ""$split">>./"$file"
done
rm ./keys.txt
