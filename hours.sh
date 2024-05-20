#!/bin/bash
# hours: script to count files by modification time

PROGNAME=${0##*/}

#usage massage
usage () {
    echo "$PROGNAME: usage: $PROGNAME directory " >&2
}

if [[ ! -d $1 || $# != 1 ]]; then 
    usage
    exit 1
fi

#Initialize hours array to maintain the number of files that manipulate in every hour
for i in {0..23}; do
    hours[i]=0
done

#Collect the information from the directory that passed
for i in ` stat -c %y $1/* | cut -c 12-13 `; do 
    j="${i#0}"
    ((++hours[j]))
    ((count++))
done

#Print the information
printf "Hour\tFiles\tHour\tFiles\n"
printf "====\t=====\t====\t=====\n"
for (( i=0; i <= 11; i++)) ; do
    j=$((${i}+12))
    printf "%02d\t${hours[$i]}\t$j\t${hours[$j]}\n" $i
done

printf "=============================\n"
printf "\nTotal files = %d\n" $count