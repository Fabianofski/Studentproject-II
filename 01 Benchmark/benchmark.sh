#!/bin/bash

threads=(1 8 16 32 64)
commands=("node Node.js/main.js" "bun run Bun/main.js" "deno run Deno/main.js")

repetitions=10
mkdir -p results

for cmd in "${commands[@]}"; do
    runtime=$(echo $cmd | cut -d' ' -f1)
    echo "Benchmarking: $runtime"
    > results/$runtime.csv

    for threads in "${threads[@]}"; do
        echo "Threads: $threads"
        
        matrix=()
        echo "Metric for $threads threads:" >> results/$runtime.csv
        echo threads,n,real,user+sys,max_rss >> results/$runtime.csv
        for ((i=1; i<=$repetitions; i++)); do
            output=$( /usr/bin/time -v $cmd $threads 2>&1 )

            system_time=$(echo "$output" | grep 'System time' | cut -d':' -f2)
            elapsed_time=$(echo "$output" | grep 'Elapsed' | awk -F': ' '{print $2}' | tr -d ':')
            elapsed_time=$(echo "$elapsed_time" | sed 's/^0*//')
            user_time=$(echo "$output" | grep 'User time' | cut -d':' -f2)
            max_rss=$(echo "$output" | grep 'Maximum resident set size' | cut -d':' -f2)
            cpu_time=$(echo "$system_time + $user_time" | bc)

            row="$threads,$i,${elapsed_time}s,${cpu_time}s,${max_rss## }kb"
            matrix+=($row)
            echo $row >> results/$runtime.csv
        done
        
        echo >> results/$runtime.csv

        # Print matrix
        echo "Metric for $threads threads:"
        echo "threads,n,real,user+sys,max_rss"
        for result in "${matrix[@]}"; do
            echo "$result"
        done
        echo -e "\n"
    done
    threads=1
    echo -e "\n"
done 
