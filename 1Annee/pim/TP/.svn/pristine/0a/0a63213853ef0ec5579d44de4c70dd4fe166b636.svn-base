with text_io; use text_io;
with ada.integer_text_io; use  ada.integer_text_io;

procedure Exemple_1 is

-- spÃ©cification volontairement omise !
procedure Lire_Entier (Fvaleur : out Integer) is
begin
	Put_Line ("DÃ©but lire_entier");
	Get (Fvaleur);
	Put_Line ("Fin lire_entier");
exception
	when Data_Error =>  Put_Line ("Erreur de saisie dans lire_entier");
end Lire_Entier;


-- Programme principal

	Nb : Integer; -- le nombre Ã  lire
begin
	Put_Line ("DÃ©but instructions du programme Exemple 1"); 
	Lire_Entier (Nb);
	Put_Line ("Fin instructions du programme Exemple 1");
end Exemple_1;
