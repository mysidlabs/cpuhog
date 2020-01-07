#!/bin/bash

genload(){
    i=1
    while [ $i -le $1 ]; do
        echo $(curl -s $2/calc) "," | tee -a $j | jq 2> /dev/null
    i=$[$i+1]
    done
}

t=$1
l=$2
u=$3
j=$(mktemp)

echo "[" > $j

for i in $(seq 1 $t); do
    echo Starting threads $i...
    genload $l $u &
done

wait && echo "{}]" >> $j

echo -e "Summary...\n\n   # Pod"
jq -r '[ .[] | select(length>0) ] | .[].ip_addresses[1]' $j | sort -i | uniq -c

[[ -f "$j" ]] && rm $j