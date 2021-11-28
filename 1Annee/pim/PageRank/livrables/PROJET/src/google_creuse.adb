with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.IO_Exceptions;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Command_line; use Ada.Command_line;
with Ada.Strings.Unbounded;
with vecteurs_creux;
package body google_creuse is

   N,Entier1,Entier2: integer;
   File : File_type;
   alpha:float:=0.85;


   --obtenir le nombre de pages dans le reseau.
   function Obtenir_nb_pages_c(Nom: in String) return integer is
      begin
           Open(File,In_File,Nom);
           Get(File,N);  -- lire le premier entier dans le fichier.
           Close(File);
           return(N);
   end Obtenir_nb_pages_c;
      
     --   -- Initialiser une matrice creuse.. 
   procedure Initialiser_m_c(H: in out T_matrice_c;N: in integer) is
      begin
      for i in 0..N-1 loop
          Initialiser(H(i));
      end loop;
      end Initialiser_m_c;

     -- Nombre de pages referenciées par i
    function frequence(M: in T_matrice_c;i : in integer) return integer is
   temp:T_Vecteur_Creux;
   begin
     return(Nombre_Composantes_Non_Nulles(M(i)));


    end frequence;
   
   
   -- Est ce que la page i Referencier la page j
function Referencier(H: in T_matrice_c;i: in integer;j: in integer) return Boolean is
   temp:T_Vecteur_Creux;
   bool:Boolean:=False;
   begin
   return( existe(H(i),j));
   end Referencier;
   
   -- Vider la matrice H
   procedure Vider_c(H: in out T_matrice_c) is
   begin
   for i in 0..N-1 loop
       Detruire(H(i));
   end loop;
   end Vider_c;

    -- Crée une matrice des zéros et des uns.
   procedure Matrice_Initiale_c(Nom: in String;H:in out T_matrice_c;N: in integer) is
   begin
     Initialiser_m_c(H,N);
     Open(File,In_File,Nom);
     Skip_Line(file);
     while not end_of_File(File) loop
               Get (File, Entier1); -- page source.
               Get(File,Entier2); --page cible.
               Modifier(H(Entier1),Entier2,1.0);
     end loop;
     close(File);
   end Matrice_Initiale_c;



-- Creer la matrice H
 procedure matrice_H_c(H: in out T_matrice_c; N: in integer) is
 begin

   for i in 0..N-1 loop
       for j in 0..N-1 loop
           if Referencier(H,i,j) Then
               modifier(H(i),j,1.0/float(frequence(H,i)));
           else
               null;
           end if;
       end loop;
   end loop;

 end matrice_H_c;
 
    -- Obtenir le coefficient G(i,j)
   function  Obtenir_Gij_c(Nom: in String;i: in integer; j: in integer; H: in T_matrice_c ;N: in Integer;alpha:in float) return float is
   begin

   if Est_Nul(H(i)) Then
         return(1.0/Float(N));

   else
      return(alpha*la_valeur(H(i),j)+(1.0-alpha)/float(N));
   end if;
   end Obtenir_Gij_c;
   
   --Initialiser le vecteur des poids
   Procedure Initialiser_P_c(N: in integer; P: in out T_Vecteur_c) is
   Begin
      for i in 0..N-1 loop
          P(i) := 1.0/Float(N);
      end loop;
   end Initialiser_P_c;
   
   -- Creer le fichier des pageranks
   procedure fichier_pagerank_c(P: in T_Vecteur_c;N:in integer;V: in T_Vecteur_c) is
   Nom_fichier:String:="reseau.ord";
   begin
       Create(File,Out_File,Nom_fichier);
       Close(File);
       open(File,Append_File,Nom_fichier);
       for i in 0..N-1 loop
           for j in 0..N-1 loop
               if V(j)=P(i) Then
                  Put(File,j);
                  New_line(File);
               else
                   Null;
               end if;
           end loop;
       end loop;
      close(File);
   end fichier_pagerank_c;
   
   -- Creer le fichier de poids.
   procedure Creer_Fichier_P_c(P: in T_Vecteur_c;N:in integer;alpha:in float;Nb_it: in Integer) is
      Nom_fichier:String:="reseau.p";
   begin
       Create(File,Out_File,Nom_fichier);
       Close(File);
       open(File,Append_File,Nom_fichier);
       put(File,N);
       put(File,' ');
       put(File,alpha,Fore => 1,Aft => 10);
       put(File,' ');
       put(File,Nb_it);
       new_line(File);
       for i in 0..N-1 loop
           put(File,p(i),Fore => 1,Aft => 10);
           New_line(File);
       end loop;
       close(File);
  end Creer_Fichier_P_c;
  
  -- Trier le vecteur des poids
Procedure Trier_P_c(P: in out T_Vecteur_c;N:in integer) is
x:float;
j:integer;
begin
   for i in 0..N-2 loop

       j:=i;
         for k in i+1..N-1 loop
            if P(k)<P(j) then
               j:=k;
            end if;
         end loop;
         if j/= i then
            x := P(i);
            P(i) := P(j);
            P(j):=x;
         end if;
      end loop;
   declare
     U: T_Vecteur_c(0..N-1);
     begin
       U := P;
       for i in 0..N-1 loop
         P(i):=U(N-i-1);
       end loop;
     end;
 end Trier_P_c;
















end google_creuse;
