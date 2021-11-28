with Ada.Text_IO;        use Ada.Text_IO;
with Listes;

procedure Tester_Listes is
	package Listes_Character is
		new Listes (Character);
	use Listes_Character;
	procedure Tester_Character is
		new Tester('A', 'B', 'C', Put);
begin
	Tester_Character;
end Tester_Listes;
