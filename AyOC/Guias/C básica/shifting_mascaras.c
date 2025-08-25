#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>

bool compare_lower_and_higher_3_bits(int32_t higher, int32_t lower) {
    int32_t mask = 0b111000; // mask enmascara la parte baja, ~mask enmascara la parte alta

    int32_t shifted_lower = lower << 3;

    int32_t cleared_higher = higher & mask;
    int32_t cleared_lower = shifted_lower & mask;

    printf("higher = %d\n", higher);
    printf("lower = %d\n", lower);
    printf("cleared_higher = %d\n", cleared_higher);
    printf("cleared_lower = %d\n", cleared_lower);

    return (cleared_higher == cleared_lower);
}

int main() {
    // iguales
    // int32_t i = 0b111010;
    // int32_t j = 0b110111;

    // distintos
    int32_t i = 0b101010;
    int32_t j = 0b110111;

    bool result = compare_lower_and_higher_3_bits(i, j);

    if (result == true) {
        printf("i = %d y j = %d son iguales!", i, j);
    } else {
        printf("i = %d y j = %d son distintos!", i, j);
    }

    return 0;
}