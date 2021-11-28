import org.junit.*;
import static org.junit.Assert.*;
import java.util.*;

/** Test de Outils.filtrer sur les nombres.  */
public class TestOutilsFiltrerNumber {

	final static Critere<Number> estEntier = new Critere<Number>() {
		@Override
		public boolean satisfaitSur(Number n) {
			return n.intValue() > 0;
		}
	};

	@Test
	public void testerNombresHeterogenes() {
		List<Number> resultats = new ArrayList<>();
		List<Number> nombres = List.of(1, -2.3, -4, 5.6, 0);
		Outils.filtrer(nombres, estEntier, resultats);
		assertEquals(2, resultats.size());
		assertEquals(List.of(1, 5.6), resultats);
	}


	@Test
	public void testerNombresEntiers() {
		List<Number> resultats = new ArrayList<>();
		List<Integer> nombres = List.of(1, -2, -4, 5, 0);
		Outils.filtrer(nombres, estEntier, resultats);
		assertEquals(2, resultats.size());
		assertEquals(List.of(1, 5), resultats);
	}

	@Test
	public void testerNombresEntiersVersObject() {
		List<Object> resultats = new ArrayList<>();
		List<Integer> nombres = List.of(1, -2, -4, 5, 0);
		Outils.filtrer(nombres, estEntier, resultats);
		assertEquals(2, resultats.size());
		assertEquals(List.of(1, 5), resultats);
	}


}
