with Ada.Text_IO;       use Ada.Text_IO;
with vecteur_c;


procedure test_vecteur_creux is
         package vect is new vecteur_c(float);
   use vect;

	procedure Initialiser (VC0, VC1, VC2 : out T_Vecteur_Creux) is
	begin
		-- VC0 est un vecteur nul
		Initialiser (VC0);

		-- VC1 est un vecteur à deux composante
		Initialiser (VC1);
		Modifier (VC1, 10,  4.0);
		Modifier (VC1,  3, -3.0);

		Initialiser (VC2);
		Modifier (VC2,  100, 2.0);
		Modifier (VC2,    3, 3.0);
		Modifier (VC2,    1, 2.0);

	end;


	procedure Detruire (VC0, VC1, VC2 : in out T_Vecteur_Creux) is
	begin
		Detruire (VC0);
		Detruire (VC1);
		Detruire (VC2);
	end;


	procedure Tester_Nul is
		VC0, VC1, VC2: T_Vecteur_Creux;
	begin
		Initialiser (VC0, VC1, VC2);

		pragma Assert (Est_Nul(VC0));
		pragma Assert (Est_Nul(VC1));
		pragma Assert (Est_Nul(VC2));

		Detruire (VC0, VC1, VC2);
	end Tester_Nul;


	


	procedure Tester_Modifier is
		VC0, VC1, VC2: T_Vecteur_Creux;
	begin
		Initialiser (VC0, VC1, VC2);

		pragma Assert (2 = Nombre_Composantes_Non_Nulles (VC1));

		-- Changer des composantes non nulles
		-- * en première position
		Modifier (VC1, 3, 3.0);
		
		pragma Assert (2 = Nombre_Composantes_Non_Nulles (VC1));

		-- * après la première
		Modifier (VC1, 10, 15.0);
		
		pragma Assert (2 = Nombre_Composantes_Non_Nulles (VC1));

		-- Ajouter au début
		Modifier (VC1, 1, 1.5);
		
		pragma Assert (3 = Nombre_Composantes_Non_Nulles (VC1));

		-- Ajouter au milieu
		Modifier (VC1, 7, 7.5);
		
		pragma Assert (4 = Nombre_Composantes_Non_Nulles (VC1));

		-- Ajouter à la fin.
		Modifier (VC1, 111, 0.5);
		
		pragma Assert (5 = Nombre_Composantes_Non_Nulles (VC1));

		-- Mettre à 0.0 une composante existante
		-- * Au milieu
		Modifier (VC1, 10, 0.0);
		
		pragma Assert (4 = Nombre_Composantes_Non_Nulles (VC1));

		-- * À la fin
		Modifier (VC1, 111, 0.0);
		
		pragma Assert (3 = Nombre_Composantes_Non_Nulles (VC1));

		-- * Au début
		Modifier (VC1, 1, 0.0);
		
		pragma Assert (2 = Nombre_Composantes_Non_Nulles (VC1));


		-- Mettre à 0.0 une composante déjà nulle
		Modifier (VC1, 6, 0.0);
		pragma Assert (2 = Nombre_Composantes_Non_Nulles (VC1));
		Modifier (VC1, 2, 0.0);
		pragma Assert (2 = Nombre_Composantes_Non_Nulles (VC1));
		Modifier (VC1, 56, 0.0);
		pragma Assert (2 = Nombre_Composantes_Non_Nulles (VC1));

		-- Supprimer toutes les composantes
		Modifier (VC1, 7, 0.0);
		pragma Assert (1 = Nombre_Composantes_Non_Nulles (VC1));
		Modifier (VC1, 3, 0.0);
		pragma Assert (0 = Nombre_Composantes_Non_Nulles (VC1));
		pragma Assert (Est_Nul(VC1));

      Detruire (VC0, VC1, VC2);
      put("-------tous les testes passent --------");
	end Tester_Modifier;




begin
	Tester_Nul;
	
	Tester_Modifier;
	
end Test_Vecteur_Creux;
