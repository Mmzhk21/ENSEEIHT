package allumettes;

/** Lance une partie des 13 allumettes en fonction des arguments fournis
 * sur la ligne de commande.
 * @author	Xavier Crégut
 * @version	$Revision: 1.5 $
 */
public class Jouer {
	/** Nombre d'allumettes initial. */
    static int nbAllumettes_initial = 13;

	/** Lancer une partie. En argument sont donnés les deux joueurs sous.
	 * la forme nom@stratégie.
	 * @param args la description des deux joueurs
	 */
	public static void main(String[] args) {
		try {
			verifierNombreArguments(args);
            Joueur j1;
            Joueur j2;
            /** Verifie nombres d'arguments.*/
            if(args.length == Jeu.PRISE_MAX) {
            	/** S'il ya trois arguments on verifie si le premier argument est "-confiant". et on fait un split pour l'argument.
   			    * 1 et 2.*/
                  if (args[0].equals("-confiant")) {
                        	 String[] chaine1 = args[1].split("@");
                        	 String[] chaine2 = args[2].split("@");
                        	 Strategie strateg1 = getStrategie(chaine1[1],chaine1[0]);
                        	 Strategie strateg2 = getStrategie(chaine2[1],chaine2[0]);
                        	 j1 = new Joueur(chaine1[0],strateg1);
                        	 j2 = new Joueur(chaine2[0],strateg2);
                        	 Arbitre arbitre = new Arbitre(j1,j2);
                        	 Game jeu = new Game(nbAllumettes_initial);
                        	 arbitre.para = true;
                        	 arbitre.arbitrer(jeu);
                        	 
                         
                  }else {
                	  /** Si le premier argument n'est pas valide on leve une exception.*/ 
                	   throw new ConfigurationException("argument invalide : " +
       						args[1] + " different de: -confiant.");
                   }
                             
            }
            /** si le nombre d'arguments et deux on fait un split sur l'argument 0 et 1.*/
            else {
               	 String[] chaine1 = args[0].split("@");
               	 String[] chaine2 = args[1].split("@");
               	 Strategie strateg1 = getStrategie(chaine1[1],chaine1[0]);
               	 Strategie strateg2 = getStrategie(chaine2[1],chaine2[0]);
               	 j1 = new Joueur(chaine1[0],strateg1);
               	 j2 = new Joueur(chaine2[0],strateg2);
               	 Arbitre arbitre = new Arbitre(j1,j2);
               	 Game jeu = new Game(13);
               	 arbitre.arbitrer(jeu);
            	
            }
		} catch (ConfigurationException e) {
			System.out.println();
			System.out.println("Erreur : " + e.getMessage());
			afficherUsage();
			System.exit(1);
		}
}
    
	/** Obtenir la strategie.
	 * @param chaine
	 * @param nomj
	 * @return une strategie
	 * @throws StrategieNotFoundException
	 */
	public static Strategie getStrategie(String chaine, String nomj) throws ConfigurationException{
		String nom = chaine.toLowerCase();
        if(nom.equals("naif")) {
            return new StrategieNaif();
		}
        else if(nom.equals("rapide")) {
            return new StrategieRapide();
		}
        else if(nom.equals("expert")){
            return new StrategieExpert();
		}
        else if(nom.equals("lente")){
            return new StrategieLente();
		}
        else if(nom.equals("humain")) {
            return new StrategieHumaine(nomj);
        }else if(nom.equals("tricheur")) {
            return new StrategieTricheur();
        }else{
        	throw new ConfigurationException("Stratégie inconnue");
        			}   
    }
	
	/** Verifier Nombre d'Arguments.
	 * 
	 * @param args
	 */
	private static void verifierNombreArguments(String[] args) {
		final int nbJoueurs = 2;
		if (args.length < nbJoueurs) {
			throw new ConfigurationException("Trop peu d'arguments : "
					+ args.length);
		}
		if (args.length > nbJoueurs + 1) {
			throw new ConfigurationException("Trop d'arguments : "
					+ args.length);
		}
	}

	/** Afficher des indications sur la manière d'exécuter cette classe. */
	public static void afficherUsage() {
		System.out.println("\n" + "Usage :"
				+ "\n\t" + "java allumettes.Jouer joueur1 joueur2"
				+ "\n\t\t" + "joueur est de la forme nom@stratégie"
				+ "\n\t\t" + "strategie = naif | rapide | expert | humain | tricheur"
				+ "\n"
				+ "\n\t" + "Exemple :"
				+ "\n\t" + "	java allumettes.Jouer Xavier@humain "
					   + "Ordinateur@naif"
				+ "\n"
				);
	}

}
