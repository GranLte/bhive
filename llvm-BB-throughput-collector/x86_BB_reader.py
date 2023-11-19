def read_x86_BB(asm_file_path):
    """
    Reads an X86 file and extracts all x86 basic blocks.

    Parameters:
    - asm_file_path: Path to the ASM file.

    Returns:
    - List of x86 basic blocks as strings.
    """

    basic_blocks = {}
    current_bb = None
    current_instructions = []

    with open(asm_file_path, 'r') as file:
        for line in file:
            if line.startswith('#@@@ BB_'):
                # Save the previous basic block
                if current_bb is not None:
                    basic_blocks[current_bb] = current_instructions
                # Start a new basic block
                current_bb = line.strip().split(' ')[1]
                current_instructions = []
            elif line.strip() == '#@@@EOB':
                # End of basic block, save it
                if current_bb is not None:
                    basic_blocks[current_bb] = current_instructions
                current_bb = None
            elif current_bb is not None:
                # Add instruction to the current basic block
                current_instructions.append(line.strip())

    return basic_blocks

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
