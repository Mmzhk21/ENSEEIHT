package allumettes;

public class StrategieTricheur implements Strategie {

    public int getPrise(Jeu jeu) {
    	assert (jeu != null);
    	try {
    		System.out.println("[Je triche... ] ");
    		
    	    while (jeu.getNombreAllumettes() > 2) {
    		    jeu.retirer(1);
    		    
    	    }
	    System.out.println("[Allumettes restantes : 2]");
    	} catch (CoupInvalideException e) {
    		// Ce message ne s'affichera jamais!
    		System.out.println("[Allumettes restantes : 2]");
    	}
    	return 1;
    }
    public String toString() {
    	return "Tricheur";
    }
}
