#include <stdio.h>
int main() {
    for (int i = 0; i < 10; i++) {
        printf("i = %d\n", i);
    }

    // i = 0
    // i = 1
    // i = 2
    // i = 3
    // i = 4
    // i = 5
    // i = 6
    // i = 7
    // i = 8
    // i = 9

    int j = 0;
    while (j < 10) {
        printf("j = %d\n", j);
        j++;
    }

    // j = 0
    // j = 1
    // j = 2
    // j = 3
    // j = 4
    // j = 5
    // j = 6
    // j = 7
    // j = 8
    // j = 9

    return 0;
}