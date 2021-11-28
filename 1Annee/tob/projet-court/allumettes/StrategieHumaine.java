package allumettes;

import java.util.Scanner;

public class StrategieHumaine implements Strategie {
	
	private static Scanner scanner = new Scanner(System.in);
	private String Nomj;
	public StrategieHumaine(String nom) {
		
		this.Nomj = nom;
	}
         
	@Override
	public int getPrise(Jeu jeu) throws CoupInvalideException {
		String a = null;
		int n = 0;
		Boolean bool = true;
		while(bool) {
			try {
				System.out.print(this.Nomj + ", combien d'allumettes ? ");
				 a = scanner.next();
				 if(a.equals("triche")) {
					 System.out.print(" [Une allumette en moins, plus que 4. Chut !]" + " \n");
					 jeu.retirer(1);
				

				 }
				 n = Integer.parseInt(a);
				 
				bool = !bool;
			}catch(NumberFormatException e) {
				if(!a.equals("triche")) {
		
				System.out.print("Vous devez donner un entier." + " \n");
				 } 
			}
			}
		
		return n;
	
	


}
}
