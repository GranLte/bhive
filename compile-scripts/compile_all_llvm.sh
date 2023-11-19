#!/bin/bash

# Check if the directory and -jN flag are provided
if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: $0 <source_directory> -jN"
    exit 1
fi

# Ensure the provided directory exists
if [[ ! -d "$1" ]]; then
    echo "Error: Directory $1 does not exist."
    exit 1
fi

# Ensure the second parameter is a valid -jN flag
if [[ ! "$2" =~ ^-j[0-9]+$ ]]; then
    echo "Error: Second parameter must be -jN (e.g., -j4)"
    exit 1
fi

# Define a function to compile a single file
compile_file() {
    src_file="$1"
    out_file="${src_file%.cpp}.bc"
    
    # Check if out_file exists; if it does, skip compilation
    if [[ -e "$out_file" ]]; then
        echo "Skipped: $out_file"
        return 0
    fi

    # Compile the source file and generate the .ll file
    clang++-14 --std=c++17 \
        -I/u9/z277zhu/granLte/llvm-project/llvm/include \
        -I/u9/z277zhu/granLte/llvm-project/build/include \
         -emit-llvm -o "$out_file" "$src_file"

    # Check if clang++-14 command was successful
    if [[ $? -ne 0 ]]; then
        echo "Error: Compilation failed for $src_file"
        return 1
    else
        echo "Generated: $out_file"
        return 0
    fi
}

export -f compile_file

# Find all .cpp files and pass them to compile_file function in parallel
find "$1" -type f -name "*.cpp" -print0 | xargs -0 -P "${2#-j}" -n 1 -I {} bash -c 'compile_file "$@"' _ {}

