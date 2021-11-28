#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

int main(){
    int quantite = 10; 
    int prix = 15;

    int total = quantite * prix; 
    assert(total == 150);
    
    float nb_personnes = 60;
    float prix_par_personne = total / nb_personnes;
    assert(prix_par_personne == 2.5);
    
    int nb_personnes_int = 60;
    prix_par_personne = total / nb_personnes_int;
    assert(prix_par_personne != 2.5); // Quelle est la valeur de prix_par_personne ici ?
    
    printf("Le prix par personne est de %f euros", prix_par_personne);
    return EXIT_SUCCESS;
}
