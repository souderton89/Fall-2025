#!/bin/bash
#hostfile=$1
#portfile=$2
###for host in {1..254}
#do 
#    timeout .1 bash -c "echo >/dev/tcp/${hostfile}.${host}/$portfile"
#done


#!/bin/bash
# Usage: ./scanner.sh 10.0.5 53

prefix=$1   # e.g., 10.0.5
port=$2     # e.g., 53

for host in {1..254}
do
    ip="${prefix}.${host}"
    timeout 0.1 bash -c "echo >/dev/tcp/${ip}/${port}" 2>/dev/null \
    && echo "Port $port open on $ip"
done
