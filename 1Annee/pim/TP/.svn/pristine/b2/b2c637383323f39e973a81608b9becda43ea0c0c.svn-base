with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO ;use Ada.Text_IO.Unbounded_IO;
with LCA;


procedure lca_sujet is

   package LCA_int_cc is
       new LCA(T_Cle => Unbounded_String , T_Donnee => Integer);
   use LCA_int_cc;

   procedure Afficher (Cle : in Unbounded_String; Donnee: in Integer) is
    begin
        Put(" Cle => ");
        Put(Cle);
        Put(" , Donnee => ");
        Put(Donnee,0);
   end Afficher;
   procedure Afficher is new Pour_Chaque(Traiter =>Afficher);

   Sda1: T_LCA;
begin
      -- initialiser la liste Sda1.
      Initialiser(Sda1);

      --Enregistrer la cle "un" et sa donnee associé 1 dans Sda1.
      Enregistrer (Sda1,To_Unbounded_String("un"),1);

      --Enregistrer la cle "deux" et sa donnee associé 2 dans Sda1.
      Enregistrer (Sda1,To_Unbounded_String("deux"),2);

      -- afficher la liste Sda1.
      Afficher(Sda1);

      --vider la liste Sda1.
      Vider(Sda1);
end lca_sujet;
