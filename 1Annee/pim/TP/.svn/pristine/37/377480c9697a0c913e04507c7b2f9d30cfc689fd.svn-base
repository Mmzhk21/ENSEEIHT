
-- Définition de structures de données associatives sous forme d'un arbre
-- binaire de recherche (ABR).
generic
	type T_Cle is private;
	type T_Donnee is private;
	with function "<" (Gauche, Droite : in T_Cle) return Boolean;

package ABR is

	type T_ABR is limited private;

	-- Initialiser une Sda.  La Sda est vide.
	procedure Initialiser(Sda: out T_ABR) with
		Post => Est_Vide (Sda);


	-- Est-ce qu'une Sda est vide ?
	function Est_Vide (Sda : T_ABR) return Boolean;


	-- Obtenir le nombre d'éléments d'une Sda. 
	function Taille (Sda : in T_ABR) return Integer with
		Post => Taille'Result >= 0
			and (Taille'Result = 0) = Est_Vide (Sda);


	-- Enregistrer une Donnée associée à une Clé dans une Sda.
	-- Si la clé est déjà présente dans la Sda, sa donnée est changée.
	procedure Enregistrer (Sda : in out T_ABR ; Cle : in T_Cle ; Donnee : in T_Donnee) with
		Post => (La_Donnee (Sda, Cle) = Donnee),   -- donnée insérée
		Contract_Cases => (others =>
				(Taille (Sda) = Taille (Sda)'Old or Taille (Sda) = Taille (Sda)'Old + 1));

	-- Supprimer la Donnée associée à une Clé dans une Sda.
	-- Exception : Cle_Absente_Exception si Clé n'est pas utilisée dans la Sda
	procedure Supprimer (Sda : in out T_ABR ; Cle : in T_Cle) with
		Post =>  Taille (Sda) = Taille (Sda)'Old - 1; -- un élément de moins


	-- Obtenir la donnée associée à une Cle dans la Sda.
	-- Exception : Cle_Absente_Exception si Clé n'est pas utilisée dans l'Sda
	function La_Donnee (Sda : in T_ABR ; Cle : in T_Cle) return T_Donnee;


	-- Supprimer tous les éléments d'une Sda.
	procedure Vider (Sda : in out T_ABR) with
		Post => Est_Vide (Sda);


	-- Appliquer un traitement (Traiter) pour chaque couple d'une Sda.
	-- Le parcours est infixe : on traite le sous-arbre gauche, puis le
	-- noeud, puis le sous-arbre droit.
	generic
		with procedure Traiter (Cle : in T_Cle; Donnee: in T_Donnee);
	procedure Pour_Chaque (Sda : in T_ABR);


private

	type T_Noeud;
	type T_ABR is access T_Noeud;
	type T_Noeud is
		record
			Cle: T_Cle;
			Donnee : T_Donnee;
			Sous_Arbre_Gauche : T_ABR;
			Sous_Arbre_Droit : T_ABR;
			-- Invariant
			--    Pour tout noeud N dans Sous_Arbre_Gauche, N.Cle < Cle
			--    Pour tout noeud N dans Sous_Arbre_Droit,  N.Cle > Cle
		end record;

end ABR;
