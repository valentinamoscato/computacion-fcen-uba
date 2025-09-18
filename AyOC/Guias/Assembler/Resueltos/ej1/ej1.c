#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "ej1.h"

/**
 * Marca el ejercicio 1A como hecho (`true`) o pendiente (`false`).
 *
 * Funciones a implementar:
 *   - es_indice_ordenado
 */
bool EJERCICIO_1A_HECHO = true;

/**
 * Marca el ejercicio 1B como hecho (`true`) o pendiente (`false`).
 *
 * Funciones a implementar:
 *   - indice_a_inventario
 */
bool EJERCICIO_1B_HECHO = true;

/**
 * OPCIONAL: implementar en C
 */
bool es_indice_ordenado(item_t** inventario, uint16_t* indice, uint16_t tamanio, comparador_t comparador) {
	bool res = true;
	for(int i = 0; i < tamanio - 1; i++){
		// agarro los elementos
		item_t* itemActual = inventario[indice[i]];
		item_t* itemDelIndice= inventario[indice[i+1]];
		// los comparo
		//int comp = strcmp(itemActual->nombre,itemDelIndice->nombre);
		bool comp = comparador(itemActual, itemDelIndice);
		if (comp == false){
			res = false;
		}
	}

	return res;
}

/**
 * OPCIONAL: implementar en C
 */
item_t** indice_a_inventario(item_t** inventario, uint16_t* indice, uint16_t tamanio) {
	// ¿Cuánta memoria hay que pedir para el resultado?
	item_t** resultado = malloc((tamanio * sizeof(item_t*)) + (tamanio * 28));
	for(int i = 0; i < tamanio; i++){
		resultado[i] = inventario[indice[i]];
	}
	return resultado;
}
