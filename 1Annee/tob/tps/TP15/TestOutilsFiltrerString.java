import org.junit.*;
import static org.junit.Assert.*;
import java.util.*;

public class TestOutilsFiltrerString {

	protected List<String> nombres;
	protected Critere<String> deLongueur4;

	@Before
	public void setUp() {
		nombres = List.of("un", "deux", "trois", "quatre", "cinq", "six", "sept");
		deLongueur4 = new Critere<String>() {
			@Override public boolean satisfaitSur(String s) {
				return s.length() == 4;
			}
		};
	}

	@Test
	public void testerListString() {
		List<String> mots4 = new ArrayList<>();
		Outils.filtrer(nombres, deLongueur4, mots4);
		assertEquals(3, mots4.size());
		assertEquals(List.of("deux", "cinq", "sept"), mots4);
	}

}
