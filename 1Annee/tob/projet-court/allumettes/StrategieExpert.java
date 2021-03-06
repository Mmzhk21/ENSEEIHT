package allumettes;

import java.util.Random;

public class StrategieExpert implements Strategie{

	public Random ran;
	 
	public StrategieExpert() {
		this.ran = new Random();
	}
	
	
	
	
	
	@Override
	public int getPrise(Jeu jeu) {
		if (jeu.getNombreAllumettes() == 1) {
			return 1;
		}else if((jeu.getNombreAllumettes() - 1) % (Jeu.PRISE_MAX + 1) == 0){
			int a = Math.min(jeu.getNombreAllumettes(), Jeu.PRISE_MAX) + 1;
			return this.ran.nextInt(a);	
		}else {
			return (jeu.getNombreAllumettes()-1) % (Jeu.PRISE_MAX + 1);
		}
	}

}
