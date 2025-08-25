#include <stdio.h>

int main() {
    float float_to_cast = 0.1;
    double double_to_cast = 0.1;
    int casted_float = (int) float_to_cast;
    int casted_double = (int) double_to_cast;

    printf("float(%llu): %f \n", sizeof(float_to_cast),float_to_cast);
    printf("double(%llu): %f \n", sizeof(double_to_cast),double_to_cast);
    printf("int(%llu): %d \n", sizeof(casted_float),casted_float);
    printf("int(%llu): %d \n", sizeof(casted_double),casted_double);
    return 0;
}