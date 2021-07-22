#!/bin/bash
#ip="localhost"
#port="6379"
#password=""
#ip="117.25.162.74"
#port="26380"
#password="starnet"

ip="192.168.78.62"
port="6380"
password="starnet"

rm /tmp/allkeys.txt
rm ./out.csv
echo "keys '*'" | redis-cli -h "$ip" -p "$port" -a "$password" 2>/dev/null >/tmp/allkeys.txt

echo "key;value" >>./out.csv
for line in $(cat "/tmp/allkeys.txt"); do
  echo -e "$line"";""\c" >>./out.csv
  #  echo -e "     ""\c"
  value=$(echo "get $line" | redis-cli -h "$ip" -p "$port" -a "$password" 2>/dev/null)
  value="${value//\"/\'}"
  echo "\"""$value""\"">>./out.csv
  #  echo -e "ttl:""\c"
  #  echo "ttl $line" | redis-cli -h "$ip" -p "$port" -a "$password" 2>/dev/null
done
