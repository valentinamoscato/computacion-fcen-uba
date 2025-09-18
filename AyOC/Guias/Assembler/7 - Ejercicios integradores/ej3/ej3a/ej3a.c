#include "../ejs.h"

// Función auxiliar para contar casos por nivel
void contar_casos_por_nivel(caso_t* arreglo_casos, int largo, int* contadores) {
    for (int i = 0; i < largo; i++) {
        caso_t* caso = &arreglo_casos[i];
        if (caso->usuario->nivel == 0) {
            contadores[0]++;
        }
        if (caso->usuario->nivel == 1) {
            contadores[1]++;
        }
        if (caso->usuario->nivel == 2) {
            contadores[2]++;
        }
    }
}


segmentacion_t* segmentar_casos(caso_t* arreglo_casos, int largo) {
    int contadores[3] = {0};
    contar_casos_por_nivel(arreglo_casos, largo, contadores);

    segmentacion_t* resultado = malloc(sizeof(segmentacion_t));
    
    resultado->casos_nivel_0 = NULL;
    resultado->casos_nivel_1 = NULL;
    resultado->casos_nivel_2 = NULL;

    if (contadores[0] > 0) {
        resultado->casos_nivel_0 = malloc(sizeof(caso_t) * contadores[0]);
    }
    if (contadores[1] > 0) {
        resultado->casos_nivel_1 = malloc(sizeof(caso_t) * contadores[1]);
    }
    if (contadores[2] > 0) {
        resultado->casos_nivel_2 = malloc(sizeof(caso_t) * contadores[2]);
    }

    caso_t* casos_nivel_0 = resultado->casos_nivel_0;
    caso_t* casos_nivel_1 = resultado->casos_nivel_1;
    caso_t* casos_nivel_2 = resultado->casos_nivel_2;

    for(int i = 0; i < largo; i++) {
        caso_t* caso = &arreglo_casos[i];
        if (caso->usuario->nivel == 0) {
            *casos_nivel_0 = *caso;
            casos_nivel_0++;
        }
        if (caso->usuario->nivel == 1) {
            *casos_nivel_1 = *caso;
            casos_nivel_1++;
        }
        if (caso->usuario->nivel == 2) {
            *casos_nivel_2 = *caso;
            casos_nivel_2++;
        }
    }
    return resultado;
}



