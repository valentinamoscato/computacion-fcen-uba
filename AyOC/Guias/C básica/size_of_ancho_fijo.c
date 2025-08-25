#include <stdio.h>
#include <stdint.h>

int main() {
    int8_t i_8 = 1;
    int16_t i_16 = 2;
    int32_t i_32 = 3;
    int64_t i_64 = 4;
    intmax_t max = 5;
    intptr_t max_pointer = 6;

    printf("int8_t(%llu): %d \n", sizeof(i_8),i_8);
    printf("int16_t(%llu): %d \n", sizeof(i_16),i_16);
    printf("int32_t(%llu): %d \n", sizeof(i_32),i_32);
    printf("int64_t(%llu): %lld \n", sizeof(i_64),i_64);
    printf("intmax_t(%llu): %lld \n", sizeof(max),max);
    printf("intptr_t(%llu): %lld \n", sizeof(max_pointer),max_pointer);

    return 0;
}