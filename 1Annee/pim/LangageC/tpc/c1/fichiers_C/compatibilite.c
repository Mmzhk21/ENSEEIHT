#include <assert.h>
#include <stdlib.h>
int main(){
    int quantite = 5;
    float prix = 12.3;

    float total = prix * quantite; //l'entier quantité est compatible avec les flottants    
    float recette = 12; // l'entier 12 est compatible avec le flottant recette.
    assert(total == 12.3*5.0 && recette == 12.0);

    quantite = total / recette;
    assert(quantite != total / recette);
    // le réel obtenue par la division de total et recette 
    // n'est pas compatible avec l'entier quantite.
    
    return EXIT_SUCCESS;
}
