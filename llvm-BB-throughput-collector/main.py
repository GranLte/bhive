from llvm_BB_reader import read_llvm_ir_file_filtered
from x86_BB_reader import compile_llvm_to_x86_asm, read_x86_BB
import subprocess
import os
import argparse

DEBUG = 1
RELEASE = 2
UPGRADE = 3

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


def apply_upgrades(old_measurements, new_measurements):
    updated_measurements = {}
    for bb, old_throughput in old_measurements.items():
        new_throughput = new_measurements.get(bb, None)
        if new_throughput is None:
            updated_measurements[bb] = old_throughput
        elif old_throughput == -1:
            updated_measurements[bb] = new_throughput
        elif new_throughput != -1.0 and abs(old_throughput - new_throughput) >= 0.05:
            updated_measurements[bb] = new_throughput
        else:
            updated_measurements[bb] = old_throughput
        print(f"{bb}: {old_throughput} -> {updated_measurements[bb]}")
    return updated_measurements

def main(llvm_file_path, result_option, result_output):
    # Provide the path to your .ll file
    llvm_file_path = "/u9/z277zhu/granLte/bhive/tests/harness_comment.ll"
    tmp_file_x86_BBs = "tmp_output.txt"  # TODO: Update the output path as required
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

    # 5. Write to file
    with open(tmp_file_x86_BBs, 'w') as f:
        for key, _, x86_value in result_list:
            f.write(f"{key}\n")
            for instr in x86_value:   # Assuming x86_value is a list of instructions
                f.write(f"{instr}\n")
    
    # 6. Invoke the Bash Script
    bash_script_path = "convertToHex.sh"
    tmp_processed_hex_file = "tmp_opcodes.txt"
    tmp_measure_input = "tmp_opcodes_unroll_factors.txt"
    subprocess.run(['bash', bash_script_path, tmp_file_x86_BBs, tmp_processed_hex_file])

    # Ensure the opcodes.txt is created and not empty
    if os.path.getsize(tmp_processed_hex_file) > 0:
        
        # 7. Proceed the opcodes.txt
        with open(tmp_processed_hex_file, 'r') as f_opcodes, open(tmp_measure_input, "w") as f_final:
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
    
    # 8. invoke measurement process to get throughput for each BB
    measurement_script_path = "../timing-harness/test"
    tmp_measure_output = "tmp_measure_output.txt"
    subprocess.run([measurement_script_path, tmp_measure_input, tmp_measure_output])
    # 9. merge measurement output with final output and result_list based on option debug/release

    old_measurements_lines = []
    if result_option == UPGRADE:
        with open(result_output, 'r') as f_result_output_read:
            old_measurements_lines = f_result_output_read.readlines()
            print("old_measurements_lines")
            print(old_measurements_lines)

    with open(result_output, 'w+') as f_result_output:
        if result_option == DEBUG:
            with open(tmp_measure_output, 'r') as f_measurement_output:
                # Reading all the lines of tmp_measure_output in a list
                measurement_lines = f_measurement_output.readlines()
                
                # Using zip to iterate over measurement_lines and result_list together
                for line, (bb_name, llvm_instructions, x86_instructions) in zip(measurement_lines, result_list):
                    elements = line.strip().split('  ')
                    hex_code = elements[0]
                    throughput = elements[1]

                    # Write to the result output
                    f_result_output.write(f"BB Name: {bb_name}\n")
                    f_result_output.write("-" * 50 + "\n")
                    f_result_output.write("LLVM Instructions:\n")
                    for instr in llvm_instructions:
                        f_result_output.write(f"{instr}\n")
                    f_result_output.write("\nX86 Instructions:\n")
                    for instr in x86_instructions:
                        f_result_output.write(f"{instr}\n")
                    f_result_output.write(f"\nHex Code: {hex_code}\n")
                    f_result_output.write(f"Inverse Throughput: {throughput}\n")
                    f_result_output.write("=" * 100 + "\n\n")
        elif result_option == RELEASE:
            with open(tmp_measure_output, 'r') as f_measurement_output:
                # Reading all the lines of tmp_measure_output in a list
                measurement_lines = f_measurement_output.readlines()
                
                # Using zip to iterate over measurement_lines and result_list together
                for line, (bb_name, _, _) in zip(measurement_lines, result_list):
                    elements = line.strip().split('  ')
                    throughput = elements[1]

                    # Write to the result output
                    f_result_output.write(f"{bb_name}, {throughput}\n")
        elif result_option == UPGRADE:
            print("here")
            with open(tmp_measure_output, 'r') as f_measurement_output:
                # Reading all the lines of tmp_measure_output in a list
                measurement_lines = f_measurement_output.readlines()

                new_measurements = {}
                for line, (bb_name, _, _) in zip(measurement_lines, result_list):
                    elements = line.strip().split('  ')
                    throughput = float(elements[1])
                    new_measurements[bb_name] = throughput

                # Reading all the lines of upgrade_file_path in a list
                old_measurements = {}
                for line in old_measurements_lines:
                    bb_name, throughput = line.strip().split(', ')
                    old_measurements[bb_name] = float(throughput)

                print("old_measurements")
                print(old_measurements)
                print("new_measurements")
                print(new_measurements)
                assert len(old_measurements) == len(new_measurements)
                updated_measurements = apply_upgrades(old_measurements, new_measurements)
                # Write to the result output
                with open(result_output, 'w') as f_result_output:
                    for bb_name, throughput in updated_measurements.items():
                        f_result_output.write(f"{bb_name}, {throughput:.6f}\n")
    
    # 10.clean up temp files
    temporary_files = [
        asm_file_path,
        tmp_file_x86_BBs,
        tmp_processed_hex_file,
        tmp_measure_input,
        tmp_measure_output
    ]

    for tmp_file in temporary_files:
        try:
            os.remove(tmp_file)
        except FileNotFoundError:
            print(f"Warning: Temporary file {tmp_file} not found for removal.")


    print("Processing completed.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Process an LLVM IR file and generate throughput measurement outputs.")
    parser.add_argument("llvm_file", help="Path to the LLVM IR file to process.")
    parser.add_argument("output_file", help="Path for the final output.")
    parser.add_argument("mode", choices=['DEBUG', 'RELEASE', 'UPGRADE'], help="Operating mode: DEBUG or RELEASE.")

    args = parser.parse_args()
    mode_mapping = {'DEBUG': DEBUG, 'RELEASE': RELEASE, 'UPGRADE': UPGRADE}
    mode = mode_mapping.get(args.mode, DEBUG)
    print(f"Operating mode: {args.mode}")

    main(args.llvm_file, mode, args.output_file)