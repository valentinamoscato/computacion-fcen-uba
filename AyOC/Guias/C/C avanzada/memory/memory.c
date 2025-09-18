#include <stdio.h>
#include <stdint.h>

int main(){
    int8_t memoria[2] = { -1, -128 };
    uint8_t *x = (uint8_t*) &memoria[0];
    int8_t *y = &memoria[1];
    
    printf("Dir de x: %p Valor: %d\n", (void*) x, *x);
    printf("Dir de y: %p Valor: %d\n", (void*) y, *y);

    // Dir de x: 0x7ffdb3c9afd6 Valor: 255
    // Dir de y: 0x7ffdb3c9afd7 Valor: -128
}