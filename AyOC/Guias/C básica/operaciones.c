#include <stdio.h>

int main() {
    int a = 5, b = 3, c = 2, d = 1;
    printf("a = %d, b = %d, c = %d, d = %d\n\n", a, b, c, d); // a = 5, b = 3, c = 2, d = 1
    printf("a + b * c / d = %d\n", a + b * c / d); // a + b * c / d = 11
    printf("a °/° b = %d\n", a % b); // a % b = 2
    printf("a == b = %d\n", a == b); // a == b = 0
    printf("a != b = %d\n", a != b); // a != b = 1
    printf("a & b = %d\n", a & b); // a & b = 1
    printf("a | b = %d\n", a | b); // a | b = 7
    printf("~a = %d\n", ~a); // ~a = -6
    printf("a && b = %d\n", a && b); // a && b = 1
    printf("a || b = %d\n", a || b); // a || b = 1
    printf("a << 1 = %d\n", a << 1); // a << 1 = 10
    printf("a >> 1 = %d\n", a >> 1); // a >> 1 = 2
    printf("a += b = %d\n", a += b); // a += b = 8
    printf("a -= b = %d\n", a -= b); // a -= b = 5
    printf("a *= b = %d\n", a *= b); // a *= b = 15
    printf("a /= b = %d\n", a /= b); // a /= b = 5
    printf("a °/°= b = %d\n", a %= b); // a %= b = 2
    return 0;
}