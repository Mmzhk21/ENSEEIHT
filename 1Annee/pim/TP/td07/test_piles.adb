with Piles;

-- Programme de test du module Pile.
procedure Test_Piles is

    package Pile_Caractere is
        new Piles (Capacite => 3, T_Element => Character);
    use Pile_Caractere;


    -- Initialiser une pile avec 'O' puis 'K' empilés dans la pile vide.
    procedure Initialiser_Avec_OK (Pile : out T_Pile) is
    begin
        Initialiser (Pile);
        Empiler (Pile, 'O');
        Empiler (Pile, 'K');
    end Initialiser_Avec_OK;


    procedure Tester_Est_Vide is
        Pile1, Pile2 : T_Pile;
    begin
        Initialiser (Pile1);
        pragma Assert (Est_Vide (Pile1));

        Empiler (Pile1, 'A');
        pragma Assert (not Est_Vide (Pile1));

        Initialiser_Avec_OK (Pile2);
        pragma Assert (not Est_Vide (Pile2));
    end Tester_Est_Vide;


    procedure Tester_Empiler is
        Pile1 : T_Pile;
    begin
        Initialiser_Avec_OK (Pile1);
        pragma Assert (not Est_Pleine (Pile1));

        Empiler (Pile1, 'N');
        pragma Assert ('N' = Sommet (Pile1));
        pragma Assert (Est_Pleine (Pile1));
    end Tester_Empiler;


    procedure Tester_Depiler is
        Pile1 : T_Pile;
    begin
        Initialiser_Avec_OK (Pile1);
        Depiler (Pile1);
        pragma Assert ('O' = Sommet (Pile1));
        Depiler (Pile1);
        pragma Assert (Est_Vide (Pile1));
    end Tester_Depiler;


    procedure Tester_Depiler_Pile_Vide_Exception is
        Pile : T_Pile;
    begin
        Initialiser (Pile);
        Depiler (Pile);
        pragma Assert (False);  --! On ne devrait pas arriver ici !
    exception
        when Pile_Vide_Error =>
            null;   --! C'est bien l'exception attendue !
        when others =>
            pragma Assert (False);  --! Ce n'est pas l'exception attendue !
    end Tester_Depiler_Pile_Vide_Exception;


    procedure Tester_Sommet_Pile_Vide_Exception is
        Pile : T_Pile;
        Element: Character;
    begin
        Initialiser (Pile);
        Element := Sommet (Pile);
        pragma Assert (False);  --! On ne devrait pas arriver ici !
        pragma Assert ('0' = Element);  --! Pour éviter le message d'avertissement !
    exception
        when Pile_Vide_Error =>
            null;   --! C'est bien l'exception attendue !
        when others =>
            pragma Assert (False);  --! Ce n'est pas l'exception attendue !
    end Tester_Sommet_Pile_Vide_Exception;


    procedure Tester_Empiler_Pile_Pleine_Exception is
        Pile : T_Pile;
    begin
        Initialiser (Pile);
        loop
            Empiler (Pile, 'x');
        end loop;
    exception
        when Pile_Pleine_Error =>
            null;   --! C'est bien l'exception attendue !
        when others =>
            pragma Assert (False);  --! Ce n'est pas l'exception attendue !
    end Tester_Empiler_Pile_Pleine_Exception;


begin
    Tester_Est_Vide;
    Tester_Empiler;
    Tester_Depiler;
    Tester_Depiler_Pile_Vide_Exception;
    Tester_Sommet_Pile_Vide_Exception;
    Tester_Empiler_Pile_Pleine_Exception;
end Test_Piles;
