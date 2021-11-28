#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

int main() { //debut du bloc B1
    int alea = 20, diviseur = 2;
    
    { //debut du bloc B2
        
        int alea = 3; // masquage de la variable entière alea par la variable alea entière
        float diviseur = 2.0; // idem pour le diviseur réel qui masque le diviseur de type entier.
        float res_reel = alea / diviseur;
        assert(res_reel = 1.5);
        
    } // du bloc B2
    int res_int = alea / diviseur;
    assert(res_int = 10);
    
    printf("%s", "Les tests passent\n");
    return EXIT_SUCCESS;
} //fin du bloc B1
