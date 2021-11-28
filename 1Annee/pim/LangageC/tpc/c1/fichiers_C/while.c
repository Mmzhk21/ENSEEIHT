#include <stdlib.h>
#include <stdio.h>

#define LIMITE 300

int main(void) {
    int prec = 1, un = 2;
    int rang = 2;
    int nouveau;

    while (un < LIMITE) {
        // Determiner le nouveau terme de la suite de Fibonacci
        nouveau = un + prec;
        // Enregistrer les termes un et prec
        prec = un;
        un = nouveau;
        // Calculer le rang
        rang ++;
    } 
    printf("La valeur de la suite de fibonacci >= %d est %d. Elle est de rang %d\n", LIMITE, un, rang);
    
    return EXIT_SUCCESS;
}
