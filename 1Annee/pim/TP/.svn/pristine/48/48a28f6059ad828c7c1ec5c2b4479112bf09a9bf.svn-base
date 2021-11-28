with text_io; use text_io;
with ada.integer_text_io; use ada.integer_text_io;

procedure Exemple_4 is

-- spÃ©cification volontairement omise !
procedure Lire_Entier (Fvaleur : out Integer) is

	-- spÃ©cification volontairement omise !
	procedure Lire_Interne (Fvaleur_Interne : out Integer) is
	begin
		Put_Line ("DÃ©but de Lire_Interne");
		Get (Fvaleur_Interne);
		Put_Line ("Fin de Lire_Interne");
	end lire_interne;

begin
	Put_Line ("DÃ©but de lire_entier");
	Lire_Interne (Fvaleur);
	Put_Line ("Fin de lire_entier");
end lire_entier;

-- Programme principal

    Nb : Integer; -- le nombre Ã  lire
begin
	Put_Line ("DÃ©but de exemple_4");
	Lire_Entier (Nb);
	Put_Line ("Fin de exemple_4");
exception
	when Data_Error => Put_Line ("Erreur de saisie"); 
end Exemple_4;

