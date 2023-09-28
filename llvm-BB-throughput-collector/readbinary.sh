#!/bin/bash

# Name of the file containing basic blocks
BB_FILE="bbs.txt"

# Temporary file for the opcodes of each basic block
TEMP_FILE="temp.o"

# Final output file for opcodes
OUTPUT_FILE="opcodes.txt"

# Function to extract opcodes from an object file
extract_opcodes() {
    local objfile="$1"
    objdump -d "$objfile" | awk '/^[[:space:]]+[0-9a-f]+:/ { for(i=2; i<=NF; i++) if ($i ~ /^[0-9a-f]{2}$/) printf $i }'
    echo
}

# Empty the output file
> "$OUTPUT_FILE"

# Process each basic block
awk -v RS='---' '{print > ("block_" NR ".txt")}' "$BB_FILE"

for block in block_*.txt; do
    # Pass the block to llvm-mc to generate the object file
    llvm-mc -filetype=obj < "$block" > "$TEMP_FILE"
    
    # Extract opcodes and append to the output file
    extract_opcodes "$TEMP_FILE" >> "$OUTPUT_FILE"
    
    # Clean up the block file
    rm "$block"
done

# Clean up the temporary object file
rm "$TEMP_FILE"

echo "Opcodes written to $OUTPUT_FILE"