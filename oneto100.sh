#!/bin/bash

COUNTER=0

while [ $COUNTER -lt 100 ]; do 
    if (( $COUNTER % 3 == 0 && $COUNTER % 5 == 0 )); then
        echo "FizzBuzz"
    elif (( $COUNTER % 3 == 0 )); then
        echo "Fizz"
    elif (( $COUNTER % 5 == 0 )); then
        echo "Buzz"
    else
        echo $COUNTER
    fi
    (( COUNTER++ ))
done
