/** mini-projet.
 * @author houkhnin
 */

import java.awt.Color;


/** Un cercle est défini par un point et un rayon.
 *  Un Cercle peut être affiché et translaté.
 */
public class Cercle implements Mesurable2D{

	  // le centre du cercle
      private Point centre;
      // le rayon du cercle
      private double rayon;
      // la couleur du cercle
      private Color couleur;

      // constante PI.
  	  public static final double PI = Math.PI;

      /**  Construire un Cercle à partir d'un point et d'un rayon.
       *  @param c le point centre
       *  @param r le rayon
       */
      public Cercle(Point c, double r) {
    	  assert(c != null && r > 0);
   	       Point p = new Point(c.getX(), c.getY());
           this.centre = p;
           this.rayon = r;
           this.couleur = Color.BLUE;
      }

      /** Construire un cercle à partir de deux points diamétralement opposés.
       * et sa couleur est le bleu
       * @param point1 premier point
       * @param point2 deuxieme point
       */
      public Cercle(Point point1, Point point2) {
    	assert(point1 != null && point2 != null);
        assert(point1.getX() != point2.getX() || point1.getY() != point2.getY());
   	    double cx = (point1.getX() + point2.getX()) / 2;
   	    double cy = (point1.getY() + point2.getY()) / 2;
   	    this.centre = new Point(cx, cy);
   	    this.rayon = point1.distance(point2) / 2;
   	    this.couleur = Color.blue;
      }

      /** Construire un cercle à partir de deux.
       * points diamétralement opposés et de sa couleur
       * @param p1 premier point
       * @param p2 deuxieme point
       * @param nvColeur la couleur du cercle
       */
      public Cercle(Point p1, Point p2, Color nvColeur) {
          this(p1, p2);
          assert nvColeur != null;
          this.couleur = nvColeur;
      }

      /** Créer un cercle à partir de deux points.
       * le premier correspond au centre du cercle
       * et le deuxième est un point du cercle
       * @param p1 le centre
       * @param p2 point appartient au cercle
       * @return un cercle
       */
      public static Cercle creerCercle(Point p1, Point p2) {
   	      assert(p1 != null && p2 != null && p1 != p2);
          assert(p1.getX() != p2.getX() || p1.getY() != p2.getY());
          return new Cercle(p1, p1.distance(p2));
      }

      /** obtenir le centre d’un cercle.
       *
       * @return Point
       */
       public Point getCentre() {
    	   return new Point(this.centre.getX(), this.centre.getY());
       }

      /**obtenir le rayon d’un cercle.
       * @return double
       */
       public double getRayon() {
    	   return this.rayon;
       }

      /** obtenir le diametre d’un cercle.
       * @return double
       */
       public double getDiametre() {
    	   return 2 * this.rayon;
       }

       /** Obtenir la couleur du Cercle.
        * @return la couleur du Cercle
        */
       public Color getCouleur() {
               return this.couleur;
       }

       /**Changer le centre d'un cercle
        * @param NewCentre le nouveau centre du cercle
        */
       public void setCentre(Point nvCentre){
           this.centre = nvCentre;
       }

       /** Changer le rayon du cercle.
        * @param nouvelleRayon nouvel rayon
        */
       public void setRayon(double nouvelleRayon) {
    	   assert nouvelleRayon > 0;
           this.rayon = nouvelleRayon;
       }

       /** Changer le diamètre du cercle.
        * @param nouvelleDiametre nouvelle Diametre
        */
       public void setDiametre(double nouvelleDiametre) {
    	   assert nouvelleDiametre > 0;
    	   this.rayon = nouvelleDiametre / 2;
       }

       /** Changer la couleur du Cercle.
        * @param nouvelleCouleur nouvelle couleur
        */
       public void setCouleur(Color nouvelleCouleur) {
    	       assert nouvelleCouleur != null;
               this.couleur = nouvelleCouleur;
       }

       /** savoir si un point est à l’intérieur d’un cercle.
        * @param p
        * @return boolean
        */
       public boolean contient(Point p) {
    	   assert p != null;
    	   return p.distance(this.getCentre()) <= this.getRayon();
       }

       /** Le périmètre d’un cercle.
        *
        * @return double
        */
       public double perimetre() {
    	   double t = 2 * PI * this.rayon;
    	   return t;
       }

       /** L'aire d’un cercle.
        * @return double
        */
       public double aire() {
    	   double s = PI * Math.pow(this.getRayon(), 2);
    	   return s;
       }

       /**afficher le cercle sous la forme Cr@(a,b).
         *@return la forme d'affichage d'un cercle
        */
       public String toString() {
   		   return "C" + this.rayon + "@" + this.centre;
   	   }

       /** Afficher le cercle. */
       public void afficher() {
   		System.out.print(this);
   	   }

       /** Translater le Cercle.
        * @param dx déplacement suivant l'axe des X
        * @param dy déplacement suivant l'axe des Y
        */
        public void translater(double dx, double dy) {
            this.centre.translater(dx, dy);
        }
}




