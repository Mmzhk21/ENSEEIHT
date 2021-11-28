with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Unchecked_Deallocation;

package body Listes is

	--! Les sous-programmes pour lesquels on demande une version itérative et
	--! récursive apparaissent trois fois :
	--! - avec le suffixe _Recursive : pour la version récursive
	--! - avec le suffixe _Iterative : pour la version itérative
	--! - sans suffixe : c'est le corps du sous-programme de l'interface qui
	--!   appelle la version récursive.  Inutile de le changer (sauf pour
	--!   Afficher où on pourra le changer pour essayer l'autre version).
	--!
	--! Un trait horizontal sépare les différents groupes de sous-programmes.


	----------------------------------------------------------------------------


	procedure Free is
		new Ada.Unchecked_Deallocation (T_Cellule, T_Liste);

	----------------------------------------------------------------------------

	procedure Initialiser (Liste: out T_Liste) is
	begin
		null;	-- TODO  à changer
	end Initialiser;

	----------------------------------------------------------------------------

	procedure Detruire_Recursive (Liste: out T_Liste) is
	begin
		null;	-- TODO  à changer
	end Detruire_Recursive;


	procedure Detruire_Iterative (Liste: in out T_Liste) is
		Curseur: T_Liste;
		A_Detruire: T_Liste;
	begin
		null;	-- TODO  à changer
	end Detruire_Iterative;


	procedure Detruire (Liste: in out T_Liste) is
	begin
		Detruire_Recursive (Liste);
	end Detruire;

	----------------------------------------------------------------------------

	procedure Ajouter_Debut (Liste: in out T_Liste; Element: T_Element) is
	begin
		null;	-- TODO  à changer
	end Ajouter_Debut;

	----------------------------------------------------------------------------

	function Premier (Liste: in T_Liste) return T_Element is
	begin
		return;	-- TODO  à changer
	end;

	----------------------------------------------------------------------------

	function Taille_Recursive (Liste: in T_Liste) return Integer is
	begin
		return 0;	-- TODO  à changer
	end Taille_Recursive;


	function Taille_Iterative (Liste: in T_Liste) return Integer is
		Curseur: T_Liste;
		Nombre_Cellules: Integer;
	begin
		return 0;	-- TODO  à changer
	end Taille_Iterative;


	function Taille (Liste: in T_Liste) return Integer is
	begin
		return Taille_Recursive (Liste);
	end Taille;

	----------------------------------------------------------------------------

	generic
		with procedure Afficher_Element (Element: in T_Element);
	procedure Afficher_Recursive (Liste: in T_Liste);


	procedure Afficher_Recursive (Liste: in T_Liste) is
	begin
		null;	-- TODO  à changer
	end Afficher_Recursive;


	generic
		with procedure Afficher_Element (Element: in T_Element);
	procedure Afficher_Iterative (Liste: in T_Liste);


	procedure Afficher_Iterative (Liste: in T_Liste) is
	begin
		null;	-- TODO  à changer
	end Afficher_Iterative;


	procedure Afficher (Liste: in T_Liste) is
		procedure Afficher_Recursive_Instanciee is
			new Afficher_Recursive (Afficher_Element);
	begin
		Afficher_Recursive_Instanciee (Liste);
	end Afficher;

	----------------------------------------------------------------------------

	function Est_Present_Recursive (Liste: in T_Liste; Element: in T_Element) return Boolean is
	begin
		return False;	-- TODO  à changer
	end Est_Present_Recursive;


	function Est_Present_Iterative (Liste: in T_Liste; Element: in T_Element) return Boolean is
	begin
		return False;	-- TODO  à changer
	end Est_Present_Iterative;


	function Est_Present (Liste: in T_Liste; Element: in T_Element) return Boolean is
	begin
		return Est_Present_Recursive (Liste, Element);
	end Est_Present;

	----------------------------------------------------------------------------

	procedure Supprimer_Recursive (Liste: in out T_Liste; Element: in T_Element) is
	begin
		null;	-- TODO  à changer
	end Supprimer_Recursive;


	procedure Supprimer_Iterative (Liste: in out T_Liste; Element: in T_Element) is
	begin
		null;	-- TODO  à changer
	end Supprimer_Iterative;


	procedure Supprimer (Liste: in out T_Liste; Element: in T_Element) is
	begin
		Supprimer_Recursive (Liste, Element);
	end Supprimer;

	----------------------------------------------------------------------------

	function Cellule_Contenant_Recursive (Element: T_Element; Liste: in T_Liste) return T_Liste is
	begin
		return null;	-- TODO  à changer
	end Cellule_Contenant_Recursive;
	

	function Cellule_Contenant_Iterative (Element: T_Element; Liste: in T_Liste) return T_Liste is
	begin
		return null;	-- TODO  à changer
	end Cellule_Contenant_Iterative;
	

	function Cellule_Contenant (Element: T_Element; Liste: in T_Liste) return T_Liste is
	begin
		return Cellule_Contenant_Recursive (Element, Liste);
	end Cellule_Contenant;
	
	----------------------------------------------------------------------------

	procedure Inserer_Apres (Liste: in out T_Liste ; Nouveau, Element: in T_Element) is
	begin
		null;	-- TODO  à changer
	end Inserer_Apres;

	----------------------------------------------------------------------------

	function Ieme_Recursive (Liste: in T_Liste; Indice: in Integer) return T_Element is
	begin
		return;	-- TODO  à changer
	end Ieme_Recursive;


	function Ieme_Iterative (Liste: in T_Liste; Indice: in Integer) return T_Element is
	begin
		return;	-- TODO  à changer
	end Ieme_Iterative;


	function Ieme (Liste: in T_Liste; Indice: in Integer) return T_Element is
	begin
		return Ieme_Recursive (Liste, Indice);
	end Ieme;

	----------------------------------------------------------------------------

	procedure Supprimer_Ieme_Recursive (Liste: in out T_Liste; Indice: in Integer) is
	begin
		null;	-- TODO  à changer
	end Supprimer_Ieme_Recursive;


	procedure Supprimer_Ieme_Iterative (Liste: in out T_Liste; Indice: in Integer) is
	begin
		null;	-- TODO  à changer
	end Supprimer_Ieme_Iterative;


	procedure Supprimer_Ieme (Liste: in out T_Liste; Indice: in Integer) is
	begin
		Supprimer_Ieme_Recursive (Liste, Indice);
	end Supprimer_Ieme;


	---| les tests |------------------------------------------------------------


	procedure Tester is

		-- XXX
		procedure Put is new Afficher (Afficher_Element);


		-- Initialiser une liste [ Un, Trois, Un, Deux].
		-- Elle devra être détruite.
		procedure Initialiser_Liste1312 (Liste: out T_Liste) is
		begin
			Initialiser (Liste);
			Ajouter_Debut (Liste, Deux);
			Ajouter_Debut (Liste, Un);
			Ajouter_Debut (Liste, Trois);
			Ajouter_Debut (Liste, Un);
		end;


		procedure Tester_Initialiser is
			Vide: T_Liste;
		begin
			Initialiser (Vide);
			pragma Assert (Vide = null);
		end Tester_Initialiser;


		procedure Tester_Ajouter_Debut is
			Liste: T_Liste;
		begin
			Initialiser (Liste);

			-- ajouter un premier élémnet
			Ajouter_Debut (Liste, Un);
			pragma Assert (Liste /= null);
			pragma Assert (Liste.all.Suivante = null);
			pragma Assert (Liste.all.Element = Un);

			-- ajouter un deuxième élémnet
			Ajouter_Debut (Liste, Deux);
			pragma Assert (Liste /= null);
			pragma Assert (Liste.all.Element = Deux);
			pragma Assert (Liste.all.Suivante /= null);
			pragma Assert (Liste.all.Suivante.all.Element = Un);
			pragma Assert (Liste.all.Suivante.all.Suivante = null);

			Detruire (Liste);
		end Tester_Ajouter_Debut;


		procedure Tester_Premier is
			Liste: T_Liste;
		begin
			Initialiser (Liste);

			-- ajouter un premier élémnet
			Ajouter_Debut (Liste, Un);
			pragma Assert (Premier (Liste) = Un);

			-- ajouter un deuxième élémnet
			Ajouter_Debut (Liste, Deux);
			pragma Assert (Premier (Liste) = Deux);

			-- ajouter un troisième élémnet
			Ajouter_Debut (Liste, Trois);
			pragma Assert (Premier (Liste) = Trois);

			Detruire (Liste);

		end Tester_Premier;


		generic
			with function Taille (Liste: in T_Liste) return Integer;
		procedure Tester_Taille;

		procedure Tester_Taille is
			Liste: T_Liste;
		begin
			Initialiser (Liste);
			pragma Assert (Taille (Liste) = 0);

			-- ajouter un premier élémnet
			Ajouter_Debut (Liste, Un);
			pragma Assert (Taille (Liste) = 1);

			-- ajouter un deuxième élémnet
			Ajouter_Debut (Liste, Deux);
			pragma Assert (Taille (Liste) = 2);

			-- ajouter un troisième élémnet
			Ajouter_Debut (Liste, Trois);
			pragma Assert (Taille (Liste) = 3);

			-- ajouter un quatirème élémnet
			Ajouter_Debut (Liste, Un);
			pragma Assert (Taille (Liste) = 4);

			Detruire (Liste);
		end Tester_Taille;

		procedure Tester_Taille_Recursive is
			new Tester_Taille (Taille_Recursive);
		procedure Tester_Taille_Iterative is
			new Tester_Taille (Taille_Iterative);


		generic
			with function Est_Present (Liste: in T_Liste; Element: in T_Element) return Boolean;
		procedure Tester_Est_Present;

		procedure Tester_Est_Present is
			Liste: T_Liste;
		begin
			Initialiser (Liste);
			pragma Assert (not Est_Present (Liste, Un));

			-- ajouter un premier élémnet
			Ajouter_Debut (Liste, Un);
			pragma Assert (Est_Present (Liste, Un));
			pragma Assert (not Est_Present (Liste, Deux));

			-- ajouter un deuxième élémnet
			Ajouter_Debut (Liste, Deux);
			pragma Assert (Est_Present (Liste, Un));
			pragma Assert (Est_Present (Liste, Deux));
			pragma Assert (not Est_Present (Liste, Trois));

			-- ajouter un troisième élémnet
			Ajouter_Debut (Liste, Un);
			pragma Assert (Est_Present (Liste, Un));
			pragma Assert (Est_Present (Liste, Deux));
			pragma Assert (not Est_Present (Liste, Trois));

			Detruire (Liste);
		end Tester_Est_Present;

		procedure Tester_Est_Present_Recursive is
			new Tester_Est_Present (Est_Present_Recursive);
		procedure Tester_Est_Present_Iterative is
			new Tester_Est_Present (Est_Present_Iterative);



		generic
			with function Cellule_Contenant (Element: in T_Element; Liste: in T_Liste) return T_Liste;
		procedure Tester_Cellule_Contenant;

		procedure Tester_Cellule_Contenant is

			procedure Tester_Existants is
				Liste: T_Liste;
			begin
				Initialiser_Liste1312 (Liste);
				pragma Assert (Cellule_Contenant (Un, Liste) = Liste);
				pragma Assert (Cellule_Contenant (Trois, Liste) = Liste.all.Suivante);
				pragma Assert (Cellule_Contenant (Deux, Liste) = Liste.all.Suivante.all.Suivante.all.Suivante);
				Detruire (Liste);
			end Tester_Existants;

			procedure Tester_Absent (Liste: in T_Liste; Element: in T_Element) is
				Ptr: T_Liste;
			begin
				Ptr := Cellule_Contenant (Element, Liste);
				pragma Assert (False);
				pragma Assert (Ptr = null);	--! pour éviter l'avertissement
			exception
				when Element_Absent_Error =>
					null;
				when others =>
					pragma Assert (False);
			end;

			Liste: T_Liste;
		begin
			Tester_Existants;

			-- tester les cas où l'élément n'est pas présent
			Initialiser (Liste);
			Tester_Absent (Liste, Un);

			Ajouter_Debut (Liste, Deux);
			Tester_Absent (Liste, Un);

			Ajouter_Debut (Liste, Trois);
			Tester_Absent (Liste, Un);

			Detruire (Liste);
		end Tester_Cellule_Contenant;

		procedure Tester_Cellule_Contenant_Recursive is
			new Tester_Cellule_Contenant (Cellule_Contenant_Recursive);
		procedure Tester_Cellule_Contenant_Iterative is
			new Tester_Cellule_Contenant (Cellule_Contenant_Iterative);




		generic
			with procedure Supprimer (Liste: in out T_Liste; Element: in T_Element);
		procedure Tester_Supprimer;

		procedure Tester_Supprimer is 

			procedure Supprimer_Trace (Liste: in out T_Liste; Element: in T_Element) is
			begin
				-- Tracer l'instruction qui va être exécutée
				Put ("> Supprimer (..., ");
				Afficher_Element (Element);
				Put (");");
				New_Line;

				Supprimer (Liste, Element);

				-- Afficher la liste
				Put (Liste);
				New_Line;
				New_Line;
			end Supprimer_Trace;

			procedure Supprimer_Extremites is
				Liste: T_Liste;
			begin
				Initialiser_Liste1312 (Liste);

				New_Line;
				Put_Line ("## Supprimer_Extremites");
				New_Line;
				Put (Liste);
				New_Line;
				New_Line;

				-- supprimer le premier élément
				Supprimer_Trace (Liste, Un);
				pragma Assert (Premier (Liste) = Trois);
				pragma Assert (Taille (Liste) = 3);

				-- supprimer le dernier élément
				Supprimer_Trace (Liste, Deux);
				pragma Assert (Taille (Liste) = 2);

				-- supprimer le dernier élément
				Supprimer_Trace (Liste, Un);
				pragma Assert (Taille (Liste) = 1);

				-- supprimer le seul élément
				Supprimer_Trace (Liste, Trois);
				pragma Assert (Taille (Liste) = 0);

				Detruire (Liste);
			end Supprimer_Extremites;


			procedure Supprimer_Milieu is
				Liste: T_Liste;
			begin
				Initialiser_Liste1312 (Liste);

				New_Line;
				Put_Line ("## Supprimer_Milieu");
				New_Line;
				Put (Liste);
				New_Line;
				New_Line;


				-- supprimer le premier élément
				Supprimer_Trace (Liste, Un);
				pragma Assert (Premier (Liste) = Trois);
				pragma Assert (Taille (Liste) = 3);
				pragma Assert (Est_Present (Liste, Un));
				pragma Assert (Est_Present (Liste, Deux));

				-- supprimer un élément au milieu
				Supprimer_Trace (Liste, Un);
				pragma Assert (Taille (Liste) = 2);
				pragma Assert (Premier (Liste) = Trois);
				pragma Assert (Est_Present (Liste, Deux));

				Detruire (Liste);
			end Supprimer_Milieu;


			procedure Supprimer_Liste_Vide is
				Vide: T_Liste;
			begin
				Initialiser (Vide);
				Supprimer (Vide, Un);
				pragma Assert (False);
			exception
				when Element_Absent_Error =>
					null;
					Detruire (Vide);
				when others =>
					pragma Assert (False);
			end Supprimer_Liste_Vide;


			procedure Supprimer_Liste1_Un_Element_Present is
				Liste: T_Liste;
			begin
				Initialiser (Liste);
				Ajouter_Debut (Liste, Un);
				Supprimer (Liste, Un);
				pragma Assert (Taille(Liste) = 0);
				Detruire (Liste);
			end Supprimer_Liste1_Un_Element_Present;


			procedure Supprimer_Liste1_Un_Element_Absent is
				Liste: T_Liste;
			begin
				Initialiser (Liste);
				Ajouter_Debut (Liste, Un);
				Supprimer (Liste, Deux);
				pragma Assert (False);
			exception
				when Element_Absent_Error =>
					null;
					Detruire (Liste);
				when others =>
					pragma Assert (False);
			end Supprimer_Liste1_Un_Element_Absent;

		begin
			pragma Assert (Un /= Deux);
			pragma Assert (Un /= Trois);
			pragma Assert (Deux /= Trois);

			Supprimer_Liste_Vide;
			Supprimer_Liste1_Un_Element_Present;
			Supprimer_Liste1_Un_Element_Absent;
			Supprimer_Extremites;
			Supprimer_Milieu;
		end;

		procedure Tester_Supprimer_Recursive is
			new Tester_Supprimer(Supprimer_Recursive);
		procedure Tester_Supprimer_Iterative is
			new Tester_Supprimer(Supprimer_Iterative);


		generic
			with function Ieme (Liste: in T_Liste; Indice: in Integer) return T_Element;
		procedure Tester_Ieme;

		procedure Tester_Ieme is

			procedure Tester_Nominal is
				Liste: T_Liste;
			begin
				Initialiser_Liste1312 (Liste);
				pragma Assert (Ieme (Liste, 0) = Un);
				pragma Assert (Ieme (Liste, 1) = Trois);
				pragma Assert (Ieme (Liste, 2) = Un);
				pragma Assert (Ieme (Liste, 3) = Deux);
				Detruire (Liste);
			end Tester_Nominal;

			procedure Tester_Indice_Invalide (Liste: in T_Liste; Indice: in Integer) is
				Element: T_Element;
			begin
				Element := Ieme (Liste, Indice);
				pragma Assert (False);
				pragma Assert (Element = Un);	-- pour eviter le warning
			exception
				when Indice_Error =>
					null;
				when others =>
					pragma Assert (False);
			end Tester_Indice_Invalide;


			Vide: T_Liste;
			Liste: T_Liste;
		begin
			Tester_Nominal;


			Initialiser (Vide);
			Tester_Indice_Invalide (Vide, 0);
			Tester_Indice_Invalide (Vide, -1);
			Tester_Indice_Invalide (Vide, 1);
			Detruire (Vide);

			Initialiser_Liste1312 (Liste);
			Tester_Indice_Invalide (Vide, 4);
			Tester_Indice_Invalide (Vide, 10);
			Tester_Indice_Invalide (Vide, -1);
			Tester_Indice_Invalide (Vide, -10);
			Detruire (Liste);

		end Tester_Ieme;

		procedure Tester_Ieme_Recursive is
			new Tester_Ieme (Ieme_Recursive);
		procedure Tester_Ieme_Iterative is
			new Tester_Ieme (Ieme_Iterative);



		procedure Tester_Inserer_Apres is

			procedure Test_Nominal is
				Liste: T_Liste;
			begin
				Initialiser (Liste);

				Ajouter_Debut (Liste, Un);
				Inserer_Apres (Liste, Deux, Un);

				pragma Assert (Taille (Liste) = 2);
				pragma Assert (Premier (Liste) = Un);
				pragma Assert (Liste.all.Suivante.all.Element = Deux);

				Inserer_Apres (Liste, Un, Deux);
				pragma Assert (Taille (Liste) = 3);
				pragma Assert (Premier (Liste) = Un);
				pragma Assert (Liste.all.Suivante.all.Element = Deux);
				pragma Assert (Liste.all.Suivante.all.Suivante.all.Element = Un);

				Inserer_Apres (Liste, Trois, Un);

				pragma Assert (Taille (Liste) = 4);
				pragma Assert (Premier (Liste) = Un);
				pragma Assert (Liste.all.Suivante.all.Element = Trois);
				pragma Assert (Liste.all.Suivante.all.Suivante.all.Element = Deux);

				Detruire (Liste);
			end Test_Nominal;

			procedure Test_Erreur (Liste: in out T_Liste; Element: in T_Element) is
			begin
				Inserer_Apres (Liste, Un, Element);
				pragma Assert (False);
			exception
				when Element_Absent_Error =>
					null;
				when others =>
					pragma Assert (False);
			end Test_Erreur;

			Liste: T_Liste;
		begin
			Test_Nominal;

			-- Tests erreurs
			Initialiser (Liste);

			for I in 1..10 loop
				Test_Erreur (Liste, Deux);
				Ajouter_Debut (Liste, Un);
			end loop;
			Detruire (Liste);
		end Tester_Inserer_Apres;


		generic
			with procedure Supprimer_Ieme (Liste: in out T_Liste; Indice: in Integer);
		procedure Tester_Supprimer_Ieme;

		procedure Tester_Supprimer_Ieme is 

			procedure Supprimer_Ieme_Trace (Liste: in out T_Liste; Indice: in Integer) is
			begin
				-- Tracer l'instruction qui va être exécutée
				Put ("> Supprimer_Ieme (..., ");
				Put (Indice, 1);
				Put (");");
				New_Line;

				Supprimer_Ieme (Liste, Indice);

				-- Afficher la liste
				Put (Liste);
				New_Line;
				New_Line;
			end Supprimer_Ieme_Trace;

			procedure Supprimer_Ieme_Nominal is
				Liste: T_Liste;
			begin
				Initialiser_Liste1312 (Liste);

				New_Line;
				Put_Line ("## Supprimer_Ieme_Nominal");
				New_Line;
				Put (Liste);
				New_Line;
				New_Line;

				-- supprimer au milieu
				Supprimer_Ieme_Trace (Liste, 2);
				pragma Assert (Taille (Liste) = 3);
				pragma Assert (Est_Present (Liste, Un));
				pragma Assert (Est_Present (Liste, Deux));
				pragma Assert (Est_Present (Liste, Trois));

				-- supprimer le dernier élément
				Supprimer_Ieme_Trace (Liste, 2);
				pragma Assert (Taille (Liste) = 2);
				pragma Assert (Est_Present (Liste, Un));
				pragma Assert (not Est_Present (Liste, Deux));
				pragma Assert (Est_Present (Liste, Trois));

				-- supprimer le premier élément
				Supprimer_Ieme_Trace (Liste, 0);
				pragma Assert (Taille (Liste) = 1);
				pragma Assert (Premier (Liste) = Trois);

				-- supprimer le seul élément
				Supprimer_Ieme_Trace (Liste, 0);
				pragma Assert (Taille (Liste) = 0);

				Detruire (Liste);
			end Supprimer_Ieme_Nominal;


			procedure Supprimer_Ieme_Erreur (Liste: in out T_Liste; Indice: in Integer) is
			begin
				Supprimer_Ieme (Liste, Indice);
				pragma Assert (False);
			exception
				when Indice_Error =>
					null;
				when others =>
					pragma Assert (False);
			end Supprimer_Ieme_Erreur;

			Liste: T_Liste;
		begin
			Supprimer_Ieme_Nominal;

			Initialiser (Liste);
			Supprimer_Ieme_Erreur (Liste, 0);
			Supprimer_Ieme_Erreur (Liste, -1);
			Supprimer_Ieme_Erreur (Liste, 1);
			Detruire (Liste);

			Initialiser_Liste1312 (Liste);
			Supprimer_Ieme_Erreur (Liste, Taille (Liste));
			Supprimer_Ieme_Erreur (Liste, -1);
			Detruire (Liste);

		end Tester_Supprimer_Ieme;

		procedure Tester_Supprimer_Ieme_Recursive is
			new Tester_Supprimer_Ieme(Supprimer_Ieme_Recursive);
		procedure Tester_Supprimer_Ieme_Iterative is
			new Tester_Supprimer_Ieme(Supprimer_Ieme_Iterative);



	begin
		pragma Assert (Un /= Deux);
		pragma Assert (Un /= Trois);
		pragma Assert (Deux /= Trois);

		Tester_Initialiser;
		Tester_Ajouter_Debut;
		Tester_Premier;

		Tester_Taille_Recursive;
		Tester_Taille_Iterative;

		Tester_Est_Present_Recursive;
		Tester_Est_Present_Iterative;

		Tester_Supprimer_Recursive;
		Tester_Supprimer_Iterative;

		Tester_Cellule_Contenant_Recursive;
		Tester_Cellule_Contenant_Iterative;

		Tester_Inserer_Apres;

		Tester_Ieme_Recursive;
		Tester_Ieme_Iterative;

		Tester_Supprimer_Ieme_Recursive;
		Tester_Supprimer_Ieme_Iterative;
	end Tester;

end Listes;
