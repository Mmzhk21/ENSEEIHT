package allumettes;

public class Game implements Jeu {

	public static final int nbMaximal = 3;

	public int nbAllumettes;
	
	public Game(int nbAllumettes) {
		assert nbAllumettes > 0;
		this.nbAllumettes = nbAllumettes;
	}

	@Override
	public int getNombreAllumettes() {
		return this.nbAllumettes;
	}

	@Override
	public void retirer(int nbPrises) throws CoupInvalideException {
		if (nbPrises < 1) {
            throw new CoupInvalideException(nbPrises, "< 1");
        }
		else if  (Jeu.PRISE_MAX > this.nbAllumettes && nbPrises > Jeu.PRISE_MAX) {
            throw new CoupInvalideException(nbPrises, "> " + this.nbAllumettes);
        }
		else if (nbPrises > PRISE_MAX && Jeu.PRISE_MAX < this.nbAllumettes ) {
            throw new CoupInvalideException(nbPrises, "> " + Jeu.PRISE_MAX);
        }
		else if (nbPrises > this.nbAllumettes) {
			throw new CoupInvalideException(nbPrises, "> " + this.nbAllumettes);
		}else {
			this.nbAllumettes = this.nbAllumettes - nbPrises;
		}
        
    }
		
}
