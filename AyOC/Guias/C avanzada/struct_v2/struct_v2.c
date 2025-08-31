#include <stdio.h>

typedef struct {
    char* nombre;
    int vida;
    double ataque;
    double defensa;
} monstruo_t;

monstruo_t evolution(monstruo_t monstruo) {
    monstruo_t evolved = {
        monstruo.nombre, monstruo.vida, monstruo.ataque + 10, monstruo.defensa + 10
    };
    return evolved;
}

int main() {
    monstruo_t tun = { "Tun", 8, 5.0, 10.0 };
    printf("Antes de evolucionar - Monstruo: %s, vida: %d, ataque: %f, defensa: %f\n", tun.nombre, tun.vida, tun.ataque, tun.defensa);
    monstruo_t evolved_tun = evolution(tun);
    printf("Luego de evolucionar - Monstruo: %s, vida: %d, ataque: %f, defensa: %f\n", evolved_tun.nombre, evolved_tun.vida, evolved_tun.ataque, evolved_tun.defensa);
    return 0;
}