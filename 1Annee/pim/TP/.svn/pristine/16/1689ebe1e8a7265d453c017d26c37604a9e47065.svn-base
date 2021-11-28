with SDA_Exceptions;         use SDA_Exceptions;
with Ada.Unchecked_Deallocation;

package body ABR is

	procedure Free is
		new Ada.Unchecked_Deallocation (Object => T_Noeud, Name => T_ABR);


	procedure Initialiser(Sda: out T_ABR) is
	begin
		Sda := null;
	end Initialiser;


	function Est_Vide (Sda : T_ABR) return Boolean is
	begin
		return Sda=null;
	end Est_Vide;


	function Taille (Sda : in T_ABR) return Integer is
        begin
            if Sda = null then
                 return 0;
            else
            return 1+Taille(Sda.all.Sous_Arbre_Gauche)+Taille(Sda.all.Sous_Arbre_Droit)
            end if;
	end Taille;


	procedure Enregistrer (Sda : in out T_ABR ; Cle : in T_Cle ; Donnee : in T_Donnee) is
	begin
      if Sda = null then
         Sda := new T_Noeud;
         Sda.Cle := Cle;
         Sda.Donnee := Donnee;
      elsif Sda.cle = Cle then
         Sda.Donnee:= Donnee;
      else
         if Cle < Sda.cle then
            Enregistrer(Sda.Sous_Arbre_Gauche ; Cle ; Donnee);
         else
            Enregister(Sda.Sous_Arbre_Droit ; Cle ; Donnee);
         end if;
      end if;
	end Enregistrer;


   function La_Donnee (Sda : in T_ABR ; Cle : in T_Cle) return T_Donnee is
      curseur : T_ABR;
   begin
      if Sda = null then
         raise Cle_Absente_Exception;
      else
         curseur := Sda;
         while curseur.all.Cle /= Cle loop
            if Cle < curseur.all.Cle then
               curseur := curseur.all.Sous_Arbre_Gauche;
            else
               curseur := curseur.all.Sous_Arbre_Droit
            end if;
         end loop;
         if curseur = null then
            raise Cle_Absente_Exception;
         else
            return curseur.Donnee;
         end if;

	end La_Donnee;


      procedure Supprimer (Sda : in out T_ABR ; Cle : in T_Cle) is
         curseur : T_ABR;
      begin
         if Sda = null then
            raise Cle_Absente_Exception;
         elsif Sda.Cle

	end Supprimer;


	procedure Vider (Sda : in out T_ABR) is
	begin
		null;	-- TODO : à changer
	end Vider;


	procedure Pour_Chaque (Sda : in T_ABR) is
	begin
		null;	-- TODO : à changer
	end Pour_Chaque;


end ABR;
