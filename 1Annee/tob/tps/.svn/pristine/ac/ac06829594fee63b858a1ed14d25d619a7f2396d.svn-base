import java.util.*;

public class ExempleUnmodifiableList {

	/* Consigne :
	 * - remplacer les XXX* par les expressions qui vont bien
	 * - remplacer les TODO() par les instructions qui vont bien
	 */

	final static char NL = '\n', TAB = '\t';

	/*
	   Le nom de cette méthode laisse penser qu'elle se contente de consulter la liste.
	   Peut-elle quand même la modifier ? Pourquoi ?
	*/
	public static void consulter(List<Integer> nombres, int entier) {
		System.out.println(NL + "consulter(" + nombres + ", " + entier + ")");
		System.out.println("=== J'EN M'ENGAGE À NE PAS MODIFIER LA LISTE ===");

		// Afficher la taille de la liste nombres
		System.out.println("nombres = " + nombres);
		int taille = XXX_i;		// La taille de nombres

		System.out.println("taille = " + taille);
		assert taille >= 0 : "Il faut remplacer le XXX_i :";

		// Afficher la présence de l'élément entier dans la liste nombres
		boolean est_present = XXX_b;	// entier est-il présent dans nombres ?

		System.out.println(entier + " dans nombres ? " + (est_present ? "oui" : "non"));

		// Afficher la fréquence de entier dans nombres
		int frequence = XXX_i;	// fréquence de entier dans nombres ?

		System.out.println("fréquence de " + entier + " dans nombres ? " + frequence);
		assert frequence >= 0 : "Il faut remplacer le XXX_i :";

		// Supprimer une fois l'élément entier de nombres
		System.out.println("suppression de " + entier);
		TODO();
		System.out.println("nombres = " + nombres);

		// Afficher la taille de la liste nombres
		int nouvelle_taille = XXX_i;	// La taille de nombres
		System.out.println("taille de nombres = " + nouvelle_taille);
		assert nouvelle_taille >= 0 : "Il faut remplacer le XXX_i :";

		if (nouvelle_taille < taille) {
			System.out.println("=== J'AI QUAND MÊME MODIFIÉ LA LISTE ===");
		}

		// Afficher la présence de l'élément entier dans la liste nombres
		boolean encore_present = XXX_b;	// entier est-il présent dans nombres ?

		System.out.println(entier + " dans nombres ? " + (encore_present ? "oui" : "non"));
		assert  frequence > 1 == encore_present
				// frequence > 1 <=> encore_present
			: "frequence et/ou encore_present mal définis !";

		// Afficher la fréquence de entier dans nombres
		int nouvelle_frequence = XXX_i;	// fréquence de entier dans nombres ?

		System.out.println("fréquence de " + entier + " dans nombres ? " + nouvelle_frequence);

		assert nouvelle_frequence >= 0 : "Il faut remplacer le XXX_i :";

		// Faire quelques vérifications
		assert frequence - 1 <= nouvelle_frequence && nouvelle_frequence <= frequence
			: "Les fréquences semblent avoir été mal calculées :";

		assert ! est_present || nouvelle_taille < taille
			: "Élément non supprimé : TODO() non remplacé ?";

		assert nouvelle_frequence != frequence || ! est_present
					// nouvelle_frequence == frequence => ! est_present
			: "Est-ce que est_present a été calculé correctement ?";

		assert frequence != 1 || ! encore_present
					// frequence == 1 ==> ! encore_present
			: "" + NL + TAB +  "Comment se fait-il que l'élément soit encore là ?"
			 + NL + TAB + "Indications :"
			 + NL + TAB + TAB + "- Chercher 'remove' dans la documentation de List"
			 + NL + TAB + TAB + "- Quel élément a été supprimé de la liste ?"
			 + NL + TAB + TAB + "- Quel est l'indice de l'élémet supprimé ?"
			 ;
	}

	public static void exemple1() {
		List<Integer> mesNombres = new ArrayList<>();
		Collections.addAll(mesNombres, 0, 2, 3, 5, 7);

		List<Integer> autresNombres = new ArrayList<>();
		Collections.addAll(autresNombres, 0, 2, 3, 5, 7, 0, 0);

		consulter(mesNombres, 4);
		consulter(mesNombres, 0);
		consulter(autresNombres, 0);
		consulter(mesNombres, 2);
		consulter(mesNombres, 7);
	}

	public static void exemple2() {
		List<Integer> mesNombres = new ArrayList<>();
		Collections.addAll(mesNombres, 0, 2, 3, 5, 7);

		// Maintenant, on veut être sûr que consulter ne modifiera pas la liste
		// Comment faire ?  On utlisera Collections.unmodifiableList()
		TODO();

		for (int i : new int[] {4, 0, 2, 7}) {
			try {
				consulter(mesNombres, i);
				throw new AssertionError("La liste est modifiable !");
			} catch (Exception e) {
				System.out.println("EXCEPTION : " + e);
				System.out.println("mesNombres = " + mesNombres + NL);
			}
		}

		// Vérifier que les autres opérations de modification de liste ne
		// peuvent pas être appelées non plus : add, set, etc.
		TODO();
	}

	public static void main(String[] args) {
		if (! ExempleUnmodifiableList.class.desiredAssertionStatus()) {
			System.out.println(""
					+ NL + "Il FAUT exécuter ce programme avec l'option -ea : "
					+ NL + TAB + "java -ea ExempleUnmodifiableList"
					+ NL);
			System.exit(-1);
		}

		exemple1();
		exemple2();
	}

	final private static String XXX_s = "il faut remplacer les XXX* !";
	final private static int XXX_i = -1;
	final private static boolean XXX_b = false;

	static private void TODO() {
		// Ne pas modifier cette méthode !
		System.out.println("Il faut remplacer TODO() par le code qui va bien");
	}

}
