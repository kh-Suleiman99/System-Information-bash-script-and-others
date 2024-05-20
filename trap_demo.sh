#!/bin/bash
# trap_demo.sh: simple signal handling demo
# will execute an echo command each time either the SIGINT or SIGTERM signal is received while the script is running.

trap "echo -e '\nI am ignoring you.'" SIGINT
trap "echo -e '\nScript terminated.'" SIGTERM

for i in {1..5}; do
    echo "Iteration $i of 5"
    sleep 5
done