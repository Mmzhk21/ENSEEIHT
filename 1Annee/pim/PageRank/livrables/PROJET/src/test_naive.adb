with Ada.IO_Exceptions;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Command_line; use Ada.Command_line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Google_Naive;
procedure test_naive is
N:integer;
file:File_Type;
Nb_it:integer:=150;

package Google is new Google_Naive(Float); use Google;
alpha:Float:=0.85000002384;
Procedure tester_google_naive is
begin


N:=Obtenir_nb_pages(Argument(Argument_Count));
declare
P:T_Vecteur(0..N-1);
V:T_Vecteur(0..N-1);
H:T_matrice(0..N-1,0..N-1);
begin
Put("---------------------test Obtenir_Nb_pages--------------------------");
new_line;
pragma Assert(Obtenir_nb_pages(Argument(1))=6);
put("---------------------test Obtenir_Nb_pages: ok-------------------");

new_line;
put("---------------------debut test Matrice initiale -----------------");
new_line;
Matrice_Initiale(argument(1),H);
pragma Assert(H(0,1)=1.0 and H(0,2)=1.0 and H(2,0)=1.0 and H(2,1)=1.0 and H(2,4)=1.0);
pragma Assert(H(3,4)=1.0 and H(3,5)=1.0 and H(4,5)=1.0 and H(4,3)=1.0);
for i in 0..5 loop
    pragma Assert(H(1,i)=0.0);
end loop;
put(" ---------------- test Matrice initiale: OK ----------------");
new_line;

put("-----------------debut test Matrice_H -----------------");
new_line;
Matrice_Initiale(argument(1),H);
matrice_H(H);
pragma Assert(H(0,1)=0.5 and H(0,2)=0.5 and H(2,0)=1.0/3.0 and H(2,1)=1.0/3.0 and H(2,4)=1.0/3.0);
pragma Assert(H(3,4)=0.5 and H(3,5)=0.5 and H(4,5)=0.5 and H(4,3)=0.5);
for i in 0..5 loop
    pragma Assert(H(1,i)=1.0/6.0);
end loop;
put("------------------test matrice_H: ok --------------------");
new_line;
put("-----------------debut test Obtenir_Gij -----------------");
new_line;
N:=Obtenir_nb_pages(Argument(1));
Matrice_Initiale(argument(1),H);
matrice_H(H);
pragma Assert(Obtenir_Gij(0,0,H,N,alpha)=(1.0-alpha)/float(N));
pragma Assert(Obtenir_Gij(4,0,H,N,alpha)=(1.0-alpha)/float(N));
pragma Assert(Obtenir_Gij(3,5,H,N,alpha)=alpha*0.5 + (1.0-alpha)/float(N));
pragma Assert(Obtenir_Gij(2,5,H,N,alpha)=(1.0-alpha)/float(N));
pragma Assert(Obtenir_Gij(1,5,H,N,alpha)=1.0/float(N));
pragma Assert(Obtenir_Gij(3,2,H,N,alpha)=(1.0-alpha)/float(N));
pragma Assert(Obtenir_Gij(4,4,H,N,alpha)=(1.0-alpha)/float(N));
pragma Assert(Obtenir_Gij(4,1,H,N,alpha)=(1.0-alpha)/float(N));
put("-------------------- test Obtenir_Gij: Ok---------------------");
new_line;
Put("------------------ debut tester Initialiser-P -----------------------");
new_line;

N:=Obtenir_nb_pages(Argument(1));
Initialiser_P(N,P);
for i in 0..N-1 loop
    pragma Assert(P(i)=1.0/float(N));
end loop;
Put("------------------ tester Initialiser-P: Ok -----------------------");
new_line;
Put("------------------------ Debut test trier_P ---------------------");
new_line;
P(0):=5.5;
P(1):=5.0;
P(2):=3.5;
P(3):=9.5;
P(4):=1.5;
P(5):=2.0;
Trier_P(P,N);
Pragma Assert(P(0)=9.5 and P(1)=5.5 and P(2)=5.0);
put("------------------------- test Trier_P :Ok--------------------");
new_line;
end;
end tester_google_naive;
begin
tester_google_naive;
end test_naive;
