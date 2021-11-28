import org.junit.*;
import static org.junit.Assert.*;
import java.util.*;

/** Classe de test de Outil.tous avec des Numbers.  */
public class TestOutilsTousNumber {

	protected List<Integer> entiers;
	protected List<Double> reels;
	protected Critere<Number> nonNul;
	protected Critere<Number> estPositif;

	@Before
	public void setUp() {
		entiers = List.of(2, -3, 12, -5, 17, 18, 13);
		reels = List.of(2.01, 0.0003, 12.0, 5.1, 17.5, 1.8, 1.234);

		nonNul = new Critere<Number>() {
			@Override public boolean satisfaitSur(Number n) {
				return n.intValue() != 0;
			}
		};

		estPositif = new Critere<Number>() {
			@Override public boolean satisfaitSur(Number n) {
				return n.intValue() >= 0;
			}
		};
	}

	@Test
	public void testerListEntiersTrueNonNuls() {
		assertTrue(Outils.tous(entiers, nonNul));
	}
	
	@Test
	public void testerListEntiersFalsePositifs() {
		assertFalse(Outils.tous(entiers, estPositif));
	}


	@Test
	public void testerListReelsFalseNonNuls() {
		assertFalse(Outils.tous(reels, nonNul));
	}
	
	@Test
	public void testerListReelsTruePositifs() {
		assertTrue(Outils.tous(reels, estPositif));
	}


}
