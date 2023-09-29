import llvmlite.binding as llvm

import llvmlite.binding as llvm

# Initialize the LLVM bindings
llvm.initialize()
llvm.initialize_native_target()
llvm.initialize_native_asmprinter()

def read_llvm_ir_file_filtered(filename, filter_out=[]):
    """
    Reads an LLVM IR file and returns a dictionary where keys are the names of LLVM IR basic blocks 
    and values are lists of instructions, filtering out specific instructions.

    Parameters:
    - filename: Path to the LLVM IR file.

    Returns:
    - Dictionary where keys are basic block names and values are lists of instructions.
    """
    # Load and parse the LLVM IR file
    with open(filename, 'r') as f:
        llvm_ir = f.read()

    module_ref = llvm.parse_assembly(llvm_ir)
    module_ref.verify()

    bb_to_instructions_map = {}

    # Iterate over functions and their basic blocks in the module
    for func in module_ref.functions:
        for block in func.blocks:
            # Assert all BB have a name
            assert(block.name and "Basic block doesn't have a name")
            
            # Filter out undesired instructions
            filtered_instructions = [instr for instr in block.instructions if instr.opcode not in filter_out]
            
            if filtered_instructions:
                bb_to_instructions_map[block.name] = filtered_instructions

    return bb_to_instructions_map

def pretty_print_dictionary(BBs):
    """
    Pretty print the dictionary containing basic blocks and their instructions.

    Parameters:
    - BBs: Dictionary where keys are basic block names and values are lists of instructions.
    """
    for bb_name, instructions in BBs.items():
        print(f"{bb_name}")
        for ins in instructions:
            print(f"    {ins}")
        print('---')
    print(f"Total number of basic blocks: {len(BBs)}\n")


# Test the function
BBs = read_llvm_ir_file_filtered("/u9/z277zhu/granLte/bhive/tests/harness_comment.ll")
pretty_print_dictionary(BBs)