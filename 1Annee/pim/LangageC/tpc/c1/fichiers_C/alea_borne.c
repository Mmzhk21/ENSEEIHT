
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <assert.h>
/*
 * \brief Obtenir une valeur aléatoire entre min et max, inclus.
 * \param[in] min borne minimale, 
 * \param[in] max borne maximale, 
 * \return valeur aleatoire entre min et max
 * \pre min >= 0, max <= RAND_MAX
 */ 
int alea_borne(int min, int max){
    assert(min >= 0);
    assert(max <= RAND_MAX);
    
    // Initialisation du générateur de nombres aléatoires avec la date courante
    srand(time(NULL));
    int alea;
    do {
        alea = rand(); // valeur aléatoire entre 0 et RAND_MAX
    }
    while (alea < min || alea > max);
    return alea;
}

int main(void) {
    int val = alea_borne(4, 10);
    assert(val >= 4 && val <= 10);
    printf("val = %d\n", val);
    
    val = alea_borne(2, 25);
    assert(val >= 2 && val <= 25);
    printf("val = %d\n", val);
    return EXIT_SUCCESS;
}
