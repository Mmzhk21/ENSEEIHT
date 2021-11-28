#include <stdio.h> 
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <string.h>

int main(int argc, char *argv[]){

    // Vérifier que l'utilisateur a bien entré un nom_utilisateur.
    if (argv[1] == NULL) {
        printf("Vous devez entrer un nom d'utilisateur.\n");
        // Sortir avec exit(1);
        exit(1);
    }

    // Variables utilisées
    int p1[2]; 
    int p2[2];
    //int status = 0;
    //int pid;

   pipe(p1);
   if(!fork()){
	   dup2(p1[1],1);
	   close(p1[0]);
	   close(p1[1]);
	   execlp("who","who", NULL);
  }
   pipe(p2);
   if(!fork()){
	   dup2(p1[0], 0);
	   dup2(p2[1], 1);
	   execlp("grep", "grep", argv[1], NULL);
   }
   close(p1[0]);
   close(p1[1]);
   if(!( fork())){
	   dup2(p2[0] , 0);
	   close(p2[0]);
           close(p2[1]);
           execlp("wc", "wc", "-l", NULL);
   }
   //waitpid(pid, &status);
}
