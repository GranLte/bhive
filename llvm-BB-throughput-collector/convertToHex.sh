#!/bin/bash

# Define the extract_opcodes function
# Note: Customize this function as per your actual use-case.
extract_opcodes() {
    local TEMP_FILE="$1"
    local OPCODES=$(objdump -d "$TEMP_FILE" | awk '/^[[:space:]]+[0-9a-f]+:/ { for(i=2; i<=NF; i++) if ($i ~ /^[0-9a-f]{2}$/) printf $i }')
    if [ -z "$OPCODES" ]; then
        echo "0"
    else
        echo "$OPCODES"
    fi
}

# Check if input and output files are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <INPUT_FILE> <OUTPUT_FILE>"
    exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="$2"
TEMP_FILE="temp.obj"

# Initialize variables
BB_CONTENT=""
BB_INDEX=""
IN_BB=0

> "$OUTPUT_FILE"

# Process the input file line by line
while IFS= read -r line; do
    if [[ "$line" == BB_* ]]; then
        if [ "$IN_BB" -eq 1 ]; then
            # Pass the block to llvm-mc to generate the object file
            llvm-mc -filetype=obj <<< "$BB_CONTENT" > "$TEMP_FILE"
            
            echo -n "$BB_INDEX " >> "$OUTPUT_FILE"
            # Extract opcodes and append to the output file
            extract_opcodes "$TEMP_FILE" >> "$OUTPUT_FILE"
        fi
        # Extract the BB index from the line and start a new BB
        BB_INDEX="${line//BB_/}"
        BB_CONTENT=""
        IN_BB=1
    elif [ "$IN_BB" -eq 1 ]; then
        # If we are inside a BB, concatenate the line to BB_CONTENT
        BB_CONTENT="$BB_CONTENT"$'\n'"$line"
    fi
done < "$INPUT_FILE"

# Process the last BB if it exists
if [ "$IN_BB" -eq 1 ]; then
    # Pass the block to llvm-mc to generate the object file
    llvm-mc-14 -filetype=obj <<< "$BB_CONTENT" > "$TEMP_FILE" 2> /dev/null

    echo -n "$BB_INDEX " >> "$OUTPUT_FILE"
    # Extract opcodes and append to the output file
    extract_opcodes "$TEMP_FILE" >> "$OUTPUT_FILE"
fi

# Cleanup
rm -f "$TEMP_FILE"

echo "Processing completed. Opcodes are saved to $OUTPUT_FILE."