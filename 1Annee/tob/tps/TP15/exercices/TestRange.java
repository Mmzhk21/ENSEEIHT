package exercices;

import org.junit.*;
import static org.junit.Assert.*;
import static exercices.Range.range;
import java.util.NoSuchElementException;
import java.util.Iterator;

/** Classe de test de la classe {@ Range}.  */
public class TestRange {

	@Test
	public void testerSujet() {
		Iterable<Integer> iterable = range(2, 11, 3);
		Iterator<Integer> it = iterable.iterator();
		assertTrue(it.hasNext());
		assertEquals(2, (int) it.next());
		assertTrue(it.hasNext());
		assertEquals(5, (int) it.next());
		assertTrue(it.hasNext());
		assertEquals(8, (int) it.next());
		assertFalse(it.hasNext());
	}

	static Iterator<Integer> verifierRange(int debut, int fin, int pas) {
		return verifierRange(debut, fin, pas, range(debut, fin, pas));
	}

	static Iterator<Integer> verifierRange(int debut, int fin, int pas, Iterable<Integer> iterable) {
		assertTrue("Dans ce test, le pas doit être positif !", pas > 0);
		Iterator<Integer> it = iterable.iterator();
		for (int i = debut; i < fin; i += pas) {
			assertTrue(it.hasNext());
			assertEquals(i, (int) it.next());
		}
		assertFalse(it.hasNext());
		return it;
	}

	@Test
	public void testerRangePas1() {
		verifierRange(0, 10, 1);
	}

	@Test(expected=NoSuchElementException.class)
	public void testerRangePas1NextEnTrop() {
		Iterator<Integer> it = verifierRange(0, 10, 1);
		it.next();
	}


	@Test
	public void testerRangeVide() {
		Iterator<Integer> it = range(20, 11, 3).iterator();
		assertFalse(it.hasNext());
	}

	@Test(expected=NoSuchElementException.class)
	public void testerRangeVideNext() {
		Iterator<Integer> it = range(20, 11, 3).iterator();
		it.next();
	}

	@Test
	public void testPlusieursITerateurs() {
		Iterable<Integer> iterable = range(0, 10, 1);

		Iterator<Integer> itX = iterable.iterator();
		int x1 = itX.next();
		assertEquals(0, x1);
		int x2 = itX.next();
		assertEquals(1, x2);

		Iterator<Integer> itY = iterable.iterator();
		int y1 = itY.next();
		assertEquals(x1, y1);
		int y2 = itY.next();
		assertEquals(x2, y2);
		int y3 = itY.next();
		assertEquals(2, y3);
		assertEquals(3, (int) itY.next());

		int x3 = itX.next();
		assertEquals(y3, x3);
	}

	@Test(expected=IllegalArgumentException.class)
	public void testerPasNul() {
		range(1, 10, 0);
	}

	@Test(expected=IllegalArgumentException.class)
	public void testerPasNegatif() {
		range(1, 10, -5);
	}

}
