#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

/**
 * \brief Obtenir le nombres de jour d'un mois d'une année non bissextile.
 * \param[in] mois le mois considéré (de 1, janvier, à 12, décembre)
 * \return le nombre de jours du mois considéré
 */
char nb_jours_mois(int mois)
{
    // Contraintes :
    //   1. On utilisera un Selon et aucune autre structure de contrôle.
    //   2. On fera un seul « return » à la fin de la fonction.
    //   3. On n'utilisera pas de tableau !
    // TODO: Donner le bon code !
    return 0;
}


////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                    NE PAS MODIFIER CE QUI SUIT...                          //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

void test_nb_jours_mois() {
    assert(31 == nb_jours_mois(1));
    assert(28 == nb_jours_mois(2));
    assert(31 == nb_jours_mois(3));
    assert(30 == nb_jours_mois(4));
    assert(31 == nb_jours_mois(5));
    assert(30 == nb_jours_mois(6));
    assert(31 == nb_jours_mois(7));
    assert(31 == nb_jours_mois(8));
    assert(30 == nb_jours_mois(9));
    assert(31 == nb_jours_mois(10));
    assert(30 == nb_jours_mois(11));
    assert(31 == nb_jours_mois(12));
    printf("%s", "nb_jours_mois... ok\n");
}


int main(void) {
    test_nb_jours_mois();
    printf("%s", "Bravo ! Tous les tests passent.\n");
    return EXIT_SUCCESS;
}
