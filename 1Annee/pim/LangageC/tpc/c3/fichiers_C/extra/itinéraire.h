/**
 *  \author KJR <nom@n7.fr>
 *  \file itineraire.h
 *  Objectifs :
 *	.  Adapter le module File pour construire un itinéraire de points
 */

#include <stdbool.h>
// TODO
// Inclure le module point

struct Cellule {
    Point pt;
    struct Cellule *suivante;
};
typedef struct Cellule Cellule;

struct Itineraire {
    Cellule *tete;
    Cellule *queue;
    /** Invariant :
      *	 file vide :	tete == NULL && queue == NULL
      */
};
typedef struct Itineraire Itineraire;

// TODO
// Dans la suite, adapter les spécifications du module File
// pour pouvoir créer un itinéraire

/**
 * Initialiser la file \a f.
 * La file est vide.
 *
 * Assure
 *	est_vide(*f);
 */
void initialiser(File *f);

/**
 * Détruire la file \a f.
 * Elle ne pourra plus être utilisée (sauf à être de nouveau initialisée)
 */
void detruire(File *f);

/**
 * L'élément en tête de la file.
 * Nécessite :
 *	! est_vide(f);
 */
char tete(File f);

/**
 * Ajouter dans la file \a f l'élément \a v.
 *
 * Nécessite :
 *	f != NULL;
 */
void inserer(File *f, char v);

/**
 * Extraire l'élément \a v en tête de la file \a f.
 * Nécessite
 *	f != NULL;
 *	! est_vide(*f);
 */
void extraire(File *f, char *v);

/**
 * Est-ce que la file \a f  est vide ?
 */
bool est_vide(File f);

/**
 * Obtenir la longueur de la file.
 */
int longueur(File f);
