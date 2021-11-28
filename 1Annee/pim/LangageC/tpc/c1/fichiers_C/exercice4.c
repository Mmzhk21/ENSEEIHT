#define XXX -1

// Consigne : dans la suite *** uniquement ***, remplacer XXX par le bon 
// résultat (une constante littérale).

#include <assert.h>
#include <stdlib.h>
#include <stdio.h>

int main(void) {
    // Comprendre les opérateurs arithmétiques
    assert(XXX == 5 - 2 * 5);
    assert(XXX == 25 % 10);
    assert(XXX == 25 / 10);
    assert(XXX == 25 / 10.0);

    // Comprendre les relations caractères et entiers
    assert(XXX == '5' - '0');
    assert(XXX == '0' + 7);
    assert(XXX == 'A' + 3);

    printf("%s", "Bravo ! Tous les tests passent.\n");

    return EXIT_SUCCESS;
}
