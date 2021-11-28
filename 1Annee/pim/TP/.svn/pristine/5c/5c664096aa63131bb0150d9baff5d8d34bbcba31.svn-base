
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>

/**
 * \brief Calculer la somme des cubes des entiers naturels dont le cube est inférieur
 * ou égal à limite.
 * \param[in] limite la limite à ne pas dépasser pour les cubes
 * \return la sommes des cubes
 * \pre limite positive : limite > 0
 */
int sommes_cubes_inferieurs_a(int limite)
{
    assert(limite >= 0);

    // Consigne :
    //   1. On n'utilisera pas l'exponentielle.
    //   2. On utilisera seulement un TantQue
    // TODO: Donner le bon code !
    return -1;
}


////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                    NE PAS MODIFIER CE QUI SUIT...                          //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////


void test_sommes_cubes_inferieurs_a(void) {
    assert(1 == sommes_cubes_inferieurs_a(5));
    assert(1 == sommes_cubes_inferieurs_a(1));
    assert(1 == sommes_cubes_inferieurs_a(7));
    assert(9 == sommes_cubes_inferieurs_a(8));
    assert(9 == sommes_cubes_inferieurs_a(26));
    assert(36 == sommes_cubes_inferieurs_a(27));
    assert(36 == sommes_cubes_inferieurs_a(63));
    assert(100 == sommes_cubes_inferieurs_a(64));
    assert(100 == sommes_cubes_inferieurs_a(124));
    assert(225 == sommes_cubes_inferieurs_a(125));
    printf("%s", "sommes_cubes_inferieurs_a... ok\n");
}


int main(void) {
    test_sommes_cubes_inferieurs_a();
    printf("%s", "Bravo ! Tous les tests passent.\n");
    return EXIT_SUCCESS;
}

