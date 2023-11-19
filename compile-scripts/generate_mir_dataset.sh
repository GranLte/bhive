#!/bin/bash

# Define the directory for the extracted files
extracted_dir="$2"

# Create the directory if it does not exist
mkdir -p "$extracted_dir"

# Unzip and flatten files into the specified directory
unzip -j $1 -d "$extracted_dir"

# Change to the directory with the extracted files
cd "$extracted_dir"

# Loop through all *.ll files
for file in *.ll; do
    # Generate bytecode using llvm-mc
    llvm-as-14 "$file" -o "${file%.ll}.bc"

    # Generate .mir file using llc
    /u9/z277zhu/llvm-18/llvm-project-2a1f1b5fde0a2e03f94fa2cb5c7765d405fda0de/build/bin/llc -O0 -stop-after=phi-node-elimination "$file" -o "${file%.ll}.mir"
done
