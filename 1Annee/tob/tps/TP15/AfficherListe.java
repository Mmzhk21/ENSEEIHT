import java.util.List;
import java.util.ArrayList;
import java.util.Collections;

public class AfficherListe {

	/** Afficher les éléments de liste, un par ligne... */
	public static void afficher(List<Object> liste) {
		for (Object o : liste) {
			System.out.println("  - " + o);
		}
	}

	public static void main(String[] args) {
		List<Object> lo = new ArrayList<>();
		Collections.addAll(lo, "un", "deux", 3);
		afficher(lo);

		List<String> ls = new ArrayList<>();
		Collections.addAll(ls, "un", "deux", "trois");
		afficher(ls);
	}
}
