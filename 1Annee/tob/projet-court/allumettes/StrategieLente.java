package allumettes;

public class StrategieLente implements Strategie {

    @Override
    public String toString() {
        return "Lente";
    }

    @Override
    public int getPrise(Jeu jeu) {
        return 1;
    }


}
