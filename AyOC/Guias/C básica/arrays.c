#include <stdio.h>

// ejercicio 11
void rotar_estatico() {
    int array[4] = {1, 2, 3, 4};
    int first_element = array[0];
    for (int i = 0; i < 3; i++) {
        array[i] = array[i + 1];
    }
    array[3] = first_element;

    for (int i = 0; i < 4; i++) {
        printf("array[%d] = %d\n", i, array[i]);
    }
}

void rotar_dinamico(int rot) {
    int array[4] = {1, 2, 3, 4};
    int k = rot % n;
    
    for (int i = 0; i < 4; i++) {
        array[i] = array[(i + k) % 4];
    }

    for (int i = 0; i < 4; i++) {
        printf("array[%d] = %d\n", i, array[i]);
    }
}

int main() {
    
    // rotar_estatico();
    rotar_dinamico(1);
    return 0;
}