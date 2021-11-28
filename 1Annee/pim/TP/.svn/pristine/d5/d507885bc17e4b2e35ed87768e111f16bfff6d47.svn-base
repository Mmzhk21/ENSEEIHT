
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

#define XXX -1

// Une fonction f qui retourne un entier en fonction du paramètre n fourni.
int f(int n) {
    int r = 0;

    // modifier r
    switch (n) {
    case 1:
        r += 1;
        break;
    case 2:
    case 3:
        r += 8;
        break;
    case 4:
    case 5:
    case 7:
        r += 10;
    case 10:
    case 11:
        r += 5;
        break;
    case 12:
        r += 50;
        break;
    case 13:
        r += 100;
    default:
        r -= 1;
    }

    return r;
}

void test_f(void)
{
    assert(XXX == f(3));
    assert(XXX == f(-5));
    assert(XXX == f(0));
    assert(XXX == f(12));
    assert(XXX == f(13));
    assert(XXX == f(2));
    assert(XXX == f(10));
    assert(XXX == f(5));
}

int main(void) {
    test_f();
    printf("%s", "Bravo !  Pas d'erreur détectée.\n");
    return EXIT_SUCCESS;
}
