package allumettes;

public class Arbitre {
    
	// premier joueur
	public Joueur j1;
	// le duexième joueur
	public Joueur j2;
	public Boolean para = false;
	
	
	/** constructeur  qui  prend  en  paramètre  les  deux  joueurs j1 et j2 qui vont s’affronter.
	 * 
	 * @param j1
	 * @param j2
	 */
	public Arbitre(Joueur j1, Joueur j2) {
		this.j1 = j1;
		this.j2 = j2;
	}
	
	public void arbitrer(Jeu jeu) {
		
		Boolean tour = true;
		Jeu procuration = new Procuration(jeu);
		
		while(jeu.getNombreAllumettes() > 0) {
			Joueur joueur = this.j1;
			if(!tour) {
				joueur = this.j2;
			}
			System.out.println("Nombre d'allumettes restantes : " + jeu.getNombreAllumettes());
			try {
				int n=0;
				
				if(para) {
				     n = joueur.getPrise(jeu);
				}else {
					 n = joueur.getPrise(procuration);
				}
				
				if(n>1) {
				System.out.print(joueur.getNom() + " prend " + n + " allumettes.");
				}else {
					System.out.print(joueur.getNom() + " prend " + n + " allumette.");
				}
				System.out.println("");
				jeu.retirer(n);
				
				tour = !tour;
			}
				
			catch(CoupInvalideException e) {
				System.out.print("Impossible ! ");
				System.out.print(e.getMessage());
				
				System.out.println("");
			}catch(IllegalArgumentException e) {
		        	System.out.print(j1.getNom() + ", combien d'allumettes ? ");}
		  catch(OperationInterditeException e) {
			  System.out.println("Abandon de la partie car " + joueur.getNom() + " triche !");
		          Runtime.getRuntime().exit(1);
		  }
			System.out.println("");
		}
			if(!tour) {
			      System.out.println(j1.getNom() + " perd !");
			      System.out.println(j2.getNom() + " gagne !");
			}else {
				System.out.println(j2.getNom() + " perd !");
				System.out.println(j1.getNom() + " gagne !");
			}

		}	
	}	
