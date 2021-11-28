with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;           use Ada.Float_Text_IO;
with Ada.Unchecked_Deallocation;

package body vecteurs_creux is


	procedure Free is
		new Ada.Unchecked_Deallocation (T_Cellule, T_Vecteur_Creux);


	procedure Initialiser (V : out T_Vecteur_Creux) is
	begin
		V := Null;
	end Initialiser;


	procedure Detruire (V: in out T_Vecteur_Creux) is
	begin
		if V /= Null then
			Detruire (V.all.Suivant);
			Free (V);
		else
			Null;
		end if;
	end Detruire;


	function Est_Nul (V : in T_Vecteur_Creux) return Boolean is
	begin
		return V = Null;
	end Est_Nul;


    function la_valeur (V : in T_Vecteur_Creux ; Indice : in Integer) return T_Element is
    begin

        if V = Null then
            return(0.0);
        end if;

        if V.All.Indice>Indice then
            return(0.0);
        end if;

        if Indice = V.All.Indice then
            return(V.All.Valeur);
        else
            return(la_valeur(V.all.suivant, Indice));
        end if;

    end la_valeur;

	procedure Modifier (V : in out T_Vecteur_Creux ;
				       Indice : in Integer ;
					   Valeur : in T_Element ) is
        V1: T_Vecteur_Creux;
    begin
        if V = Null then
            V := New T_Cellule;
            V.All.Indice := Indice;
            V.All.Valeur := Valeur;
            V.All.Suivant := Null;
        elsif Indice<V.All.Indice then
            V1 := New T_Cellule;
            V1.All.Indice := Indice;
            V1.All.Valeur := Valeur;
            V1.All.Suivant := V;
            V := V1;
            --V := New T_Cellule'(Indice, Valeur, V) --Terme de gauche calculer seul PUIS assignation.
        elsif Indice=V.All.Indice then
            if Valeur = 0.0 then
                V := V.All.Suivant;
            else
                V.All.Valeur := Valeur;
            end if;
        elsif Indice>V.All.Indice then
            Modifier(V.All.Suivant, Indice, Valeur);
        end if;

   end Modifier;


	function Nombre_Composantes_Non_Nulles (V: in T_Vecteur_Creux) return Integer is
	begin
		if V = Null then
			return 0;
		else
			return 1 + Nombre_Composantes_Non_Nulles (V.all.Suivant);
		end if;
	end Nombre_Composantes_Non_Nulles;
          function existe(V: in T_Vecteur_Creux; j: in integer)return Boolean is
                temp:T_Vecteur_Creux;
          begin
              temp:=V;
              while temp/=null and Then temp.all.Indice/=j loop
                    temp:=temp.all.Suivant;
              end loop;
              return(temp/=Null);
          end existe;

       Procedure modifier_vecteur(V: in out T_Vecteur_Creux;valeur: in T_Element)  is
       temp:T_Vecteur_Creux;
       begin
       temp:=V;
       while temp/=null loop
             modifier(V,temp.all.Indice,valeur);
             temp:=temp.all.Suivant;
       end loop;
       end modifier_vecteur;






end vecteurs_creux ;
