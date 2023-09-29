from llvm_BB_reader import read_llvm_ir_file_filtered
from x86_BB_reader import compile_llvm_to_x86_asm, read_x86_BB

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

if __name__ == "__main__":
    main()