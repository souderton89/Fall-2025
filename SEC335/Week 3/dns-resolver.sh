#!/bin/bash
# Usage: ./dns_resolver.sh 10.0.5 10.0.5.22

prefix=$1
dns=$2

echo "dns resolution for $prefix"

for i in {1..254}; do
    nslookup $prefix.$i $dns 2>/dev/null | \
    awk -v ip=$prefix.$i '/name =/ {
        split(ip,a,".");
        printf "%s.%s.%s.%s.in-addr.arpa    name = %s\n", a[4],a[3],a[2],a[1],$4
    }'
done
