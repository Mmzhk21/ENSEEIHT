package allumettes;

public class StrategieRapide implements Strategie{

	@Override
	public int getPrise(Jeu jeu) {
		int a = Math.min(jeu.getNombreAllumettes(), Jeu.PRISE_MAX);
		return a;
	}
	
    public String toString() {
    	return "Rapide";
    }
}
