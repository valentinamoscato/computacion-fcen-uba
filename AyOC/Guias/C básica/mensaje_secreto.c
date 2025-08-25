#include <stdio.h>

int main() {
    int mensaje_secreto[] = {
        116, 104, 101, 32, 103, 105, 102, 116, 32, 111,
        102, 32, 119, 111, 114, 100, 115, 32, 105, 115, 32, 116, 104, 101, 32,
        103, 105, 102, 116, 32, 111, 102, 32, 100, 101, 99, 101, 112, 116, 105,
        111, 110, 32, 97, 110, 100, 32, 105, 108, 108, 117, 115, 105, 111, 110
    };

    // size_t can store the maximum size of a theoretically possible object of any type (including array).
    // size_t is commonly used for array indexing and loop counting.
    // Programs that use other types, such as unsigned int, for array indexing may fail on, 
    // e.g. 64-bit systems when the index exceeds UINT_MAX or if it relies on 32-bit modular arithmetic.
    size_t length = sizeof(mensaje_secreto) / sizeof(int); // divide el array de ints en el tamaño de un int (4 bytes) para obtener cada int

    char decoded[length];

    for (int i = 0; i < length; i++) {
        decoded[i] = (char) (mensaje_secreto[i]); // casting de int a char
    }

    for (int i = 0; i < length; i++) {
        printf("%c", decoded[i]);
    }
}
