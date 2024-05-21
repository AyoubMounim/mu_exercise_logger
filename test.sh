#!/bin/bash

function out(){
    [ $# -ne 1 ] && echo "Error"
}

var=($(cat "./exercises_backup.txt"))

echo ${#var[@]}

#read var1 var2 <<< $(out)
#echo "$var1, $var2"
