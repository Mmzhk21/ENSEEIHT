import java.util.ArrayList;

public class GenericiteSoustypageExempleClasse {
	
	public static void main(String[] args) {
		ArrayList<String> ls = new ArrayList<String>();
		ArrayList<Object> lo = ls;
		lo.add("texte");
		lo.add(15.5);
		System.out.println("premier élément  : " + lo.get(0));
		System.out.println("deuxième élément : " + lo.get(1));
	}

}
