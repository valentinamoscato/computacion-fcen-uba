#include <stdio.h>

typedef struct {
    char* nombre;
    int vida;
    double ataque;
    double defensa;
} monstruo_t;

int main() {
    monstruo_t monstruos[] = {
        { "Lucy", 4, 10.0, 20.0 },
        { "Tun", 8, 5.0, 10.0 },
    };
    for (int i = 0; i < 2; i++) {
        printf("Monstruo: %s, vida: %d, ataque: %f, defensa: %f\n", monstruos[i].nombre, monstruos[i].vida, monstruos[i].ataque, monstruos[i].defensa);
    }
    return 0;
}