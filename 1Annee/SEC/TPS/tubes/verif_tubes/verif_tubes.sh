#!/bin/sh
# PM,  	1/5/21 : version initiale

if [ \( "a$1" = 'a-s' \) ] ; then
	echo "préparation de l'archive à soumettre"
	rep=`whoami|cut -d' ' -f 1`-tpTubes
	mkdir "$rep"
	if [ ! \( -f etu/wgw.c \) ] ; then 
		echo "note : fichier source wgw.c non trouvé"
	else
		cp etu/wgw.c "$rep"
	fi
	if [ -f a/s ] ; then
		cp a/s "$rep"
	fi
	tar -cf "$rep".tar "$rep"
	rm -r "$rep"
	echo "prêt : vous pouvez déposer l'archive $rep.tar sous Moodle"
	exit 0
fi

export PATH=.:$PATH
res=KO
nbOK=0

gcc -Wall etu/wgw.c -o wgw

who | grep `whoami` | wc -l > ressh
wgw `whoami`> reswgw &

sleep 2

diff reswgw ressh > /dev/null
if [ $? -eq 0 ] ; then 
	nbOK=$((nbOK+1))
else
	echo "résultat ?"
fi

if [ $(pgrep wgw | wc -l) -eq 0 ] ; then 
	nbOK=$((nbOK+1))
else
	echo "terminaison ?"
fi

if [ $(cat etu/wgw.c | grep perror | wc -l) -gt 0 ] ; then 
	nbOK=$((nbOK+1))
else
	echo "test des retours appels système ?"
fi

if [ $nbOK -eq 3 ] ; then
	res=OK
fi

rm res*
rm wgw
echo "bilan : $res ($nbOK/3)"

echo $res > a/s