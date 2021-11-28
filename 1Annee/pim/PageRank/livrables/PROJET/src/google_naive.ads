with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

generic
 type T_Element is digits <>;
Package Google_Naive is

   
       type T_Vecteur is array(integer range <>) of T_Element;
       type T_matrice is array(integer range <>,integer range <>) of T_element;


      function Obtenir_nb_pages(Nom: in String) return integer;
       
      procedure Matrice_Initiale(Nom: in String;H:out T_matrice);
      
      procedure matrice_H(M : in out T_matrice);
      
      function  Obtenir_Gij(i: in integer; j: in integer; H: in T_matrice ;M : in Integer;alpha:in T_Element) return T_Element;
           
      Procedure Initialiser_P(N: in integer; P: in out T_Vecteur);
      
      Procedure Trier_P(P: in out T_Vecteur;N:in integer);
      
      procedure Creer_Fichier_P(P: in T_Vecteur;N:in integer;alpha:in T_Element;Nb_it: in Integer);
      
      procedure Calculer_Rank(P: in T_Vecteur;N:in integer;V: in T_Vecteur);




end Google_naive;
