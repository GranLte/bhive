import llvmlite.binding as llvm

import llvmlite.binding as llvm

# Initialize the LLVM bindings
llvm.initialize()
llvm.initialize_native_target()
llvm.initialize_native_asmprinter()

import re

def is_non_llvm_function_call(llvm_ir_line):
    """
    Check if the given LLVM IR line represents a (tail) call to a non-LLVM function 
    (ignoring inline assembly calls).

    Parameters:
    - llvm_ir_line: A line of LLVM IR as a string.

    Returns:
    - A boolean indicating whether the line represents a (tail) call to a non-LLVM function.
    - The called function name as a string or None if not a call or an LLVM function call.
    """
    # Regular expression pattern to match (tail) call instructions.
    # Example matches: `call i32 @function_name` or `tail call i32 @function_name`
    pattern = re.compile(r'(?:tail\s+)?call[^@]*@(\w+)\(')
    
    match = pattern.search(llvm_ir_line)
    
    if match and not match.group(1).startswith("llvm."):
        return True, match.group(1)  # Return True and the function name
    else:
        return False, None  # Return False and None for function name

def is_inline_asm_bb_label(llvm_ir_line):
    pattern = re.compile(r'call void asm sideeffect "# LLVM BB: BB_\d+"')
    return bool(pattern.match(llvm_ir_line.strip()))

def read_llvm_ir_file_filtered(filename, filter_out=['branch', 'jmp', 'br', 'ret']):
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
            
            # Initialize a flag for skipping blocks and an instruction container
            skip_block = False
            filtered_instructions = []
            
            for instr in block.instructions:
                # Convert instruction to string representation for regex matching
                instr_str = str(instr)
                
                # Check if it's a non-LLVM function call
                is_call, _ = is_non_llvm_function_call(instr_str)
                if is_call:
                    skip_block = True
                    break
                
                # Filter out undesired instructions
                if instr.opcode not in filter_out and not is_inline_asm_bb_label(instr_str):
                    filtered_instructions.append(instr)
            
            # If the block should not be skipped and has instructions, add to map
            if not skip_block and filtered_instructions:
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


# # Test the function
# BBs = read_llvm_ir_file_filtered("/u9/z277zhu/granLte/bhive/tests/harness_comment.ll")
# pretty_print_dictionary(BBs)