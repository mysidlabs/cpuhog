#!/bin/bash

genload(){
    i=0
    while [ $i -lt $1 ]; do
        curl $2/calc
        echo $i
    i=$[$i+1]
    done
}

for i in $(seq 1 $1); do
    genload $2 $3 &
    echo Started thread $i
done