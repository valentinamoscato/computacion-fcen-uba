#include <stdio.h>
#include <stdlib.h>
#include <string.h>
# define NAME_LEN 4

typedef struct persona_s {
    char nombre[NAME_LEN+1];
    int edad;
} persona_t;

persona_t *crearPersona(char nombre[NAME_LEN+1], int edad) {
    persona_t *nueva_persona = malloc(sizeof(persona_t));
    if (nueva_persona == NULL) {
        return NULL;
    }
    strcpy(nueva_persona->nombre, nombre);
    nueva_persona->edad = edad;
    return nueva_persona;
}

void eliminarPersona(persona_t *una_persona) {
    free(una_persona);
}

int main() {
    persona_t *una_persona = crearPersona("Tuni", 7);
    if (una_persona == NULL) {
        // Manejar el error de asignaci´on de memoria
        return 1;
    }
    printf("%d %s\n", una_persona->edad, una_persona->nombre); // 7 Tuni
    eliminarPersona(una_persona);
    printf("%d %s\n", una_persona->edad, una_persona->nombre); // 792278154 �+ (crap)
    return 0;
}