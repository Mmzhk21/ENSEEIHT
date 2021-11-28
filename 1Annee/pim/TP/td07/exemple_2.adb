with text_io; use text_io;
with ada.integer_text_io; use ada.integer_text_io;

procedure Exemple_2 is

-- spÃ©cification volontairement omise !
procedure Lire_Entier (Fvaleur : out Integer) is
begin
	Put_Line ("DÃ©but de lire_entier");
	Get (Fvaleur);
	Put_Line ("Fin de lire_entier");
end lire_entier;

-- Programme principal

    Nb : Integer; -- le nombre Ã  lire
begin
	Put_Line ("DÃ©but de Exemple_2"); 
	lire_entier (nb);
	Put_Line ("Fin de Exemple_2"); 
exception
	when Data_Error => Put_Line ("Erreur de saisie"); 
end Exemple_2;
