with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with TH;


procedure th_sujet is
        package th_int_cc is new TH(T_Cle => Unbounded_String , T_Donnee => Integer,capacite => 11,hachage => Length);
        use th_int_cc;

     procedure Afficher_th (Cle : in Unbounded_String; Donnee: in Integer) is
    begin
        Put(" Cle => ");
        Put(To_String(Cle));
        Put(" , Donnee => ");
        Put(Donnee,0);
        New_Line;
   end Afficher_th;
   procedure Afficher_th is new Pour_Chaque(Traiter =>Afficher_th);
   th1 : T_TH;

    begin
         --initialiser la table th1.
         Initialiser(th1);

         --enregister les valeurs et les donnees dans th1.
         Enregistrer(th1 , To_Unbounded_String("un") , 1);
         Enregistrer(th1 , To_Unbounded_String("deux") , 2);
         Enregistrer(th1 , To_Unbounded_String("trois") , 3);
         Enregistrer(th1 , To_Unbounded_String("quatre") , 4);
         Enregistrer(th1 , To_Unbounded_String("cinq") , 5);
         Enregistrer(th1 , To_Unbounded_String("quatre-vingt-dix-neuf") , 99);
         Enregistrer(th1 , To_Unbounded_String("vingt-et-un") , 21);

         -- afficher le contenu de th1.
         Afficher_th(th1);


end th_sujet;
