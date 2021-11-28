with text_io; use text_io;
with ada.integer_text_io; use ada.integer_text_io;

procedure Exemple_3 is

-- spÃ©cification volontairement omise !
procedure lire_entier (Fvaleur : out Integer) is

	-- spÃ©cification volontairement omise !
	procedure Lire_Interne (Fvaleur_Interne : out Integer) is
	begin
		Put_Line ("DÃ©but de Lire_Interne");
		Get (Fvaleur_Interne);
		Put_Line ("Fin de Lire_Interne");
	end lire_interne;

begin
	Put_Line ("DÃ©but de lire_entier");
	lire_interne (Fvaleur);
	Put_Line ("Fin de lire_entier");
exception
	when Data_Error => Put_Line ("Erreur de saisie dans Lire_Entier"); 
end lire_entier;

-- Programme principal

    Nb: Integer; -- le nombre Ã  lire
begin
	Put_Line ("DÃ©but de exemple_3");
	Lire_Entier (Nb);
	Put_Line ("Fin de exemple_3");
end Exemple_3;
