#include "ej4b.h"

#include <string.h>

// OPCIONAL: implementar en C
// void invocar_habilidad(void* carta_generica, char* habilidad) {
// 	card_t* carta = carta_generica;
// 
// 	int cmp = 1;
// 	void* funcion;
// 	
// 	uint16_t cant_hab = carta->__dir_entries;
// 	
// 	for (size_t i = 0; i < cant_hab; i++) {
// 		directory_entry_t* ptr = carta->__dir[i];
// 		cmp = strcmp(ptr->ability_name, habilidad);
// 
// 		if (cmp == 0) {
// 			funcion = (void*) ptr->ability_ptr;
// 			break;
// 		}
// 	}
// 
// 	if (cmp == 0) {
// 		void (*f) (void*) = (void (*)(void*)) funcion;
// 		f(carta_generica);
// 	}
// 
// 	if (cmp != 0 && carta->__archetype)
// 		invocar_habilidad(carta->__archetype, habilidad);
// }


void invocar_habilidad(void* carta_generica, char* habilidad) {
	card_t *carta = (card_t*)carta_generica;
	void (*funcion) (void*) = NULL;

	while(!funcion && carta) {
		uint16_t cant_habilidades = carta->__dir_entries;

		for (size_t i = 0; i < cant_habilidades; i++) {
			directory_entry_t* direntry = carta->__dir[i];
			int cmp = strcmp(direntry->ability_name, habilidad);

			if (cmp == 0) {
				funcion = (void (*)(void*))direntry->ability_ptr;
				funcion(carta);
			}
		}
		carta = (card_t*)carta->__archetype;
	}
}
