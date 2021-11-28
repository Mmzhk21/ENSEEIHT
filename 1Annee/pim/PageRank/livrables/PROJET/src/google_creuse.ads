with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with vecteurs_creux;

Package google_creuse is
package vecteurs is new vecteurs_creux(float);
   use vecteurs;

       type T_Vecteur_c is array(integer range <>) of float;

       type T_matrice_c is array(integer range <>) of T_Vecteur_Creux;

    -- obtenir le nombres de pages
       function Obtenir_nb_pages_c(Nom: in String) return integer;

    -- Initialiser une matrice creuse..
       procedure Initialiser_m_c(H: in out T_matrice_c;N: in integer);

    -- initialiser la matrice creuse par des uns et des zeros.
       procedure Matrice_Initiale_c(Nom: in String;H:in out T_matrice_c;N: in integer);

   --Vider la matrice creuse H.
      procedure Vider_c(H: in out T_matrice_c);

   --obtenir le coefficient de la ligne i et la colone j de la matrice G
      function  Obtenir_Gij_c(Nom: in String;i: in integer; j: in integer; H: in T_matrice_c ;N: in Integer;alpha:in float) return float;

    --initialiser un tableau par 1/N.
      Procedure Initialiser_P_c(N: in integer; P: in out T_Vecteur_c);

      -- creer la matrice H
      procedure matrice_H_c(H: in out T_matrice_c; N: in integer);

       -- Trier le vecteur P des poids par ordre décroissant
      Procedure Trier_P_c(P: in out T_Vecteur_c;N:in integer);

       -- Creer le fichier réseau.p des poids
      procedure Creer_Fichier_P_c(P: in T_Vecteur_c;N:in integer;alpha:in float;Nb_it: in Integer);

       --- creer le fichier reseau.ord des pageranks
      procedure fichier_pagerank_c(P: in T_Vecteur_c;N:in integer;V: in T_Vecteur_c);





end google_creuse;
