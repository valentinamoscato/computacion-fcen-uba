#include <stdio.h>
#define FELIZ 0
#define TRISTE 1

void ser_feliz(int estado);
void print_estado(int estado);

int main() {
    int estado = TRISTE; // automatic duration. Block scope
    ser_feliz(estado);
    print_estado(estado); // Estoy triste
}

void ser_feliz(int estado) {
    estado = FELIZ;
}

void print_estado(int estado) {
    printf("Estoy %s\n", estado == FELIZ ? "feliz" : "triste");
}