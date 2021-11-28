#include <stdio.h>

// Definition d'une fonction f1
int f1(int valeur) { 
    printf("   valeur au début de f1 : %i \n", valeur);
    valeur = 0;
    printf("   valeur à la fin de f1 : %i \n", valeur);
    return valeur;
}

int main(){
    int donnee = 20;
    printf("donnee dans main() avant f1 : %i  \n", donnee);
    int donnee_retournee = f1(donnee); // la fonction utilise la valeur de donnee
    printf("donnee dans main() après f1 : %i  \n", donnee);
    printf("donnee_retournee dans main() : %i \n", donnee_retournee); 
}
