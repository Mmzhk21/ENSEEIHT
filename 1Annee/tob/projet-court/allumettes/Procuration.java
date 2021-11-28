package allumettes;

public class Procuration implements Jeu{

	
	private Jeu jeu;
	 
	public Procuration(Jeu jeu) {
		assert jeu != null;
		this.jeu = jeu;
	}
	@Override
	public int getNombreAllumettes() {
		
		return this.jeu.getNombreAllumettes();
	}

	@Override
	public void retirer(int nbPrises) throws CoupInvalideException {
		
		throw new OperationInterditeException("Cette Opération est interdite dans le jeu,faut pas tricher voyons :) !");
	}
	

}
