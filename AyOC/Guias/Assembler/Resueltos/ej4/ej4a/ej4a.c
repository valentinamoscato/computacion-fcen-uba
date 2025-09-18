#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "ej4a.h"

/**
 * Marca el ejercicio 1A como hecho (`true`) o pendiente (`false`).
 *
 * Funciones a implementar:
 *   - init_fantastruco_dir
 */
bool EJERCICIO_1A_HECHO = true;

#define DIRENTRY_NAME_OFFSET 0
#define DIRENTRY_PTR_OFFSET 16

#define FANTASTRUCO_FACEUP_OFFSET 24

// OPCIONAL: implementar en C
void init_fantastruco_dir(fantastruco_t* card) {
	void* memptr = malloc(2*8);
	void* direntryptr1 = malloc(sizeof(directory_entry_t));
	void* direntryptr2 = malloc(sizeof(directory_entry_t));

	card->__dir_entries = (uint16_t)2;

	strcpy((char*)direntryptr1 + DIRENTRY_NAME_OFFSET, "sleep\0");
	strcpy((char*)direntryptr2 + DIRENTRY_NAME_OFFSET, "wakeup\0");

	uintptr_t *dir1_ab_field = (uintptr_t*) ((char*)direntryptr1 + DIRENTRY_PTR_OFFSET);
	*dir1_ab_field = (uintptr_t*)&sleep;

	uintptr_t *dir2_ab_field =(uintptr_t*) ((char*)direntryptr2 + DIRENTRY_PTR_OFFSET);
	*dir2_ab_field = (uintptr_t*)&wakeup;

	card->__dir = (directory_t)memptr;
	card->__dir[0] = direntryptr1;
	card->__dir[1] = direntryptr2;
	return;
}

/**
 * Marca el ejercicio 1A como hecho (`true`) o pendiente (`false`).
 *
 * Funciones a implementar:
 *   - summon_fantastruco
 */
bool EJERCICIO_1B_HECHO = true;

// OPCIONAL: implementar en C
fantastruco_t* summon_fantastruco() {
	void *memptr = malloc(sizeof(fantastruco_t));
	memset((char*)memptr, 0, sizeof(fantastruco_t));

	memset((char*)memptr + FANTASTRUCO_FACEUP_OFFSET, 1, 1);
	
	init_fantastruco_dir((fantastruco_t*)memptr);
	
	return (fantastruco_t*)memptr;
}
