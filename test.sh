#!/bin/bash

genload(){
    i=1
    while [ $i -lt $1 ]; do
        curl localhost:8080
    i=$[$i+1]
    done
}

for i in {1..32}; do
    genload 32 &
done
