#!/bin/bash

usage() {
    echo "Usage: $0 -o [ + | - | * | % ] -n numbers [-d]"
    exit 1
}

if [ $# -lt 4 ]; then
    usage
fi

operation=""
numbers=()
debug=0

while getopts ":o:n:d" opt; do
    case $opt in
        o) operation=$OPTARG ;;
        n) shift; while [[ $# -gt 0 && "$1" != "-"* ]]; do
               numbers+=("$1")
               shift
           done ;;
        d) debug=1 ;;
        \?) echo "Invalid option: -$OPTARG" >&2; usage ;;
        :) echo "Option -$OPTARG requires an argument." >&2; usage ;;
    esac
done

result=${numbers[0]}
for (( i = 1; i < ${#numbers[@]}; i++ )); do
    case $operation in
        +) result=$(($result + ${numbers[i]})) ;;
        -) result=$(($result - ${numbers[i]})) ;;
        \*) result=$(($result * ${numbers[i]})) ;;
        %) result=$(($result % ${numbers[i]})) ;;
        *) echo "Invalid operation: $operation"; exit 1 ;;
    esac
done

echo "Result: $result"

if [ $debug -eq 1 ]; then
    echo "User: $(whoami)"
    echo "Script: $0"
    echo "Operation: $operation"
    echo "Numbers: ${numbers[*]}"
fi
