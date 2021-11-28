/**
 *  \author KJR <nom@n7.fr>
 *  \file itineraire.h
 *  Objectifs :
 *	.  Adapter le module File pour construire un itin�raire de points
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
// Dans la suite, adapter les sp�cifications du module File
// pour pouvoir cr�er un itin�raire

/**
 * Initialiser la file \a f.
 * La file est vide.
 *
 * Assure
 *	est_vide(*f);
 */
void initialiser(File *f);

/**
 * D�truire la file \a f.
 * Elle ne pourra plus �tre utilis�e (sauf � �tre de nouveau initialis�e)
 */
void detruire(File *f);

/**
 * L'�l�ment en t�te de la file.
 * N�cessite :
 *	! est_vide(f);
 */
char tete(File f);

/**
 * Ajouter dans la file \a f l'�l�ment \a v.
 *
 * N�cessite :
 *	f != NULL;
 */
void inserer(File *f, char v);

/**
 * Extraire l'�l�ment \a v en t�te de la file \a f.
 * N�cessite
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
