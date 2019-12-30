#!/bin/bash

genload(){
    i=1
    while [ $i -lt $1 ]; do
        curl $2
    i=$[$i+1]
    done
}

for i in {1..$1}; do
    genload $1 $2 &
    echo 11111
done
