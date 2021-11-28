
#include <stdio.h>

// Definition d'une fonction f1 avec un paramètre pointeur qui 
// peut enregistrer d'adresse d'un entier
int f1(int* valeur) { 
    *valeur += *valeur; // Accès à la variable au travers du pointeur. 
    printf("valeur dans f1 après incrémentation : %i \n", *valeur);
    return *valeur;
}

int main(){
    int donnee = 20;
    // Pour utiliser la fonction, on donne l'adresse de la variable  
    int nouvelle_donnee = f1(&donnee); 
    printf("donnee dans main() après incrémentation : %i  \n", donnee);
    printf("nouvelle_donne dans main() : %i \n", nouvelle_donnee); 
}
