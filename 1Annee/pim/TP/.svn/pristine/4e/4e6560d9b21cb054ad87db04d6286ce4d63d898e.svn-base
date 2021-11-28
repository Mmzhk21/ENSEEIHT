ephemeride: date.o ephemeride.o
	c99 date.o ephemeride.o -o ephemeride

date.o: date.c date.h
	c99 -Wextra -pedantic -c date.c

ephemeride.o: ephemeride.c
	c99 -Wextra -pedantic -c ephemeride.c

clean:
	rm *.o ephemeride
# DO NOT DELETE

EDT.o: cours.h salle.h date.h enseignant.h
cours.o: cours.h salle.h date.h enseignant.h
date.o: date.h
enseignant.o: enseignant.h date.h
ephemeride.o: date.h
salle.o: salle.h date.h
