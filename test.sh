#!/bin/bash

EXERCISES=()
var=($(cat "./exercises.txt"))

for index in $(seq 0 $((${#var[@]}-1))); do
    EXERCISES+=($(($index+1)) ${var[$index]})
done

echo ${EXERCISES[@]}

#read var1 var2 <<< $(out)
#echo "$var1, $var2"
