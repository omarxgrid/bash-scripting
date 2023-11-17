#!/bin/bash

fib(){

  echo "Please enter a number to calculate the Fibonacci sequence:"
  read -r n

  if [ "$n" -eq 0 ]; then
     echo 0
  elif [ "$n" -eq 1 ]; then
     echo 1
  else
    a=0
    b=1
    for(( i=2; i<=n; i++ )); do
        c=$((a+b))
        a=$b
        b=$c
    done
    echo "$c"
  fi

}

fib