import llvmlite.binding as llvm

import llvmlite.binding as llvm

# Initialize the LLVM bindings
llvm.initialize()
llvm.initialize_native_target()
llvm.initialize_native_asmprinter()

def read_llvm_ir_file(filename):
    """
    Reads an LLVM IR file and returns a list of LLVM IR basic blocks.

    Parameters:
    - filename: Path to the LLVM IR file.

    Returns:
    - List of LLVM IR basic blocks as strings.
    """
    # Load and parse the LLVM IR file
    with open(filename, 'r') as f:
        llvm_ir = f.read()

    module_ref = llvm.parse_assembly(llvm_ir)
    module_ref.verify()

    basic_blocks = []

    # Iterate over functions and their basic blocks in the module
    for func in module_ref.functions:
        for block in func.blocks:
            # Convert each basic block to string and store in the list
            basic_blocks.append(str(block))

    return basic_blocks


# Test the function
BBs = read_llvm_ir_file("/u9/z277zhu/granLte/bhive/tests/harness.ll")
for block in BBs:
    print(block)
    print('---')
print("Total number of basic blocks: " + str(len(BBs)) + "\n")