with Ada.IO_Exceptions;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Command_line; use Ada.Command_line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Google_Naive;
with google_creuse; use google_creuse;
with vecteurs_creux;
with GNAt.OS_Lib;
procedure Pagerank is
N:integer;
file:File_Type;
Nb_it:integer:=150;

package Google is new Google_Naive(Float); use Google;
alpha:Float:=0.85000002384;
T:Float;
procedure stop is
begin
   GNAT.OS_Lib.OS_Exit(0);
end stop;
procedure pagerank_creuse is
begin
N:=Obtenir_nb_pages_c(Argument(Argument_Count));
declare
P:T_Vecteur_c(0..N-1);
V:T_Vecteur_c(0..N-1);
H:T_matrice_c(0..N-1);
begin
Matrice_Initiale_c(Argument(Argument_Count),H,N);
matrice_H_c(H,N);
Initialiser_P_c(N,P);

V:=P;
for k in 1..Nb_it loop
    for i in 0..N-1 loop
        T:=0.0;
        for j in 0..N-1 loop
            T:=T+P(j)*Obtenir_Gij_c(Argument(Argument_Count),j,i,H,N,alpha);
        end loop;
        V(i):=T;
    end loop;
    P:=V;
end loop;
V:=P;
Trier_P_c(P,N);
fichier_pagerank_c(P,N,V);
Creer_Fichier_P_c(P,N,alpha,Nb_it);
Vider_c(H);
end;
end pagerank_creuse;
Procedure pagerank_naive is
begin
N:=Obtenir_nb_pages(Argument(Argument_Count));
declare
P:T_Vecteur(0..N-1);
V:T_Vecteur(0..N-1);
H:T_matrice(0..N-1,0..N-1);
begin
Matrice_Initiale(Argument(Argument_Count),H);
matrice_H(H);
Initialiser_P(N,P);
V:=P;

for k in 1..Nb_it loop
    for i in 0..N-1 loop
        T:=0.0;
        for j in 0..N-1 loop
            T:=T+P(j)*Obtenir_Gij(j,i,H,N,alpha);
        end loop;
        V(i):=T;
    end loop;
    P:=V;
end loop;
V:=P;
Trier_P(P,N);
Calculer_Rank(P,N,V);
Creer_Fichier_P(P,N,alpha,Nb_it);
end;
exception
      when Name_Error=> Put("Vous devez entrer un fichier existant et valide");
end pagerank_naive;

begin

if Argument_Count=2 Then
   alpha:=0.85;
   nb_it:=150;
   if Argument(1)="-P" then
      pagerank_naive;
   else
      pagerank_creuse;
   end if;
else
   if Argument_Count>6 then
       Put("Vous devez entrez un A ou I après un tiret");
       New_Line;
       stop;
   end if;
   if Argument(1)/="-P" then
      N:=Obtenir_nb_pages(Argument(Argument_Count));
      if Argument_Count>2 And then Argument(1)(1)='-' then
            if length(To_Unbounded_String(Argument(1)))/=2 then
               Put("Vous devez entrez un A ou I après le tiret");
               new_line;
               stop;
            else
               case Argument(1)(2) is
                 when 'I' => nb_it:=Integer'Value(Argument(2));


                 when 'A' => Put("Vous devez rentrer le nombre d'itération avant alpha");
                           stop;

                 when others => Put("vous devez entrer un entier après -A ou -I");
                              stop;

               end case;
            end if;
       end if;
      if Argument_Count>4 and then Argument(3)(1)='-' then
             if length(To_Unbounded_String(Argument(3)))/=2 then
                  Put("Vous devez entrez un A ou I après le tiret");
                  new_line;
                  stop;
             else
                   case Argument(3)(2) is

                   when 'A' => alpha:=Float'Value(Argument(4));


                   when 'I' => Put("Vous devez rentrer le nombre d'itération avant alpha");
                           stop;



                   when others => Put("vous devez entrer un entier après -A ou -I");
                              stop;

                   end case;
             end if;

       end if;
       pagerank_creuse;
   else

   N:=Obtenir_nb_pages(Argument(Argument_Count));
   if Argument_Count>3 And then Argument(2)(1)='-' then
      if length(To_Unbounded_String(Argument(2)))/=2 then
         Put("Vous devez entrez un A ou I après le tiret");
         new_line;
         stop;
      else
          case Argument(2)(2) is
               when 'I' => nb_it:=Integer'Value(Argument(3));


               when 'A' => Put("Vous devez rentrer le nombre d'itération avant alpha");
                           stop;

               when others => Put("vous devez entrer un entier après -A ou -I");
                              stop;

          end case;
      end if;

   end if;

   if Argument_Count>5 and then Argument(4)(1)='-' then
      if length(To_Unbounded_String(Argument(4)))/=2 then
         Put("Vous devez entrez un A ou I après le tiret");
         new_line;
         stop;
      else
          case Argument(4)(2) is

               when 'A' => alpha:=Float'Value(Argument(5));


               when 'I' => Put("Vous devez rentrer le nombre d'itération avant alpha");
                           stop;



               when others => Put("vous devez entrer un entier après -A ou -I");
                              stop;

          end case;
      end if;

   end if;
   pagerank_naive;
   end if;
end if;








end Pagerank;
