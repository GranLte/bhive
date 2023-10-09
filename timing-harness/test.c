#define _GNU_SOURCE

#include <sys/types.h>
#include <sys/user.h>
#include <sys/ptrace.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/mman.h>
#include <sys/wait.h>
#include <stdint.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>
#include <sys/syscall.h>
#include <assert.h>
#include <math.h>

#include "harness.h"

#define NUM_MEASUREMENTS 5
#define SLEEP_TIME 100

#ifndef NDEBUG
#define LOG(args...) printf(args)
#else
#define LOG(...) while(0)
#define perror(prefix) while(0)
#endif


uint8_t parse_hex_digit(char c) {
  if (c >= 'a' && c <= 'f')
    return c - 'a' + 0xa;
  if (c >= 'A' && c <= 'F')
    return c - 'A' + 0xa;
  return c - '0';
}

uint8_t *hex2bin(char *hex) {
  size_t len = strlen(hex);
  assert(len % 2 == 0);
  uint8_t *bin = (uint8_t *)malloc(len / 2);
  size_t i;
  for (i = 0; i  < len/2; i++) {
    uint8_t hi = parse_hex_digit(hex[i*2]);
    uint8_t lo = parse_hex_digit(hex[i*2 + 1]);
    bin[i] = hi * 16 + lo;
  }
  return bin;
}

int is_ideal_execution(struct pmc_counters *counter){
   return counter->l1_read_misses == 0 && counter->icache_misses == 0 && counter->context_switches == 0;
}

/**
 * Test and measure the performance of a given code sequence.
 * 
 * @param code_to_test Pointer to the sequence of code to be tested.
 * @param code_size Size of the code sequence.
 * @param unroll_factor Number of times the code is repeated in a loop to amortize measurement overhead.
 * 
 * @return Minimum cycle count observed for ideal executions or -1 if the measurement is deemed unreliable.
 */
int test(char *code_to_test, size_t code_size, unsigned int unroll_factor, int shm_fd) {
    

    // Measure the code's performance and collect hardware counters.
    // This includes counts of core cycles, cache misses, and context switches.
    int l1_read_supported, l1_write_supported, icache_supported;
    struct pmc_counters *counters = measure(
        code_to_test, code_size, unroll_factor,
        &l1_read_supported, &l1_write_supported, &icache_supported, 
        shm_fd);

    // Check if the measurement was successful.
    if (!counters) {
        fprintf(stderr, "failed to run test\n");
        return 1;
    }

    // Header for the results output.
    LOG("Core_cyc\tL1_read_misses\tL1_write_misses\tiCache_misses\tContext_switches\n");

    int total_cycles = 0;          // Accumulated cycles for ideal executions.
    int ideal_executions = 0;      // Number of ideal executions (no misses or context switches).
    int min_cycles = counters[1].core_cyc;  // Minimum cycles observed for ideal executions.

    // Iterate through the counters, printing results and accumulating stats.
    for (int i = 1; i < HARNESS_ITERS; i++) {
        LOG("%ld\t%ld\t%ld\t%ld\t%ld\n",
            counters[i].core_cyc,
            l1_read_supported ? counters[i].l1_read_misses : -1,
            l1_write_supported ? counters[i].l1_write_misses : -1,
            icache_supported ? counters[i].icache_misses : -1,
            counters[i].context_switches);

        // Identify ideal executions, which have no cache misses and no context switches.
        if (counters[i].l1_read_misses == 0 && counters[i].icache_misses == 0 && counters[i].context_switches == 0) {
            total_cycles += counters[i].core_cyc;
            ideal_executions++;
            if (counters[i].core_cyc < min_cycles) {
                min_cycles = counters[i].core_cyc;
            }
        }
    }

    // Calculate mean cycles for ideal executions.
    float mean_cycles = (float)total_cycles / ideal_executions;
    float variance = 0.0;

    // Compute the variance for ideal executions.
    for (int i = 1; i < HARNESS_ITERS; i++) {
        if (counters[i].l1_read_misses == 0 && counters[i].icache_misses == 0 && counters[i].context_switches == 0) {
            variance += (counters[i].core_cyc - mean_cycles) * (counters[i].core_cyc - mean_cycles);
        }
    }
    variance /= ideal_executions;

    // Calculate standard deviation and coefficient of variation.
    float std_dev = sqrtf(variance);
    float coeff_of_variation = std_dev / mean_cycles;

    // Report coefficient of variation and decide if measurement should be rejected based on it.
    if (coeff_of_variation > 0.1) {
        LOG("reject measurement because coefficient of variation %f > 0.1 \n", coeff_of_variation);
    } else {
        LOG("coefficient of variation %f \n", coeff_of_variation);
    }

    // Compute non-ideal executions and decide if measurement should be rejected based on the count.
    int non_ideal_executions = HARNESS_ITERS - ideal_executions;
    if (non_ideal_executions > 6) {
        LOG("reject measurement because non-ideal executions %d > 6 \n", non_ideal_executions);
    } else {
        LOG("non-ideal executions %d \n", non_ideal_executions);
    }

    // Print the best observed cycle count for ideal executions.
    LOG("result is %d \n", min_cycles);

    // Return minimum cycle count or -1 if the measurement is considered unreliable.
    return (non_ideal_executions >= 6 || coeff_of_variation > 0.1) ? -1 : min_cycles;
}

int main(int argc, char **argv){

  if (argc != 3) {
        fprintf(stderr, "Usage: %s <input_file> <output_file>\n", argv[0]);
        return 1;
  }
  
  char *input_filename = argv[1];
  char *output_filename = argv[2];

  FILE *input_file = fopen(input_filename, "r");
  if (!input_file) {
      perror("Failed to open input file");
      return 1;
  }

  FILE *output_file = fopen(output_filename, "w");
  if (!output_file) {
      perror("Failed to open output file");
      fclose(input_file);
      return 1;
  }

  char line[2048];
  // Allocate shared memory for the test, splitting it into 3 pages:
  // 1st page is for the test code, rest for recording results.
  int shm_fd = create_shm_fd("shm-path");
  

  while (fgets(line, sizeof(line), input_file)) {

        unsigned int BB_index = atoi(strtok(line, " "));
        char *code_hex = strtok(NULL, " ");
        unsigned int unroll_factor1 = atoi(strtok(NULL, " "));
        unsigned int unroll_factor2 = atoi(strtok(NULL, "\n"));

        if (code_hex[0] == '0') {
          fprintf(output_file, "%d  %s  %f  %ld\n", BB_index, code_hex, 0.0, 0);
          usleep(SLEEP_TIME);
          continue;
        }

        size_t code_size = strlen(code_hex) / 2;
        char *code_to_test = hex2bin(code_hex);

        // ... [Rest of the code remains the same]
        float inverse_throughputs[NUM_MEASUREMENTS] = {-1.0f, -1.0f, -1.0f, -1.0f, -1.0f};
        size_t failed_attempts = 0;
        for (size_t i = 0; i < NUM_MEASUREMENTS; i++){
          // measure cycles(b, n1)
          int min_cycle_unroll1 = test(code_to_test, code_size, unroll_factor1, shm_fd);
          if (min_cycle_unroll1 < 0) {
            failed_attempts++;
            continue;
          }
          usleep(SLEEP_TIME);
          // measure cycles(b, n2)
          int min_cycle_unroll2 = test(code_to_test, code_size, unroll_factor2, shm_fd);
          if (min_cycle_unroll2 < 0) {
            failed_attempts++;
            continue;
          }
          usleep(SLEEP_TIME);
          // inverse throughput(b) = (cycles(b, n2) − cycles(b, n1 )) / (n2 - n1)
          float inverse_throughput = (min_cycle_unroll2 - min_cycle_unroll1) / (float)(unroll_factor2 - unroll_factor1);
          LOG("throughput at %ld is %f\n", i, inverse_throughput);
          inverse_throughputs[i] = inverse_throughput;
        }

        if (failed_attempts > NUM_MEASUREMENTS / 2 + 1) {
          LOG("failed to measure the throughput\n");
          // return 1;
        }

        // find the minimum inverse throughput that is non-negative
        float min_inverse_throughput = -1.0f;
        for (size_t i = 0; i < NUM_MEASUREMENTS; i++){
          if (inverse_throughputs[i] > 0.0f && (min_inverse_throughput < 0.0f || inverse_throughputs[i] < min_inverse_throughput)){
            min_inverse_throughput = inverse_throughputs[i];
          }
        }
        LOG("result throughput is %f failed %ld times \n", min_inverse_throughput, failed_attempts);
        // Instead of using LOG, write the results directly to the output file
        fprintf(output_file, "%d  %s  %f  %ld\n", BB_index, code_hex, min_inverse_throughput, failed_attempts);

        usleep(SLEEP_TIME);
    } // while get line
  return 0;
}
