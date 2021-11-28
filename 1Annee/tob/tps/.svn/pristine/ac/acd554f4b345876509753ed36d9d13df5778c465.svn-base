package allumettes;

/** Exception qui indique qu'un coup invalide est joué.
 * @author	Xavier Crégut
 * @version	$Revision: 1.3 $
 */
public class CoupInvalideException extends Exception {

	/** Nombre d'allumettes prises. */
	private int nbAllumettes;

	/** Initialiser CoupInvalideException à partir du nombre d'allumettes
	 * prises et le problème constaté.  Par exemple, on peut avoir nombre
	 * d'allumettes qui vaut 0 et le problème "< 1".
	 * @param nb le nombre d'allumettes prises
	 * @param probleme le problème sur le nombre d'allumettes
	 */
	public CoupInvalideException(int nb, String probleme) {
		super("Nombre d'allumettes invalide : " + nb + " (" + probleme + ")");
		this.nbAllumettes = nb;
	}

	/** Indiquer le nombre d'allumettes qu'un joueur a voulu prendre.
	  * @return le nombre d'allumettes qu'un joueur a voulu prendre. */
	public int getNombreAllumettes() {
		return this.nbAllumettes;
	}

}
