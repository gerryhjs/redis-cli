#!/bin/bash
ip="117.25.162.74"
port="26380"
password="starnet"
rm /tmp/allkeys.txt
echo "keys '*'" | redis-cli -h "$ip" -p "$port" -a "$password" 2>/dev/null >/tmp/allkeys.txt
for line in $(cat "/tmp/allkeys.txt"); do
  echo -e "key: ""$line""\c"
  echo -e "    key-value:""\c"
  echo "get $line" | redis-cli -h "$ip" -p "$port" -a "$password" 2>/dev/null
done
