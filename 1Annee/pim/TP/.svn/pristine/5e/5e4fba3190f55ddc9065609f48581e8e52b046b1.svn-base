with ada.text_io; use ada.text_io;
with ada.integer_text_io; use  ada.integer_text_io;

-- Calculer la somme d'une suite d'entiers lus clavier.  L'entier 0 marque la
-- fin de la sÃ©rie. Il n'en fait pas partie.
procedure Somme is 
	Somme: Integer;    -- la somme de valeurs lues au clavier
	Val:   Integer;    -- valeur lue au clavier
begin
	-- calculer la somme d'une suite de valeurs entiÃ¨res, se terminant par 0 
	Somme := 0;
	loop
		Put_Line ("Entrez une valeur entiÃ¨re ");
		Get (val);
		Somme := Somme + Val;
	exit when Val = 0;
	end loop;

	-- afficher la somme
	Put ("la somme vaut : ");
	Put (somme);
	New_Line;
end Somme;
