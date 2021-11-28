package allumettes;

import java.util.Random;

public class StrategieNaif implements Strategie {
	 
	public Random ran;
	
	
	public StrategieNaif() {
		this.ran = new Random();
	}


	@Override
	public int getPrise(Jeu jeu) {
		int a = Math.min(jeu.getNombreAllumettes(), Jeu.PRISE_MAX);
		return this.ran.nextInt(a) + 1;
	}
    
	public String toString() {
		return "Naif";
	}
}
