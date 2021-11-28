import java.awt.Color;
import org.junit.*;
import static org.junit.Assert.*;

/**
  * les tests E12, E13 et E14.
  * @author	houkhnin
  */
public class CercleTest {

	// précision pour les comparaisons réelle
	public final static double EPSILON = 0.001;

	// Les points du sujet
	private Point C, D, E;

	// Les cercles du sujet
	private Cercle C2, C3, C4;

	@Before public void setUp() {
		// Construire les points
		C = new Point(1, 1);
		D = new Point(3, 2);
		E = new Point(4, 9);

		// Construire les cercles
        C2 = new Cercle(C, D);
        C3 = new Cercle(C, E, Color.BLACK);
        C4 = Cercle.creerCercle(D, E);
	}

	/** Vérifier si deux points ont mêmes coordonnées.
	  * @param p1 le premier point
	  * @param p2 le deuxième point
	  */
	static void memesCoordonneess(String message, Point p1, Point p2) {
		assertEquals(message + " (x)", p1.getX(), p2.getX(), EPSILON);
		assertEquals(message + " (y)", p1.getY(), p2.getY(), EPSILON);
	}

	@Test public void testterE12() {
		memesCoordonneess("E12 : Centre de C2 incorrect", new Point(2,1.5), C2.getCentre());
		assertEquals("E12 : Rayon de C2 incorrect",
				Math.sqrt(5)/2, C2.getRayon(), EPSILON);
		assertEquals(Color.blue, C2.getCouleur());
	}
    
    @Test public void testterE13() {
		memesCoordonneess("E13 : Centre de C3 incorrect", new Point(2.5 , 5), C3.getCentre());
		assertEquals("E13 : Rayon de C3 incorrect",
				Math.sqrt(73)/2, C3.getRayon(), EPSILON);
		assertEquals("E13 : Couleur de C3 incorrecte", Color.BLACK, C3.getCouleur());
    }
    
    @Test public void testterE14() {
		memesCoordonneess("E14 : Centre de C4 incorrect", D, C4.getCentre());
		assertEquals("E14 : Rayon de C4 incorrect",
				Math.sqrt(50), C4.getRayon(), EPSILON);
		assertEquals(Color.blue, C4.getCouleur());
	}

}