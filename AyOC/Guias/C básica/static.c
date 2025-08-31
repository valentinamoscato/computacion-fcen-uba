#include <stdio.h>
#define FELIZ 0
#define TRISTE 1
int estado = TRISTE; // static duration. File scope

void alcoholizar();
void print_estado();

int main(){
    print_estado(); // Estoy triste
    alcoholizar();
    print_estado(); // Estoy feliz
    alcoholizar();alcoholizar();alcoholizar();
    print_estado(); // Estoy triste
}

void alcoholizar() {
    int cantidad = 0; // static duration. block scope
    cantidad++;
    if (cantidad < 3) {
        estado = FELIZ;
    }else{
        estado = TRISTE;
    }
}
void print_estado() {
    printf("Estoy %s\n", estado == FELIZ ? "feliz" : "triste");
}