
with SDA_Exceptions;         use SDA_Exceptions;
with Ada.Unchecked_Deallocation;

package body LCA is

	procedure Free is
		new Ada.Unchecked_Deallocation (Object => T_cell, Name => T_LCA);


	procedure Initialiser(Sda: out T_LCA) is
	begin
                Sda := null;
	end Initialiser;


	function Est_Vide (Sda : T_LCA) return Boolean is
	begin
             return Sda = null;
	end Est_Vide;


	function Taille (Sda : in T_LCA) return Integer is
	begin
              if Est_Vide(Sda) then
               return 0;
              else
                  return (Taille (Sda.all.suivant) + 1);
              end if ;

	end Taille;


	procedure Enregistrer (Sda : in out T_LCA ; Cle : in T_Cle ; Donnee : in T_Donnee) is
        begin

               if Sda = null then

                    -- enregistrer la cle et la donnee dans la première cellule si la sda est null.
                    Sda := new T_cell;
                    Sda.all.Cle := Cle;
                    Sda.all.Donnee := Donnee;

               elsif Sda.all.Cle = Cle then

                     -- changer la donnee si la cle est trouvé dans la première cellule de la Sda.
                     Sda.all.Donnee := Donnee;
               else

                   --Enregistrer la donnee dans la sda.all.suivant si la cle est différent de celle de la première cellule.
                   Enregistrer(Sda.all.suivant,Cle,Donnee);
               end if;
        end Enregistrer;

	function Cle_Presente (Sda : in T_LCA ; Cle : in T_Cle) return Boolean is
        begin
                  --est-ce que la Sda est null.
                  if Sda=Null then
                       return False;
                  else

                       -- verifier si la cle est egale à celle de la pemière cellule.
                       if Sda.all.Cle = Cle then
                         return True;
                       else

                         -- Savoir si la Clé est présente dans une Sda.all.suivant
                         return Cle_Presente (Sda.all.suivant , Cle );
                       end if ;
                  end if;
        end Cle_Presente;

	function La_Donnee (Sda : in T_LCA ; Cle : in T_Cle) return T_Donnee is
        begin
           -- verifier est-ce que la sda est vide.
           if Sda = null then

                 -- lever Cle_Absente_Exception.
                 raise Cle_Absente_Exception;

           elsif Sda.all.Cle = Cle then

                 -- retourner la donnee associée à la Cle.
                 return Sda.all.Donnee;
           else

                  -- Obtenir la donnée associée la Cle dans la Sda.all.suivant.
                  return La_Donnee(Sda.all.suivant , Cle);
           end if;
	end La_Donnee;


   procedure Supprimer (Sda : in out T_LCA ; Cle : in T_Cle) is
   begin
      -- savoir est-ce que la cle est présente dan la sda
      if not Cle_Presente(Sda,Cle) then

                        -- lever l'exception Cle_Absente_Exception.
                        raise Cle_Absente_Exception;
      else
                    -- supprimer la première cellule de la sda si sa cle est égale à celle cherchée.
                    if Sda.all.Cle = Cle then
                      Sda := Sda.all.suivant;
                    else

                          -- supprimer la donnee associée à Cle dans Sda.all.suivant.
                          supprimer(Sda.all.suivant , Cle);
                    end if;
      end if;
	end Supprimer;


	procedure Vider (Sda : in out T_LCA) is
	begin
		if Sda /= Null then
			Vider(Sda.all.Suivant);
			Free (Sda);
		end if;
	end Vider;


        procedure Pour_Chaque (Sda : in T_LCA) is
        begin
              if not Est_Vide(Sda) then
			begin
                                -- traiter la premièere cellule de la Sda
		   		Traiter(Sda.all.Cle, Sda.all.Donnee);

                        -- gerer les exceptions.
			exception
				when others => null;
			end;

                        -- Appliquer le traitement (Traiter) pour chaque couple d'une Sda à Sda.all.suivant.
			Pour_Chaque(Sda.all.Suivant);
		end if;

	end Pour_Chaque;


end LCA;
