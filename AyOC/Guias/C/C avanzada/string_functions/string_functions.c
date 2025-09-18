#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void demostrar_strlen() { // cuenta la cantidad de caracteres de un string
    printf("=== strlen ===\n");
    char *texto = "Hola Mundo";
    size_t longitud = strlen(texto); // toma un string o puntero a char
    printf("'%s' tiene %zu caracteres\n\n", texto, longitud);
}

void demostrar_strcpy() { // copia el valor de un string en otra direccion de memoria (otro string)
    printf("=== strcpy ===\n");
    char origen[] = "Copiame";
    char destino[20];
    
    strcpy(destino, origen); // toma un destino y una fuente, ambos punteros a char
    printf("Origen: '%s'\n", origen);
    printf("Destino después de strcpy: '%s'\n\n", destino);
}

void demostrar_strncpy() { // copia el valor de un SUBstring en otra direccion de memoria (otro string)
    printf("=== strncpy ===\n");
    char origen[] = "Texto muy largo";
    char destino[10];
    
    strncpy(destino, origen, sizeof(destino) - 1);
    // toma un destino y una fuente, ambos punteros a char, y un size del substring
    destino[sizeof(destino) - 1] = '\0'; // Aseguramos null-terminator
    
    printf("Origen: '%s'\n", origen);
    printf("Destino (solo 9 chars): '%s'\n\n", destino);
}

void demostrar_strcat() { // concatena un string agregado en otro string base
    printf("=== strcat ===\n");
    char base[50] = "Hola ";
    char agregado[] = "Mundo!";
    
    strcat(base, agregado); // toma un destino y una fuente, ambos punteros a char
    printf("String concatenado: '%s'\n\n", base);
}

void demostrar_strncat() { // concatena un SUBstring agregado en otro string base
    printf("=== strncat ===\n");
    char base[50] = "Hola ";
    char agregado[] = "Mundo Cruel!";
    
    strncat(base, agregado, 6); // Solo agrega "Mundo"
    // toma un destino y una fuente, ambos punteros a char, y un size del substring
    printf("String concatenado limitado: '%s'\n\n", base);
}

void demostrar_strcmp() { // compara dos strings y retorna 0 si son iguales, negativo si el segundo es mas grande y positivo c.c.
    printf("=== strcmp ===\n");
    char str1[] = "apple";
    char str2[] = "banana";
    char str3[] = "apple";
    // toma dos punteros a char
    printf("strcmp('%s', '%s') = %d\n", str1, str2, strcmp(str1, str2));
    printf("strcmp('%s', '%s') = %d\n", str2, str1, strcmp(str2, str1));
    printf("strcmp('%s', '%s') = %d\n\n", str1, str3, strcmp(str1, str3));
}

void demostrar_strchr() { // busca un caracter y lo retorna, NULL c.c.
    printf("=== strchr ===\n");
    char texto[] = "Buscando la letra 'a'";
    char *resultado = strchr(texto, 'a');
    // toma un puntero a char constante y un caracter como int
    
    if (resultado) {
        printf("Primera 'a' encontrada en: '%s'\n", resultado);
    } else {
        printf("Letra no encontrada\n");
    }
    printf("\n");
}

void demostrar_strstr() { // busca un substring y lo retorna, NULL c.c.
    printf("=== strstr ===\n");
    char texto[] = "El rápido zorro marrón";
    char *resultado = strstr(texto, "zorro");
    // toma dos punteros a char constantes
    if (resultado) {
        printf("Substring encontrado: '%s'\n", resultado);
    } else {
        printf("Substring no encontrado\n");
    }
    printf("\n");
}

void demostrar_strtok() { // tokeniza un string (lo separa en substrings segun un separador)
    printf("=== strtok ===\n");
    char texto[] = "manzana,pera,uva;naranja";
    char *token;
    
    printf("Tokenizando: '%s'\n", texto);
    token = strtok(texto, ",;");
    // toma dos punteros a char constantes
    
    while (token != NULL) {
        printf("Token: %s\n", token);
        token = strtok(NULL, ",;");
    }
    printf("\n");
}

int main() {
    printf("DEMOSTRACIÓN DE FUNCIONES DE STRING.H\n\n");
    
    demostrar_strlen();
    demostrar_strcpy();
    demostrar_strncpy();
    demostrar_strcat();
    demostrar_strncat();
    demostrar_strcmp();
    demostrar_strchr();
    demostrar_strstr();
    demostrar_strtok();
    
    return 0;
}

// char *strcpy(char *restrict dest, const char *restrict src);

// Significado de restrict:
// Garantía de no aliasing: Le dice al compilador que los punteros dest y src no se superponen en memoria. Es decir, que son regiones de memoria distintas.

// Optimización: Permite al compilador realizar optimizaciones más agresivas, ya que sabe que escribir en dest no afectará la lectura de src.

// Responsabilidad del programador: El programador debe garantizar que realmente no hay superposición. Si se viola esta garantía, el comportamiento es indefinido.