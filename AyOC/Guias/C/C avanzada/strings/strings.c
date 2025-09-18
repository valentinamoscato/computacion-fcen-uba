#include <stdio.h>

void to_uppercase(char *str) {
    int uppercase_difference = 'A' - 'a';
    while (*str != '\0') {
        if (*str >= 'a' && *str <= 'z') { // Solo aplicar la conversion si la letra es minuscula
            *str = *str + uppercase_difference; // Sumarle la diferencia para hacerla mayuscula
        } // Necesitamos guardar el caracter en mayusculas en la direccion de memoria del caracter original
        str++;
    }
}

int main() {
    char str1[] = "Hola";
    printf("Original: %s\n", str1);
    to_uppercase(str1);
    printf("En mayúsculas: %s\n", str1);
    return 0;
}