from llvm_BB_reader import read_llvm_ir_file_filtered
from x86_BB_reader import compile_llvm_to_x86_asm, read_x86_BB
import subprocess
import os

def pretty_print(result_list):
    """
    Pretty prints the result list.

    Parameters:
    - result_list: List of tuples containing (BB_name, llvm_instructions, x86_instructions).
    """
    for bb_name, llvm_instructions, x86_instructions in result_list:
        print("BB Name:", bb_name)
        print("-" * 50)
        print("LLVM Instructions:")
        for instr in llvm_instructions:
            print(instr)
        print("\nX86 Instructions:")
        for instr in x86_instructions:
            print(instr)
        print("=" * 100)


def main():
    # Provide the path to your .ll file
    llvm_file_path = "/u9/z277zhu/granLte/bhive/tests/harness_comment.ll"
    output_file_path = "output.txt"  # TODO: Update the output path as required
    # 1. Read LLVM IR File
    llvm_BB_map = read_llvm_ir_file_filtered(llvm_file_path)

    # 2. Compile LLVM to x86 asm
    asm_file_path = compile_llvm_to_x86_asm(llvm_file_path)

    # 3. Read x86 BB
    x86_BB_map = read_x86_BB(asm_file_path)

    # 4. Iterate and match
    result_list = []
    for key, value in llvm_BB_map.items():
        if key in x86_BB_map:
            result_list.append((key, value, x86_BB_map[key]))

    # 5. Pretty print the result
    pretty_print(result_list)

    print("Total number of basic blocks:", len(result_list))

    # 5. Write to file
    with open(output_file_path, 'w') as f:
        for key, _, x86_value in result_list:
            f.write(f"{key}\n")
            for instr in x86_value:   # Assuming x86_value is a list of instructions
                f.write(f"{instr}\n")
    
    # 6. Invoke the Bash Script
    bash_script_path = "convertToHex.sh"
    processed_output_path = "opcodes.txt"
    subprocess.run(['bash', bash_script_path, output_file_path, processed_output_path])

    # Ensure the opcodes.txt is created and not empty
    if os.path.getsize(processed_output_path) > 0:
        
        # 7. Proceed the opcodes.txt
        with open(processed_output_path, 'r') as f_opcodes, open("final_output.txt", "w") as f_final:
            for line in f_opcodes:
                bb_index, opcodes = line.strip().split(' ', 1)
                opcode_len = len(opcodes) // 2  # As 2 hex chars represent 1 byte
                
                # Determine the unroll factors based on the opcode length
                if opcode_len < 100:
                    unroll_factors = "100 200"
                elif 100 <= opcode_len <= 200:
                    unroll_factors = "50 100"
                else:
                    unroll_factors = "16 32"
                
                # Append the unroll factors and write to the final output
                f_final.write(f"{bb_index} {opcodes} {unroll_factors}\n")
    
    print("Processing completed.")

if __name__ == "__main__":
    main()