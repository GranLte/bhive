#!/bin/bash

# Check if directory and option are provided
if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: $0 <source_directory> <option> [-jN]"
    exit 1
fi

# Ensure the provided directory exists
if [[ ! -d "$1" ]]; then
    echo "Error: Directory $1 does not exist."
    exit 1
fi

# Ensure the option is valid
if [[ "$2" != "RUN_FIRST" && "$2" != "RUN_SECOND" && "$2" != "RUN_DEBUG" && "$2" != "RUN_UPGRADE" ]]; then
    echo "Error: Invalid option. Choose from RUN_FIRST, RUN_SECOND, RUN_DEBUG, or RUN_UPGRADE."
    exit 1
fi

# Ensure -jN flag is valid if provided
if [[ -n "$3" && ! "$3" =~ ^-j[0-9]+$ ]]; then
    echo "Error: Third parameter (if provided) must be -jN (e.g., -j4)"
    exit 1
fi

# Define a function to run run_one.sh for a single file
run_one_for_file() {
    file="$1"
    option="$2"
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
    ./run_one.sh "$file" "$option"
    
    # Check if run_one.sh was successful
    if [[ $? -ne 0 ]]; then
        echo "Error: run_one.sh failed for $file"
    else
        echo "Processed: $file"
    fi
}

export -f run_one_for_file

# Find all .ll files and pass them to run_one_for_file function in parallel
find "$1" -type f -name "*.ll" -print0 | xargs -0 -P "${3#-j}" -n 1 -I {} bash -c 'run_one_for_file "$@"' _ {} "$2"
