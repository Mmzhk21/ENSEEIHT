with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.IO_Exceptions;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Command_line; use Ada.Command_line;
with Ada.Strings.Unbounded;
package body Google_Naive is
   package real is new Float_IO(T_Element); use real;
   N: integer;
   File : File_type;
   alpha:T_Element:=0.85;
   function Obtenir_nb_pages(Nom: in String) return integer is
      begin
           Open(File,In_File,Nom);
           Get(File,N);
           Close(File);
           return(N);
      end Obtenir_nb_pages;
  Procedure Initialiser_H(M: in out T_Matrice) is
  begin
     for i in 0..N-1 loop
         for j in 0..N-1 loop
             M(i,j):=0.0;
         end loop;
     end loop;
  end Initialiser_H;


Procedure Trier_P(P: in out T_Vecteur;N:in integer) is
x:T_Element;
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
     U: T_Vecteur(0..N-1);
     begin
     U := P;
     for i in 0..N-1 loop
         P(i):=U(N-i-1);
     end loop;
     end;
 end Trier_P;


   procedure Matrice_Initiale(Nom: in String;H:out T_matrice) is
      i,j: integer;
begin 
     Initialiser_H(H);
     Open(File,In_File,Nom);
     Skip_Line(file);
     while not end_of_File(File) loop
               Get (File, i);
               Get(File,j);
               H(i,j) := 1.0;
     end loop;
     close(File);
end Matrice_Initiale;

function ligne_nulle(M: in T_matrice;i: integer)return boolean is
bool:boolean := True;
begin 
    for j in 0..N-1 loop
         if M(i,j) /= 0.0 then
            bool := False;
            exit;
         end if;
    end loop;
    return bool;
end ligne_nulle;

function somme_ligne(M:in T_matrice; i : integer) return T_Element is
s : T_Element:=0.0;
Begin
  for j in 0..N-1 loop
    s := s+M(i,j);
  end loop;
  return s;
end somme_ligne;

  
   procedure matrice_H(M : in out T_matrice) is 
       R : T_matrice(0..N-1,0..N-1);
   Begin
      R := M;
      for i in 0..N-1 loop
        for j in 0..N-1 loop
               if M(i,j) = 1.0 then 
                  M(i,j) := 1.0/T_Element(somme_ligne(R,i));
               else 
                  null;
               end if;
        end loop;
      end loop;
end matrice_H;
function  Obtenir_Gij(i: in integer; j: in integer; H: in T_matrice ;M : in Integer;alpha:in T_Element) return T_Element is
p:T_Element;
begin
    
      p:=H(i,j);
      if ligne_nulle(H,i) then
         return(1.0/T_Element(M));
      else
         return(alpha*p+(1.0-alpha)/T_Element(M));
      end if;
end Obtenir_Gij;

Procedure Initialiser_P(N: in integer; P: in out T_Vecteur) is
   Begin 
      
        
     for i in 0..N-1 loop
       P(i) := 1.0/T_Element(N);
         end loop;
         
   end Initialiser_P;
   procedure Calculer_Rank(P: in T_Vecteur;N:in integer;V: in T_Vecteur) is
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
   end Calculer_Rank;
   procedure Creer_Fichier_P(P: in T_Vecteur;N:in integer;alpha:in T_Element;Nb_it: in Integer) is
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
           Put(File,p(i),Fore => 1,Aft => 10);
           New_line(File);
       end loop;
       close(File);
  end Creer_Fichier_P;






end Google_Naive;
