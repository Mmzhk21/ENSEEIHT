#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "itineraire.h"

/**
 * \brief Afficher l'itineraire
 * \details Le nom de la file est afficher suivi d'un signe '=' avant
 * le contenu de la file.
 * Comme nous n'avons pas accès à des opérations de parcours de la liste,
 * on extraie ses éléments pour les affichers et on les ajoute de nouveau.
 */
void afficher_une_file(const char nom_file[], Itineraire *f) {
    printf("%s = ", nom_file);

    // afficher la file.
    // Principe : extraire chaque élément pour l'afficher (et linsérer).
    char *str_pt = malloc(20*sizeof(char));
    int taille = longueur(*f);
    for (int i = 0; i < taille; i++) {
        Point element;
        extraire(f, &element);
        point_tostring(str_pt, element);
        printf("-->[%s]", str_pt);
        inserer(f, element);
    }
    printf("--E");
    free(str_pt);
    putchar('\n');
}

int main()
{
    Itineraire I1;
    Point valeur;
    char *str_pt = malloc(20*sizeof(char));

    initialiser(&I1);
    assert(longueur(I1)==0);
    afficher_une_file("I1", &I1);

    initialiser_point(&valeur, 1, 1);
    inserer(&I1, valeur);
    point_tostring(str_pt, valeur);
    printf("\ninsertion de : %s \n", str_pt);
    afficher_une_file("I1", &I1);

    initialiser_point(&valeur, 2, 2);
    inserer(&I1, valeur);
    point_tostring(str_pt, valeur);
    printf("\ninsertion de : %s \n", str_pt);
    afficher_une_file("I1", &I1);

    extraire(&I1, &valeur);
    point_tostring(str_pt, valeur);
    printf("\nextraire de : %s \n", str_pt);
    afficher_une_file("I1", &I1);

    extraire(&I1, &valeur);
    point_tostring(str_pt, valeur);
    printf("\nextraire de : %s \n", str_pt);
    afficher_une_file("I1", &I1);

    detruire(&I1);
    free(str_pt);
    return EXIT_SUCCESS;
}
