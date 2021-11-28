import java.awt.Color;
import org.junit.*;
import static org.junit.Assert.*;

/**
 * des tests complementaires
 * @author houkhnin
 */
public class ComplementsCercleTest {

	// précision pour les comparaisons réelle
	public final static double EPSILON = 0.001;
	
	// constante PI
	public static final double PI = Math.PI;
	
	// Les points du sujet
	private Point A, B, C, H, G;

	// Les cercles du sujet
	private Cercle C1, C2, C4;
	
	@Before public void setUp() {
		// Construire les points
		A = new Point(-1, 1);
		B = new Point(2, 3);
		C = new Point(5, -1);
		H = new Point(0, 2);
		G = new Point(8,7);
		// Construire les cercles
        C1 = new Cercle(A, 3.5);
        C2 = new Cercle(A, B);
        C4 = Cercle.creerCercle(B, C);
	}
           // verifier que le cercle C1 contient H et ne contient pas G
	@Test public void testerContientE12() {
	           assertTrue(C1.contient(H));
	           assertFalse(C1.contient(G));
	}
	 
	// tester setCouleur
	@Test public void testerSetcouleurE10() {
		C2.setCouleur(Color.black);
		assertEquals(C2.getCouleur(), Color.black);
	}
	
	//Tester setRayon
	@Test public void testerSetRayonE16() {
		C2.setRayon(5.3);
		assertEquals(C2.getRayon(), 5.3, EPSILON);
	}
	
	// Vérifier l'aire et le perimetre
	@Test public void testerAirePerimetre() {
		    assertEquals(C1.aire(), PI * Math.pow(3.5, 2), EPSILON);
			assertEquals(C1.perimetre(), 2 * PI * 3.5, EPSILON);
	        
	}
	@Test public void testerSetDiametreE17() {
		C4.setDiametre(14);
		assertEquals(C4.getDiametre(), 14, EPSILON);
	}
	@Test public void testerE8() {
        assert(C1.getCouleur() != null);
        assert(C2.getCouleur() != null);
        assert(C4.getCouleur() != null);
    }	
	}
