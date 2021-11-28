/**
*  \author KJR <nom@n7.fr>
*  \file itineraire.c
*  Objectifs :
*    .  Adapter le module file pour construire un itin�raire de points
*/

#include <malloc.h>
#include <assert.h>

#include "itineraire.h"


void initialiser(File *f)
{
    // TODO

    assert(est_vide(*f));
}


void detruire(File *f)
{
    // TODO
}


char tete(File f)
{
    assert(! est_vide(f));

    // TODO
    return 0;
}


bool est_vide(File f)
{
    // TODO
    return false;
}

/**
 * Obtenir une nouvelle cellule allou�e dynamiquement
 * initialis�e avec la valeur et la cellule suivante pr�cis� en param�tre.
 */
static Cellule * cellule(char valeur, Cellule *suivante)
{
    // TODO
    return NULL;
}


void inserer(File *f, char v)
{
    assert(f != NULL);

    // TODO
}

void extraire(File *f, char *v)
{
    assert(f != NULL);
    assert(! est_vide(*f));

    // TODO
}


int longueur(File f)
{
    // TODO
    return 0;
}
