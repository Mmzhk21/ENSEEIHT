with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;
with Ada.Command_Line;     use Ada.Command_Line;
with SDA_Exceptions;       use SDA_Exceptions;
with Alea;
with TH;

-- �valuer la qualit� du g�n�rateur al�atoire et les SDA.
procedure Evaluer_Alea_TH is

	-- la foction identit�
	function Identite(Cle: in Integer) return Integer is
	begin
		return Cle;
	end Identite;

	package TH_int_int is
        new TH (Capacite => 1000, T_Cle => Integer, T_Donnee => Integer, Hachage => Identite);
    use TH_int_int;

	-- Afficher l'usage.
	procedure Afficher_Usage is
	begin
		New_Line;
		Put_Line ("Usage : " & Command_Name & " Borne Taille");
		New_Line;
		Put_Line ("   Borne  : les nombres sont tir�s dans l'intervalle 1..Borne");
		Put_Line ("   Taille : la taille de l'�chantillon");
		New_Line;
	end Afficher_Usage;


	-- Afficher le Nom et la Valeur d'une variable.
	-- La Valeur est affich�e sur la Largeur_Valeur pr�cis�e.
	procedure Afficher_Variable (Nom: String; Valeur: in Integer; Largeur_Valeur: in Integer := 1) is
	begin
		Put (Nom);
		Put (" : ");
		Put (Valeur, Largeur_Valeur);
		New_Line;
	end Afficher_Variable;

	-- �valuer la qualit� du g�n�rateur de nombre al�atoire Alea sur un
	-- intervalle donn� en calculant les fr�quences absolues minimales et
	-- maximales des entiers obtenus lors de plusieurs tirages al�atoires.
	--
	-- Param�tres :
	-- 	  Borne: in Entier	-- le nombre al�atoire est dans 1..Borne
	-- 	  Taille: in Entier -- nombre de tirages (taille de l'�chantillon)
	-- 	  Min, Max: out Entier -- fr�quence minimale et maximale
	--
	-- N�cessite :
	--    Borne > 1
	--    Taille > 1
	--
	-- Assure : -- poscondition peu int�ressante !
	--    0 <= Min Et Min <= Taille
	--    0 <= Max Et Max <= Taille
	--    Min + Max <= Taille
	--    Min <= Moyenne Et Moyenne <= Max
	--
	-- Remarque : On ne peut ni formaliser les 'vraies' postconditions,
	-- ni �crire de programme de test car on ne ma�trise par le g�n�rateur
	-- al�atoire.  Pour �crire un programme de test, on pourrait remplacer
	-- le g�n�rateur par un g�n�rateur qui fournit une s�quence connue
	-- d'entiers et pour laquelle on pourrait d�terminer les donn�es
	-- statistiques demand�es.
	-- Ici, pour tester on peut afficher les nombres al�atoires et refaire
	-- les calculs par ailleurs pour v�rifier que le r�sultat produit est
	-- le bon.
	procedure Calculer_Statistiques (
		Borne    : in Integer;  -- Borne sup�rieur de l'intervalle de recherche
		Taille   : in Integer;  -- Taille de l'�chantillon
		Min, Max : out Integer  -- min et max des fr�quences de l'�chantillon
	) with
		Pre => Borne > 1 and Taille > 1,
		Post => 0 <= Min and Min <= Taille
			and 0 <= Max and Max <= Taille
			and Min + Max <= Taille
	is

		-- mise � jour du Max et Min.
		procedure Mise_A_jour(Cle: Integer; Donnee: Integer) is
		begin
                        if Min > Donnee then
				Min := Donnee;
			end if;

			if Max < Donnee then
				Max := Donnee;
			end if;
		end Mise_A_jour;

		procedure Determiner_Max_Min is
				new Pour_Chaque(Mise_A_jour);

		package Mon_Alea is
			new Alea (1, Borne);
		use Mon_Alea;


		nbr : Integer;
                Sda: T_TH;
	begin
		-- Initialiser la sda.
		Initialiser(Sda);

		Min := Taille;
		Max := 0;

		for i in 1..Taille loop
			Get_Random_Number(nbr);
			begin
				Enregistrer(Sda, nbr, La_Donnee(Sda, nbr)+1);
			exception
				when Cle_Absente_Exception => Enregistrer(Sda, nbr, 1);
			end;
		end loop;

		Determiner_Max_Min(Sda);

	end Calculer_Statistiques;


	Min, Max: Integer; -- fr�quence minimale et maximale d'un �chantillon
	Borne: Integer;    -- les nombres al�atoire sont tir�s dans 1..Borne
	Taille: integer;   -- nombre de tirages al�atoires
begin
	if Argument_Count /= 2 then
		Afficher_Usage;
	else
		-- R�cup�rer les arguments de la ligne de commande
		begin
			Borne := Integer'Value (Argument (1));
			Taille := Integer'Value (Argument (2));
			if Borne < 2 or Taille < 2 then
				raise CONSTRAINT_ERROR;
			end if;
		exception
			when CONSTRAINT_ERROR =>
					Put_Line("Erreur d'entr�e, vous devez entrer des nombres positifs >= 2.");
					Afficher_Usage;
					return;
		end;
		-- Afficher les valeur de Borne et Taille
		Afficher_Variable ("Borne ", Borne);
		Afficher_Variable ("Taille", Taille);

		Calculer_Statistiques (Borne, Taille, Min, Max);

		-- Afficher les fr�quence Min et Max
		Afficher_Variable ("Min", Min);
		Afficher_Variable ("Max", Max);
	end if;

end Evaluer_Alea_TH;
