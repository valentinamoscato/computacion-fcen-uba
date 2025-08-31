#include <stdio.h>
#include <stdlib.h>

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

// ejercicio 12
void rotar_dinamico(int rot) {
    int array[4] = {1, 2, 3, 4};
    int rotated_array[4];
    
    for (int i = 0; i < 4; i++) {
        rotated_array[i] = array[(i + rot) % 4];
    }

    for (int i = 0; i < 4; i++) {
        printf("array[%d] = %d\n", i, rotated_array[i]);
    }
}

// ejercicio 13
void dice_roll() {
    int appearances[6] = {0, 0, 0, 0, 0, 0};
    int rolls = 60000000;
    while (rolls > 0) {
        int face = rand() % 6;
        appearances[face]++;
        rolls--;
    }

    for (int i = 0; i < 6; i++) {
        printf("appearances[%d] = %d\n", i, appearances[i]);
    }
}

int main() {
    
    // rotar_estatico();
    // rotar_dinamico(2);
    dice_roll();

    return 0;
}