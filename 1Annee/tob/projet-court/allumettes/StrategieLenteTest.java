package allumettes;

import org.junit.*;
import static org.junit.Assert.*;

/** classe de test de la classe stratégie rapide.
 * 
 * @author houkhnin
 *
 */

public class StrategieLenteTest {
	
	@Test public void testerT1() throws CoupInvalideException {
		
		//Construction d'un jeu de 13 allumettes et d'une stratégie lente .
		Game jeu = new Game(13);
		Strategie strategieLente = new StrategieLente();
		
		//Vérifier que le nombre d'alumettes est effectivement 13
		//Vérifier que la stratégie lente prend 1 allumettes quand c'est possible.
		assertEquals("Nombre initiale des allumettes", 13, jeu.getNombreAllumettes());
		assertEquals("la première prise de la stratégie", 1, strategieLente.getPrise(jeu));
		
		
		//Retirer 11 allumettes du jeu pour qu'il en reste deux .
		while (jeu.getNombreAllumettes() > 1) {
			try {
			jeu.retirer(1);
			} catch (CoupInvalideException e) {
				System.out.println("Prise invalide : "+e.getMessage());
			}
		}
		
		//Vérifier que la stratégie rapide prend 2 allumettes dans ce cas.
		assertEquals("Nombre actuel des allumettes", 1, jeu.getNombreAllumettes());
		assertEquals("La prise quand le jeu ne contient que 2 allumette", 1, strategieLente.getPrise(jeu));
		
		//Retirer une allumette supplémentaire , le jeu ne contient maintenant qu'une seule allumette .
		try {
			jeu.retirer(1);
		} catch (CoupInvalideException e) {
			System.out.println("Prise invalide : "+e.getMessage());
		}
		

	}

	
	

}
