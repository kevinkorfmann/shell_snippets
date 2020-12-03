#!/bin/bash

NR_CPUS=5

count=0
for i in {1..20}; do
	./fib.sh 10 &
	let count+=1
	[[ $((count%NR_CPUS)) -eq 0 ]] && wait
done
