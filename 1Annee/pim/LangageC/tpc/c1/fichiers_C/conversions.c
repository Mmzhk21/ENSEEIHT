#include <stdio.h>
#include <stdlib.h>
// Liste les valeurs maximales des entiers pour votre système
#include <limits.h> 
// Liste les valeurs maximales des flottants pour votre système
#include <float.h> 

int main(){
    printf("Valeur maximale d'un entier %d \n", INT_MAX); 
    long int entier_long = -20000000; // Déclaration d'un entier long
    printf("Valeur maximale d'un entier long %ld > %ld \n\n", LONG_MAX, entier_long); 
    
    unsigned long int entier_non_signe = entier_long; // Il y a conversion implicite 
    printf("Valeur maximale d'un entier non signé %u \n", UINT_MAX); 
    printf("Valeur maximale d'un entier non signé long %lu > %lu \n\n", ULONG_MAX, entier_non_signe); 
    
    float flottant_simple = 20.13;
    double flottant_double; 
    long double long_double = 200001102.2;
    printf("Valeur maximale d'un réel simple : \n%f \n < valeur max double : \n%lf \n < valeur max long double : \n%Lf ", FLT_MAX, DBL_MAX, LDBL_MAX);
    
    return EXIT_SUCCESS;
}
