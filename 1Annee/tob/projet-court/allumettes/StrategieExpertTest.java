package allumettes;

import org.junit.*;
import static org.junit.Assert.*;

/** classe de test de la classe stratégie rapide
 * 
 * @author houkhnin
 *
 */


public class StrategieExpertTest {
	
	@Test public void testerT1() throws CoupInvalideException {
		
		//Construction d'un jeu de 13 allumettes et d'une stratégie rapide .
		
		Game jeu = new Game(13);
		Strategie strategieExpert = new StrategieExpert();
		
		//Vérifier que le nombre d'alumettes est effectivement 13
		//Vérifier que la stratégie rapide prend 3 allumettes quand c'est possible.
		assertEquals("Nombre initiale des allumettes", 13, jeu.getNombreAllumettes());
		
		
		//Retirer 11 allumettes du jeu pour qu'il en reste trois .
		while (jeu.getNombreAllumettes() > 3) {
			try {
			jeu.retirer(1);
			} catch (CoupInvalideException e) {
				System.out.println("Prise invalide : "+e.getMessage());
			}
		}
		
		//Vérifier que la stratégie expert prend 2 allumettes dans ce cas.
		assertEquals("Nombre actuel des allumettes", 3, jeu.getNombreAllumettes());
		assertEquals("La prise quand le jeu ne contient que 3 allumette", 2, strategieExpert.getPrise(jeu));


	}

	
	

}
