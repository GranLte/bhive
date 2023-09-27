import subprocess
import re

def compile_llvm_to_x86_asm(llvm_file_path):
    """
    Reads an LLVM IR file, compiles it to x86 assembly using llc, and extracts all x86 basic blocks.

    Parameters:
    - llvm_file_path: Path to the LLVM IR file.

    Returns:
    - List of x86 basic blocks as strings.
    """

    # Step 1: Compile LLVM IR to x86 assembly
    try:
        asm_file_path = llvm_file_path.replace(".ll", ".s")
        subprocess.run(['llc', '-O0', llvm_file_path, '-o', asm_file_path], check=True)
    except subprocess.CalledProcessError as e:
        print(f"Compilation Error: {e}")
        return []

    # Step 2: Read the x86 assembly and extract basic blocks
    with open(asm_file_path, 'r') as asm_file:
        lines = asm_file.readlines()

    basic_blocks = []
    block = []
    in_data_section = False

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
                basic_blocks.append(block)
            block = [stripped_line]
        elif block and stripped_line.startswith(('j', 'ret')):  # Jump or return instructions indicating end of a basic block
            block.append(stripped_line)
            basic_blocks.append(block)
            block = []
        elif block and not stripped_line.startswith(('.size', '.cfi', '.type', '.p2align', '.globl')):  # Exclude certain directives but not labels
            block.append(stripped_line)

    # Add any remaining block
    if block and len(block) > 1:
        basic_blocks.append(block)

    return basic_blocks


# Test the function
BBs = compile_llvm_to_x86_asm("/u9/z277zhu/granLte/bhive/tests/harness.ll")
for block in BBs:
    for line in block:
        print(line)
    print('---')
print("Total number of basic blocks: " + str(len(BBs)) + "\n")