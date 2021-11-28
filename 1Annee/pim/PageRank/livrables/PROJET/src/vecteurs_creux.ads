
generic
       type T_Element is digits <>;
package vecteurs_creux is

	type T_Vecteur_Creux is  limited private;


        -- initialiser un vecteur creux
	procedure Initialiser (V : out T_Vecteur_Creux) with
                Post => Est_Nul(V);

	-- Détruire un vecteur creux
         procedure Detruire (V: in out T_Vecteur_Creux);

        -- Est-ce que le vecteur V est nul ?
	function Est_Nul (V : in T_Vecteur_Creux) return Boolean;

        --EST-ce que j est dans V?
        function existe(V: in T_Vecteur_Creux; j: in integer)return Boolean;

        --
	function la_valeur (V : in T_Vecteur_Creux ; Indice : in Integer) return T_Element
		with Pre => Indice >= 1;


         --Modifier la veleur de la composante d'indice Indice d'un vecteur creux.
	procedure Modifier (V : in out T_Vecteur_Creux ;Indice : in Integer ;Valeur : in T_Element ) with
		pre => Indice >= 1,
		post => la_valeur (V, Indice) = Valeur;

         -- Nombre de composantes non nulles du vecteur V.
	function Nombre_Composantes_Non_Nulles (V: in T_Vecteur_Creux) return Integer with
                  Post => Nombre_Composantes_Non_Nulles'Result >= 0;

        -- modifier les valeurs d'un vecteur creux
        Procedure modifier_vecteur(V: in out T_Vecteur_Creux;valeur: in T_Element);





private

	type T_Cellule;

	type T_Vecteur_Creux is access T_Cellule;

	type T_Cellule is
		record
			Indice : Integer;
			Valeur : T_Element;
			Suivant : T_Vecteur_Creux;

		end record;



end vecteurs_creux;
