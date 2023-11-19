#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <llvm_file.bc>"
    exit 1
fi

# Assign the arguments to variables
LLVM_FILE="$1"

# Check if the provided llvm file exists
if [ ! -f "$LLVM_FILE" ]; then
    echo "Error: File $LLVM_FILE not found!"
    exit 1
fi

# Check if the provided llvm file is a .bc file
if [[ ! "$LLVM_FILE" =~ \.bc$ ]]; then
    echo "Error: File $LLVM_FILE is not a .bc file!"
    exit 1
fi


# Compile to hacked assembly
echo "Running llc-18"
/u9/z277zhu/llvm-18/llvm-project-2a1f1b5fde0a2e03f94fa2cb5c7765d405fda0de/build/bin/llc -O0 "$LLVM_FILE"  -o "$LLVM_FILE.s"
echo "Done running llc-18"

# Run the python script with the appropriate options
python main.py "$LLVM_FILE.s" "${LLVM_FILE}.perf"
