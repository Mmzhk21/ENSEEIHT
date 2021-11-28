with text_io; use text_io;
with ada.integer_text_io; use  ada.integer_text_io;

procedure Exemple_5 is

-- spÃ©cification volontairement omise !
procedure Lire_Entier (valeur : out Integer) is
begin
	Put_Line ("DÃ©but lire_entier");
	Get (valeur);
	Put_Line ("Fin lire_entier");
exception
	when Data_Error => 
		Put_Line ("Erreur de saisie dans lire_entier");
		Skip_Line;
		Lire_Entier (valeur); 
end Lire_Entier;

-- Programme principal

    Nb : Integer; -- le nombre Ã  lire
begin
	Put_Line ("DÃ©but de Exemple_5");
	Lire_Entier (nb);
	Put_Line ("Fin de Exemple_5");
end Exemple_5;
