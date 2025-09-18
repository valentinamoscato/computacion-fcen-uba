#include <stdio.h>

int local = 0;

void function() {
        int local = 1;
        printf("%d\n", local);
    }

int main() {
    function();
    printf("%d\n", local);
    return 0;
}