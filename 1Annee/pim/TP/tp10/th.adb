with Ada.Text_IO;            use Ada.Text_IO;
with SDA_Exceptions; use SDA_Exceptions;

package body TH is


	procedure Initialiser(TH: out T_TH) is
	begin
                for i in 1..capacite loop
                  p_lca.Initialiser(TH.Table(i));
                end loop;
	end Initialiser;


	function Est_Vide (TH : T_TH) return Boolean is
        b : boolean;
	begin
             b := True;

             -- verifier est-ce qu'au moins une lca du TH est non vide.
            for i in 1..capacite loop

               if not p_LCA.Est_Vide(TH.Table(i)) then
                  b := False;
               end if;
            end loop;
            return b;
	end Est_Vide;


        -- retourner l'indice d'une Cle dans le TH.
        function Indice ( Cle : in T_Cle) return Integer is
          begin

                return (hachage(Cle)-1) mod capacite +1;

          end Indice;


	function Taille (TH : in T_TH) return Integer is
            s : Integer;
            begin
                 s := 0;
                 for i in 1..capacite loop
                     s := s + p_lca.Taille(TH.Table(i));
                 end loop;
                 return s;

	end Taille;


	procedure Enregistrer (TH : in out T_TH ; Cle : in T_Cle ; Donnee : in T_Donnee) is
         a :integer;
         begin
               a := Indice(Cle);

               --Enregistrer la donnee associée à Cle dans la lca d'indice a.
               p_lca.Enregistrer(TH.Table(a) , Cle , Donnee);
        end Enregistrer;


      function Cle_Presente (TH: in T_TH ; Cle : in T_Cle) return Boolean is
         a: integer;
      begin
                  a := Indice(Cle);

                  -- verifier est-ce que la Cle est présente dans la lca d'indice a.
                  return p_lca.Cle_Presente(TH.Table(a), Cle);
        end Cle_Presente;


      function La_Donnee (TH : in T_TH ; Cle : in T_Cle) return T_Donnee is
         a : Integer;
        begin
             a := Indice(Cle);

             --renvoyer la donnee associé a Cle dans la lca d'indice a.
             return p_lca.La_Donnee( TH.Table(a) , Cle);
	end La_Donnee;


      procedure Supprimer (TH : in out T_TH ; Cle : in T_Cle) is
         a : Integer;
   begin
      a := Indice(Cle);

      --supprimer la donnée associée a cle dans la lca d'indice a.
      p_lca.Supprimer(TH.Table(a) , Cle);
	end Supprimer;


	procedure Vider (TH : in out T_TH) is
	begin
                -- vider toutes les lca contenu dans TH.
		for i in 1..capacite loop
                 p_lca.Vider(TH.Table(i));
                end loop;
	end Vider;


        procedure Pour_Chaque (TH : in T_TH) is
        procedure Pour_Chaque_lca is
			    new p_LCA.Pour_Chaque (Traiter);
        begin
             -- appliquer le traitement pour chaque a toute les lca contenu dans TH.
             for i in 1..capacite loop
               Pour_Chaque_lca(TH.Table(i));
             end loop;

	end Pour_Chaque;


end TH;

