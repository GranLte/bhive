import subprocess
import re

def compile_llvm_to_x86_asm(llvm_file_path):
    """
    Reads an LLVM IR file, compiles it to x86 assembly using llc, and extracts all x86 basic blocks.

    Parameters:
    - llvm_file_path: Path to the LLVM IR file.

    Returns:
    - Path to the generated x86 assembly file.
    """
    # Compile LLVM IR to x86 assembly
    asm_file_path = llvm_file_path.replace(".ll", ".s")
    try:
        asm_file_path = llvm_file_path.replace(".ll", ".s")
        subprocess.run(['llc', '-march=x86-64', '-O0', llvm_file_path, '-o', asm_file_path], check=True)
    except subprocess.CalledProcessError as e:
        print(f"Compilation Error: {e}")

    return asm_file_path

def read_x86_BB(asm_file_path):
    """
    Reads an X86 file and extracts all x86 basic blocks.

    Parameters:
    - asm_file_path: Path to the ASM file.

    Returns:
    - List of x86 basic blocks as strings.
    """

    # Read the x86 assembly and extract basic blocks
    with open(asm_file_path, 'r') as asm_file:
        lines = asm_file.readlines()

    block = []
    in_data_section = False
    bb_to_asm_map = {}
    current_bb_name = None
    can_proceed = False

    for line in lines:
        stripped_line = line.strip()

        # Skip recording content if in the data section
        if stripped_line == ".data":
            in_data_section = True
            continue

        # Stop skipping content if leaving the data section
        elif stripped_line == ".text":
            in_data_section = False

        if in_data_section:
            continue

        if re.match(r'(\.LBB\d+_\d+:|# %bb\.\d+:)', stripped_line):  # Labels indicating start of a basic block
            if block and len(block) > 1:  # Save the previous block if exists and has more than just a label
                if not current_bb_name:
                    if len(block) > 5:
                        # if current BB has asm but no name, return error
                        print("Error: current_bb_name is None")
                        print(block)
                        return {}
                else:
                    bb_to_asm_map[current_bb_name]=block
                current_bb_name = None
            block = [stripped_line]
            can_proceed = True
        elif re.match(r'# LLVM BB: BB_\d+', stripped_line):  # Inline asm comments indicating BB_name
            if not can_proceed or current_bb_name:  # If we already encountered a BB_name in this block, skip the block
                current_bb_name = None
                block = []
                can_proceed = False
                continue
            current_bb_name = stripped_line.split(' ')[-1]  # Extract BB_name
            block.append(stripped_line)
        elif can_proceed and block and not (stripped_line.startswith(('.cfi', 'call', 'j', 'ret'))):  # Exclude certain directives but not labels
            block.append(stripped_line)

    # Add any remaining block
    if block:
        if not current_bb_name:
            if len(block) > 5:
                # if current BB has asm but no name, return error
                print("Error: current_bb_name is None")
                print(block)
                return {}
        else:
            bb_to_asm_map[current_bb_name]=block

    return bb_to_asm_map

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
asm_file = compile_llvm_to_x86_asm("/u9/z277zhu/granLte/bhive/tests/harness_comment.ll")
BBs = read_x86_BB(asm_file)
pretty_print_dictionary(BBs)