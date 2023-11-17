#!/bin/bash

function caesar_cipter(){
    shift=$1
    input=$2
    output=$3
    
    while IFS=read -r -n1 char; do 

    if [[ $char =~ [a-zA-Z] ]]; then
        
        if [[ $char == [A-Z] ]]; then
         printf "%c" $(( (char - 65 + shift) % 26 + 65 )) >> $output 
        else
         printf "%c" $(( (char - 97 + shift) % 26 + 97 )) >> $output
        fi 
    else
        printf "%C" "'$char'" >> $output
    fi

    done < "$input"
    
}

shift=0
input=""
output=""

while getopts 's:i:o:' flag; do
  case "${flag}" in
    s) shift=${OPTARG} ;;
    i) input=${OPTARG} ;;
    o) output=${OPTARG} ;;
    *) error "Unexpected option ${flag}" ;;
  esac
done

if [[ -z $input || -z $output ]]; then
    echo "Usage: $0 -s <shift> -i <input file> -o <output file>"
    exit 1
fi

caesar_cipher $shift $input $output



