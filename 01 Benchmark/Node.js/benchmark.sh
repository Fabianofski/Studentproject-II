#!/bin/bash

threads=(1 8 16 32 64)

results=()

for threads in "${threads[@]}"; do
    echo "Threads: $threads"
    output=$( /usr/bin/time -v node main.js $threads 2>&1 )

    system_time=$(echo "$output" | grep 'System time' | cut -d':' -f2)
    elapsed_time=$(echo "$output" | grep 'Elapsed' | awk -F': ' '{print $2}')
    user_time=$(echo "$output" | grep 'User time' | cut -d':' -f2)
    max_rss=$(echo "$output" | grep 'Maximum resident set size' | cut -d':' -f2)
    cpu_time=$(echo "$system_time + $user_time" | bc)

    results+=("$threads,${elapsed_time}s,${cpu_time}s,${max_rss## }kb")
done

# Print matrix
echo "n,real,user+sys,max_rss"
for result in "${results[@]}"; do
    echo "$result"
done
