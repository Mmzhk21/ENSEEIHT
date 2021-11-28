/*
 *  Auteur :  KJR
 *  Objectif :
 *    Test d'un itineraire
 */

#include "itineraire.h"
#include <stdlib.h>
#include <assert.h>
#include <stdio.h>

int main ()
{
    Itineraire f;
    Point val;
    initialiser (&f);
    assert(0 == longueur(f));

    initialiser_point(&val, 1 ,2);
    inserer (&f, val);
    assert(1 == longueur(f));
    assert(1 == lire_longitude(tete(f)));
    assert(2 == lire_latitude(tete(f)));

    initialiser_point(&val, 3 ,4);
    inserer (&f, val);
    assert(1 == lire_longitude(tete(f)));
    assert(2 == lire_latitude(tete(f)));

    initialiser_point(&val, 5 ,6);
    inserer (&f, val);
    assert(1 == lire_longitude(tete(f)));
    assert(2 == lire_latitude(tete(f)));
    assert(3 == longueur(f));

    extraire (&f, &val);
    assert(1 == lire_longitude(val));
    assert(2 == lire_latitude(val));
    assert(2 == longueur(f));
    assert(3 == lire_longitude(tete(f)));
    assert(4 == lire_latitude(tete(f)));

    extraire (&f, &val);
    assert(3 == lire_longitude(val));
    assert(4 == lire_latitude(val));
    assert(1 == longueur(f));
    assert(5 == lire_longitude(tete(f)));
    assert(6 == lire_latitude(tete(f)));

    extraire (&f, &val);
    assert(5 == lire_longitude(val));
    assert(6 == lire_latitude(val));
    assert(0 == longueur(f));
    assert(est_vide(f));

    // Tester l'ajout dans une file vidée
    initialiser_point(&val, -1 ,-1.2);
    inserer (&f, val);
    assert(1 == longueur(f));
    assert(-1 == lire_longitude(tete(f)));
    assert(-12 == (int)(lire_latitude(tete(f))*10));

    detruire(&f);

    return EXIT_SUCCESS;
}
