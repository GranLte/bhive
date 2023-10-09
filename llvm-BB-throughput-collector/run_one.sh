#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <llvm_file.ll> <option> [injection_pass]"
    exit 1
fi

# Assign the arguments to variables
LLVM_FILE="$1"
OPTION="$2"

# Optional injection pass, if provided
INJECTION_PASS="${3:-/u9/z277zhu/granLte/bhive/llvm-BB-mapping-pass/build/lib/libInjectAsmComments.so}"

# Check if the provided llvm file exists
if [ ! -f "$LLVM_FILE" ]; then
    echo "Error: File $LLVM_FILE not found!"
    exit 1
fi

# Check if the option is valid
if [ "$OPTION" != "RUN_FIRST" ] && [ "$OPTION" != "RUN_SECOND" ] && [ "$OPTION" != "RUN_DEBUG" ] && [ "$OPTION" != "RUN_UPGRADE" ]; then
    echo "Error: Invalid option. Choose from RUN_FIRST, RUN_SECOND, RUN_DEBUG, or RUN_UPGRADE."
    exit 1
fi

# If RUN_FIRST is chosen
if [ "$OPTION" == "RUN_FIRST" ]; then
    
    # Check if the injection pass argument is provided
    if [ -z "$INJECTION_PASS" ]; then
        echo "Error: Injection pass argument is required for RUN_FIRST option."
        exit 1
    fi
    
    # Run the opt-14 -O3 optimization
    opt-14 -O3 "$LLVM_FILE" -S -o "$LLVM_FILE"

    # Run the injection pass
    opt-14 -load-pass-plugin="$INJECTION_PASS" -passes="inject-asm-comments" $LLVM_FILE -S -o $LLVM_FILE

    # Set the file to be processed in the python script
    PROCESSED_FILE="$LLVM_FILE"
else
    # Set the file to be processed in the python script as the input llvm file
    PROCESSED_FILE="$LLVM_FILE"
fi

# If RUN_SECOND or RUN_FIRST is chosen, set python option to RELEASE
if [ "$OPTION" == "RUN_SECOND" ] || [ "$OPTION" == "RUN_FIRST" ]; then
    PYTHON_OPTION="RELEASE"
else
    # Otherwise, map the bash script option to the python script option
    PYTHON_OPTION="${OPTION#RUN_}"
fi

# Run the python script with the appropriate options
python main.py "$PROCESSED_FILE" "$PYTHON_OPTION" "${LLVM_FILE}.perf"
