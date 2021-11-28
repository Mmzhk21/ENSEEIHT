#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
int main(){
    // Conversion du char '1' en l'entier 1
    char c_char = '1';
    int c_int = c_char - '0'; //on retire le code ascii du caractère '0'
    assert(c_int == 1);
    
    // Conversion de l'entier 1 en un char qui vaut '1' 
    int new_int = 1;
    char c_char2 = new_int + '0'; //on ajoute le code ascii du caractère '0'
    assert(c_char2 == '1');  // c_char2 est bien égal au caractère 
    
    printf("%s", "Tous les tests passent.\n");
    return EXIT_SUCCESS;
}
