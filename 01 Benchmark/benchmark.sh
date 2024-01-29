#!/bin/bash

threads=(1 8 16 32 64)
commands=("node Node.js/main.js" "bun run Bun/main.js" "deno run Deno/main.js")

repetitions=10

mkdir -p results
> results/averages.csv

for cmd in "${commands[@]}"; do
    runtime=$(echo $cmd | cut -d' ' -f1)
    echo "Benchmarking: $runtime"

    > results/$runtime.csv

    echo $runtime >> results/averages.csv
    echo threads,real,user+sys,max_rss >> results/averages.csv

    for threads in "${threads[@]}"; do
        echo "Threads: $threads"
        
        matrix=()
        echo "Metrics for $threads $runtime threads:" >> results/$runtime.csv
        echo n,real,user+sys,max_rss >> results/$runtime.csv
        for ((i=1; i<=$repetitions; i++)); do
            output=$( /usr/bin/time -v $cmd $threads 2>&1 )

            system_time=$(echo "$output" | grep 'System time' | cut -d':' -f2)
            elapsed_time=$(echo "$output" | grep 'Elapsed' | awk -F': ' '{print $2}' | tr -d ':')
            elapsed_time=$(echo "$elapsed_time" | sed 's/^0*//')
            user_time=$(echo "$output" | grep 'User time' | cut -d':' -f2)
            max_rss=$(echo "$output" | grep 'Maximum resident set size' | cut -d':' -f2)
            cpu_time=$(echo "$system_time + $user_time" | bc)

            row="$i,${elapsed_time}s,${cpu_time}s,${max_rss## }kb"
            matrix+=($row)
            echo $row >> results/$runtime.csv
        done
        
        # Calculate averages
        avg_elapsed_time=0
        avg_cpu_time=0
        avg_max_rss=0
        count=${#matrix[@]}

        for result in "${matrix[@]}"; do
            elapsed_time=$(echo "$result" | cut -d',' -f2 | sed 's/s//')
            cpu_time=$(echo "$result" | cut -d',' -f3 | sed 's/s//')
            max_rss=$(echo "$result" | cut -d',' -f4 | sed 's/kb//')

            avg_elapsed_time=$(echo "$avg_elapsed_time + $elapsed_time" | bc)
            avg_cpu_time=$(echo "$avg_cpu_time + $cpu_time" | bc)
            avg_max_rss=$(echo "$avg_max_rss + $max_rss" | bc)
        done

        avg_elapsed_time=$(echo "scale=2; $avg_elapsed_time / $count" | bc)
        avg_cpu_time=$(echo "scale=2; $avg_cpu_time / $count" | bc)
        avg_max_rss=$(echo "scale=2; $avg_max_rss / $count" | bc)
        
        # Add averages to matrix
        avg_row="Average,${avg_elapsed_time}s,${avg_cpu_time}s,${avg_max_rss}kb"
        matrix+=($avg_row)
        echo $avg_row >> results/$runtime.csv
        echo "$threads,${avg_elapsed_time}s,${avg_cpu_time}s,${avg_max_rss}kb" >> results/averages.csv
        
        echo >> results/$runtime.csv

        # Print matrix
        echo "Metrics for $threads $runtime threads:"
        echo "n,real,user+sys,max_rss"
        for result in "${matrix[@]}"; do
            echo "$result"
        done
        echo -e "\n"
    done
    threads=1
    echo >> results/averages.csv
    echo -e "\n"
done 
