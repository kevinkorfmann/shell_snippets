#!/bin/bash

# Static input fo N 
N=$1 
  
# First Number of the 
# Fibonacci Series 
a=0 
  
# Second Number of the 
# Fibonacci Series 
b=1  
   
echo "The Fibonacci series is : "
   
for (( i=0; i<N; i++ )) 
do
    echo "$a "
    sleep 1
    fn=$((a + b)) 
    a=$b 
    b=$fn 
done
# End of for loop 
