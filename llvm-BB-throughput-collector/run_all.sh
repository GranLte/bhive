#!/bin/bash

# Check if directory and option are provided
if [[ -z "$1" ]]; then
    echo "Usage: $0 <source_directory>"
    exit 1
fi

# Ensure the provided directory exists
if [[ ! -d "$1" ]]; then
    echo "Error: Directory $1 does not exist."
    exit 1
fi

# Define a function to run run_one.sh for a single file
run_one_for_file() {
    echo "start processing $1"
    file="$1"
    # Assume the output file has the same path but a different extension (.perf)
    # Adjust this line as per your actual output file naming convention
    output_file="${file}.perf"

    # # Check if output exists; if it does, skip processing
    # if [[ -e "$output_file" ]]; then
    #     echo "Skipped: $file (output already exists)"
    #     return 0
    # fi

    # Ensure run_one.sh is executable
    if [[ ! -x run_one.sh ]]; then
        echo "Error: run_one.sh is not executable or not found in the current directory."
        exit 1
    fi
    
    # Run run_one.sh for the file
    ./run_one.sh "$file"
    
    # Check if run_one.sh was successful
    if [[ $? -ne 0 ]]; then
        echo "Error: run_one.sh failed for $file"
    else
        echo "Processed: $file"
    fi
}

export -f run_one_for_file

# Find all .bc files and pass them to run_one_for_file function
find "$1" -type f -name "*.bc" -print0 | xargs -0 -P 1 -n 1 -I {} bash -c 'run_one_for_file "$@"' _ {}
