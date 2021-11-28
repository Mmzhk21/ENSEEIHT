#include <stdlib.h> 
#include <stdio.h>
#include <assert.h>
#include <stdbool.h>

// Definition du type monnaie
struct monnaie { //T_Monnaie est un enregistrement d'un valeur et une devise . 
    char devise;
    int valeur;
};
typedef struct monnaie monnaie;    //La création d'un alias de notre type pour faciliter sa manipulation .  

/**
 * \brief Initialiser une monnaie 
 * \param[out] Monnaie  un pointeur sur le type T_Monnaie
 * \param[in] Valeur la valeur de la monnaie,
 * \param[in] Devise la devise de la monnaie,
 * \pre Valeur > 0
 * \post monnaie.Valeur == Valeur , monnaie.Devise == Devise 
 */ 
void initialiser(monnaie monnaie,float Valeur,char Devise) {
    assert(Valeur > 0);
    monnaie.Valeur = Valeur;
    monnaie.Devise = Devise;
}

/**
 * \brief Ajouter une monnaie m2 à une monnaie m1 
 * \param[in] m1 le premier paramètre m1 est de type monnaie ( Mode IN ) car la valeur de m1 restera inchangée.
 *            
 * \param[in out] m2 le deuxième paramètre m2 est un pointeur sur type monnaie ( Mode IN OUT ) car la valeur de m2 va être changée 
 */ 
bool ajouter(monnaie m1,T_Monnaie m2) {
    bool T = false;
    if (m1.Devise == m2.Devise) {
        T = true;
        m2.Valeur = m1.Valeur + m2.Valeur;
    } else {
        T = false;
        printf("Erreur, La devise des deux monnaies à sommer dans votre teste n'est pas identique\n\n");
    }
       return T;

}



/**
 * \brief Tester Initialiser 
 * \param[out] : m1 un monnaie de type monnaie qu'on initialisera .
 * \param[out] : m2 une monnaie de type monnaie qu'on initialisera .
 * \param[in] : a1,a2,c1,c2 désignant les valeurs et le devises des deux monnaies.
 */ 

void tester_initialiser() {
    
    monnaie m1,m2;
    initialiser(&m1,5.0,'$');
    initialiser(&m2,6.0,'$');
    const float a1 = m1.Valeur;
    const float a2 = m2.Valeur;
    const char c1 = m1.Devise;
    const char c2 = m2.Devise;
    assert(a1 == 5.0 && a2 == 6.0);
    assert(c1 == '$' && c2 == '$');
}

/**
 * \brief Tester Ajouter 
 * \param[out] : m1 une monnaie à initialiser avec une somme et une devise
 * \param[out] : m2 une monnaie à initialiser avec une somme et une devise
 * \param[in] : a1,a2,c1,c2 désignant les valeurs et les devises des deux monnaies.
 */ 

void tester_ajouter() {   

    monnaie m1,m2;
    initialiser(&m1,5.0,'$');
    initialiser(&m2,6.0,'$');
    ajouter(Monnaie_1,&m2);
    const float a1 = m1.Valeur;
    const float a2 = m2.Valeur;
    const char c1 = m1.Devise;
    const char c2 = m2.Devise;
    assert(a1 == 5.0 && a2 == 11.0);
    assert(c1 == '$' && c2 == '$');
}



int main(void){
    // Un tableau de 5 monnaies
    monnaie porte_monnaie[5];

    //Initialiser les monnaies
        for(int i = 0; i < 5; i++) {
        int valeur;
        char devise;
        printf("Donner la valeur et la devise de la monnaie #%i: ", i+1);
        scanf("%lf %c", &valeur, &devise);
        porte_monnaie[i].devise = devise;
        porte_monnaie[i].valeur = valeur;
    }
 
    // Afficher la somme des toutes les monnaies qui sont dans une devise entrée par l'utilisateur.
      char devise;
      int somme = 0;
      printf("Donner la devise dont vous voulez calculer la somme: ");
      scanf(" %c", &devise);
      for(int i = 0; i < 5; i++) {
        somme += porte_monnaie[i].devise == devise ? porte_monnaie[i].valeur : 0;
      }

    printf("La somme des devises %c est %lf", devise, somme);

    return EXIT_SUCCESS;
}
