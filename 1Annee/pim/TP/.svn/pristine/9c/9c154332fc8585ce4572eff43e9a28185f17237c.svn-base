generic
	type T_Element is private;

package Listes is

	type T_Liste is limited private;

	Indice_Error: Exception;	-- Un indice est invalide
	Element_Absent_Error: Exception;	-- Élément non trouvé


	-- Initialiser une liste.
	procedure Initialiser (Liste: out T_Liste) with
		Post => Taille (Liste) = 0;


	-- Détruire une liste et libérer toutes les ressources qu'elle utilise.
	-- Une liste détruite ne doit plus être utilisée.
	procedure Detruire (Liste: in out T_Liste);


	-- Ajouter un nouvel élément au début d'une liste.
	procedure Ajouter_Debut (Liste: in out T_Liste; Element: T_Element) with
		Post => Taille (Liste) > 0 and then Ieme (Liste, 0) = Element;


	-- Retourner le premier élément d'une liste.
	-- Exception : Element_Absent_Error si la liste est vide
	function Premier (Liste: in T_Liste) return T_Element;


	-- Retourner la taille d'une liste.
	function Taille (Liste: in T_Liste) return Integer;


	-- Afficher les éléments d'une liste en révélant la structure interne.
	-- Par exemple : -->[1]-->[3]-->[1]-->[2]--E
	--! Cette opération serait plutôt utilisée à des fin de mise au point et
	--! pourrait rester locale au module.  Pour l'utilisateur du module
	--! une procédure qui affiche [1, 3, 1, 2] serait plus utile.
	generic
		with procedure Afficher_Element (Element: in T_Element);
	procedure Afficher (Liste: in T_Liste);


	-- Retourner vrai ssi Element est dans Liste.
	function Est_Present (Liste: in T_Liste; Element: in T_Element) return Boolean;


	-- Suppprimer la première occurrence de Element dans Liste.
	-- Exception : Element_Absent_Error si l'élément n'est pas trouvé.
	procedure Supprimer (Liste: in out T_Liste; Element: in T_Element);


	-- Insérer un nouvel élément (Nouveau) dans la liste (Liste) après un
	-- élément existant (Element).
	-- Exception : Element_Absent_Error si Element n'est pas dans la liste
	procedure Inserer_Apres (Liste: in out T_Liste; Nouveau, Element: in T_Element);


	-- Retourner l'élément à la position Indice dans la Liste.
	-- Le premier élément est à l'indice 0.
	-- Exception : Indice_Error si l'indice n'est pas valide
	function Ieme (Liste: in T_Liste; Indice: in Integer) return T_Element;


	-- Supprimer l'élément à la position Indice dans la Liste.
	-- Le premier élément est à l'indice 0.
	-- Exception : Indice_Error si l'indice n'est pas valide
	procedure Supprimer_Ieme (Liste: in out T_Liste; Indice: in Integer);


	-- Procédure de test de la liste.
	generic
		Un, Deux, Trois : T_Element;	-- Trois éléments différents
		with procedure Afficher_Element (Element: in T_Element);
	procedure Tester;


private

	type T_Cellule;

	type T_Liste is access T_Cellule;

	type T_Cellule is
		record
			Element: T_Element;
			Suivante: T_Liste;
		end record;

	function Cellule_Contenant (Element: T_Element; Liste: in T_Liste) return T_Liste with
		Post => Cellule_Contenant'Result /= null
				and then Cellule_Contenant'Result.all.Element = Element;

		--! Spécifier ici, dans la partie private, ce sous-programme n'est
		--! pas accessible des utilisateurs du module mais le sera de tous
		--! sous-programme du corps du module.

end Listes;
