#include <stdio.h>

int main() {
    char c = 100;
    short s = -8712;
    int i = 123456;
    long l = 1234567890;

    printf("char(%llu): %d \n", sizeof(c),c);
    printf("short(%llu): %d \n", sizeof(s),s);
    printf("int(%llu): %d \n", sizeof(i),i);
    printf("long(%llu): %ld \n", sizeof(l),l);

    return 0;
}