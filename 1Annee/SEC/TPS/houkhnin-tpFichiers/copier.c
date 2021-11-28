#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <string.h>
#include <fcntl.h>

#define nbEntrees 4096

int main(int argc, char **argv)
{

  int descripteur1;
  int descripteur2;
  char buffer[nbEntrees];

  bzero(buffer, sizeof(buffer));
  descripteur1 = open(argv[1], O_RDONLY);

  if (descripteur1 < 0)
    {
      perror("Erreur d'ouverture source.txt ");
      exit(1);
    }
  descripteur2 = open(argv[2], O_CREAT | O_WRONLY, 0640);

  if (descripteur2 < 0)
  {
    perror("Erreur d'ouverture cible.txt ");
    exit(1);
  }
  while (read(descripteur1, buffer, sizeof(buffer)) > 0)
    {
      if (write(descripteur2, buffer, sizeof(buffer)) < 0)
      {
        perror("Erreur d'ecriture cible.txt");
        exit(1);
      }
      bzero(buffer, sizeof(buffer));
    }

  if (close(descripteur1) < 0)
    {
      perror("Erreur de fermeture source.txt");
      exit(1);
    }
  if (close(descripteur2) < 0)
  {
    perror("Erreur de fermeture cible.txt ");
    exit(1);
  }
  return EXIT_SUCCESS;
}
