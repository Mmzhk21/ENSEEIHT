import org.junit.*;
import static org.junit.Assert.*;
import java.util.*;

public class TestOutilsTousString {

	protected List<String> nombres;

	@Before
	public void setUp() {
		nombres = List.of("un", "deux", "trois", "quatre", "cinq", "six", "sept");
	}

	@Test
	public void testerListStringTrue() {
		Critere<String> deLongueurPositiveStricte = new Critere<String>() {
			@Override public boolean satisfaitSur(String s) {
				return s.length() > 0;
			}
		};
		assertTrue(Outils.tous(nombres, deLongueurPositiveStricte));
	}

	@Test
	public void testerListStringFalse() {
		Critere<String> deLongueur4 = new Critere<String>() {
			@Override public boolean satisfaitSur(String s) {
				return s.length() == 4;
			}
		};
		assertFalse(Outils.tous(nombres, deLongueur4));
	}

	@Test
	public void testerListStringStopperASAP() {
		class ViteFaux implements Critere<String> {
			public int nb = 0;
			@Override public boolean satisfaitSur(String s) {
				return ++nb > 1;
			}
		};
		ViteFaux critere = new ViteFaux();
		assertFalse(Outils.tous(nombres, critere));
		assertEquals("Inutile d'appliquer le critère sur les autres éléments"
				+ " si le résultat est connu", 1, critere.nb);
	}


}
