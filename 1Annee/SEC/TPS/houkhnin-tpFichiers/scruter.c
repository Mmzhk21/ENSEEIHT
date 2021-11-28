#include <stdio.h>    
#include <stdlib.h>   
#include <unistd.h>   
#include <sys/wait.h> 
#include <string.h>   
#include <fcntl.h>    


int main(int argc, char **argv)
{
  
  int descripteur, i, j;                    
  char fichier[] = "temp.txt"; 
  pid_t pid;                   

  pid = fork();
  
  if (pid < 0)
  {
    perror("Erreur fork");
    exit(1);
  }
  if (pid == 0)
  {
    descripteur = open(fichier, O_WRONLY | O_CREAT | O_TRUNC, 0640);
    if (descripteur < 0)
    {
      perror("Erreur d'ouverture!");
      exit(1);
    }
    for (i = 1; i <= 30; i++)
    {
      sleep(1); 
      if (write(descripteur, &i, sizeof(int)) < 0)
      {
        perror("Erreur d'ecriture!");
        exit(1);
      }
      printf("fils = %d\n", i);
      if (i == 10 || i == 20)
      {
        if (lseek(descripteur, 0, SEEK_SET) < 0)
        {
          perror("Erreur LSEEK ! ");
          exit(1);
        }
      }
    }
    if (close(descripteur) < 0)
    {
      perror("Erreur fermeture de temp.txt!");
      exit(1);
    }
    exit(0);
  }
  if (pid > 0)
  {
    descripteur = open(fichier, O_RDONLY | O_CREAT, 0640);
    if (descripteur < 0)
    {
      perror("Erreur ouverture de temp.txt!");
      exit(1);
    }
    sleep(1);
    for (i = 1; i <= 3; i++)
    {
      sleep(10);
      while (read(descripteur, &j, sizeof(int)))
      {
        printf("%d\n", j);
      }
      if (lseek(descripteur, 0, SEEK_SET) < 0)
      {
        perror("Erreur LSEEK! ");
        exit(1);
      }
    }
    if (close(descripteur) < 0)
    {
      perror("Erreur fermeture de temp.txt!");
      exit(1);
    }
  }
  return EXIT_SUCCESS;
}
