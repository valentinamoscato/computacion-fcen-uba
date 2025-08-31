#include <stdio.h>
#define FELIZ 0
#define TRISTE 1

int estado = TRISTE; // static duration. File scope

void ser_feliz();
void print_estado();

int main() {
    print_estado(); // Estoy triste
    ser_feliz();    // Cambia estado a FELIZ
    print_estado(); // Estoy feliz
}

void ser_feliz() {
    estado = FELIZ;
}

void print_estado() {
    printf("Estoy %s\n", estado == FELIZ ? "feliz" : "triste");
}