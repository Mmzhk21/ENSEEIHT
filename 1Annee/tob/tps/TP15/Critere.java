/** {@code Critere} définit une méthode qui dit si on certain objet
  * remplit le critère ou pas.
  */
public interface Critere<T> {

	/** Retourne vrai sur l'objet respecte ce critère. */
	public boolean satisfaitSur(T objet);
}
