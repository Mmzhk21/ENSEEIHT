Avertissement
-------------
Le script de vérification `verif_signaux.sh` doit être considéré comme un simple outil mis
 à votre disposition, pour vous fournir une indication quant à la viabilité de vos réponses,
  et non  comme une application de validation automatique de votre travail. Simplement, 
  si vous passez la vérification, vous pouvez avoir bon espoir quant à l'évaluation 
  effective. Et inversement.

En particulier :

  - il est inutile de modifier le script pour qu'il donne une réponse `OK` : la validation
  se fera sur nos propres outils.
  - le script n'est pas protégé contre les erreurs résultant de (mauvaises) actions liées
  à l'exécution de vos programmes. Par exemple si votre programme détruit des fichiers
  de manière intempestive, le script de vérification peut devenir invalide.
  Il est donc prudent de prévoir une sauvegarde de l'original, si vous voulez être prémunis
   contre ce genre d'accidents.
  - en revanche, le script de vérification fonctionne bien avec des réponses correctes.
    Par conséquent, si une erreur est signalée sur une ligne du script, vous pouvez être
    quasi-certains que cela ne découle pas d'une erreur dans le script de test.

Conventions de nommage
----------------------

Pour que le script de vérification `verif_signaux.sh` puisse être appliqué :

  - le fichier source du programme à vérifier doit être **exactement** nommé `etu.c` et 
    rangé dans le répertoire `etu`, situé au même niveau que `verif_signaux.sh`
  - le #!/bin/sh
# PM, le 6/4/21
# Laurent le 8/4 : correction typo
# PM, le 9/4 : relaxation du scénario et du test

if [ \( "a$1" = 'a-s' \) ] ; then
	echo "préparation de l'archive à soumettre"
	rep=`whoami|cut -d' ' -f 1`-tpSignaux
	mkdir "$rep"
	if [ ! \( -f etu/reponses \) ] ; then 
		echo "note : fichier reponses non trouvé"
	else
		cp etu/reponses "$rep"
	fi
	if [ ! \( -f etu/etu.c \) ] ; then 
		echo "note : fichier source etu.c non trouvé"
	else
		cp etu/etu.c "$rep"
	fi
	cp a/s "$rep"
	tar -cf "$rep".tar "$rep"
	rm -r "$rep"
	echo "prêt : vous pouvez déposer l'archive $rep.tar sous Moodle"
	exit 0
fi

export PATH=.:$PATH
res=KO

gcc -Wall etu/etu.c -o sgnetu
gcc -Wall a/kro.c -o a/bar

a/bar > hurz
aleph=`cat hurz | head -1`
o6=`cat hurz | tail -1`
jack=`cat a/b/core`

echo "10 secondes..."

sgnetu > foo &

pid=`ps| grep sgnetu | grep -v grep | cut -d ' ' -f1`

sleep  4

kill -USR1 $pid

sleep 5

kill -USR2 $pid

sleep 8

kill -USR1 $pid
kill -USR2 $pid


r3=`cat foo | grep "$jack $aleph" | wc -l`

echo "encore 10 secondes..."

sleep 10

r4=`cat foo | grep "$jack $o6" | wc -l`
r2=`cat foo | grep "$jack $aleph" | wc -l`
r5=`cat foo | grep Salut | wc -l`
if [ \( $r5 -eq 1 \) -a \( $((r4/r2)) -eq $(cat a/pfurz) \) ] ; then 
	res=OK
fi

echo $res > a/s
echo $res                                                                                                                                                     