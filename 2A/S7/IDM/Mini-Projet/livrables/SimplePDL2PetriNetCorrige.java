package simplepdl.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.ResourceSet;
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl;
import org.eclipse.emf.ecore.xmi.impl.XMIResourceFactoryImpl;

import simplepdl.Allocate;
import simplepdl.Process;
import simplepdl.Ressource;
import simplepdl.WorkDefinition;
import simplepdl.WorkSequence;
import simplepdl.WorkSequenceType;
import simplepdl.SimplepdlFactory;
import simplepdl.SimplepdlPackage;

import petriNet.*;

public class SimplePDL2PetriNet {
	
	// La fabrique pour fabriquer les éléments de PetriNet
    static PetriNetFactory myFactory;
    static PetriNet petriNet;
    
	
	static Map<WorkDefinition,List<Node>> registre = new HashMap<WorkDefinition,List<Node>>();
	
	    
	public static void main(String[] args) {
		      
		        // Charger le package SimplePDL afin de l'enregistrer dans le registre d'Eclipse.
				SimplepdlPackage SimplePDLpackageInstance = SimplepdlPackage.eINSTANCE;
				// Charger le package PetriNet afin de l'enregistrer dans le registre d'Eclipse.
				PetriNetPackage PetriNETpackageInstance = PetriNetPackage.eINSTANCE;
				
				// Enregistrer l'extension ".xmi" comme devant Ãªtre ouverte Ã 
				// l'aide d'un objet "XMIResourceFactoryImpl"
				Resource.Factory.Registry reg = Resource.Factory.Registry.INSTANCE;
				Map<String, Object> m = reg.getExtensionToFactoryMap();
				m.put("xmi", new XMIResourceFactoryImpl());
				
				// Créer un objet resourceSetImpl qui contiendra une ressource EMF (le modèle)
				ResourceSet resSet = new ResourceSetImpl();
				
				// Créer le modèle de sorte (PetriNet.xmi)
				URI SortieURI = URI.createURI("models/sujet-pdl.xmi");
				Resource Sortie = resSet.createResource(SortieURI);
				
				// Créer un objet resourceSetImpl qui contiendra une ressource EMF (le modèle)
				ResourceSet resSetModel = new ResourceSetImpl();
				// Charger la ressource (notre modèle)
				URI modelURI = URI.createURI("models/SimplePDLCreator_Created_Process.xmi");
				Resource resource = resSetModel.getResource(modelURI, true);
			    
			 
			    
			    // Récupérer la racine du modèle
				Process process =(Process) resource.getContents().get(0);
				
				// Instancier la Fabrique
				myFactory =PetriNetFactory.eINSTANCE;
				
				//Créer le réseau petriNet
				petriNet = myFactory.createPetriNet();
				petriNet.setName(process.getName());
				Sortie.getContents().add(petriNet);
				
				// parcourir les elements de process
				for(Object o : process.getProcessElements()) {
					// transformer WorkDefinition to Node
					if(o instanceof WorkDefinition) {
						convert_Wd2Node((WorkDefinition) o);
					}
					
					//transformer workSequence to arc
					if(o instanceof WorkSequence) {
						convert_Ws2Arc((WorkSequence) o);
					}
					 
					// transformer Ressource to places
					if(o instanceof Ressource) {
						convertRessource((Ressource) o);
					}
					
				}
				
				
			    
				
				// Sauver la ressource
			    try {
			    	Sortie.save(Collections.EMPTY_MAP);
				} catch (IOException e) {
					e.printStackTrace();
				}
	}
	// methodes locales utilisées
	   // la méthode convert_Ws2Arc
	public static void convert_Ws2Arc(WorkSequence ws) {
		// creation d'un arc
		arc arc = myFactory.createarc();
		
		switch (ws.getLinkType()) {
		case START_TO_START :
		     arc.setSource(registre.get(ws.getPredecessor()).get(1));
		     arc.setCible(registre.get(ws.getSuccessor()).get(0));
		     break;
		case START_TO_FINISH :
			 arc.setSource(registre.get(ws.getPredecessor()).get(1));
			 arc.setCible(registre.get(ws.getSuccessor()).get(2));
		     break;
		case FINISH_TO_START :
			 arc.setSource(registre.get(ws.getPredecessor()).get(3));
			 arc.setCible(registre.get(ws.getSuccessor()).get(0));
		     break;
		case FINISH_TO_FINISH :
			 arc.setSource(registre.get(ws.getPredecessor()).get(3));
			 arc.setCible(registre.get(ws.getSuccessor()).get(2));
		     break;
		 default : break;
		}
		
		arc.setKind(ArcKind.READ_ARC);
     arc.setWeight(1);
      
     
     /// ajouter l'arc au reseau de petriNet
     petriNet.getPetriNetElements().add(arc);
	}
		
	// convertion the workDenitions to places and transitions
	public static void convert_Wd2Node(WorkDefinition wd) {
		 
		//creation des places:
		Place pl_not_Started = myFactory.createPlace();
		pl_not_Started.setName(wd.getName() + "Not_Started");
		pl_not_Started.setTokens(1);
		petriNet.getPetriNetElements().add(pl_not_Started);
		
		
		
		Place pl_Started = myFactory.createPlace();
		pl_Started.setName(wd.getName() + "Started");
		pl_Started.setTokens(0);
		petriNet.getPetriNetElements().add(pl_Started);
		
		
		Place pl_in_Progress = myFactory.createPlace();
		pl_in_Progress.setName(wd.getName() + "In_Progress");
		pl_in_Progress.setTokens(0);
		petriNet.getPetriNetElements().add(pl_in_Progress);
		
		
		Place pl_Finished = myFactory.createPlace();
		pl_Finished.setName(wd.getName() + "Finished");
		pl_Finished.setTokens(0);
		petriNet.getPetriNetElements().add(pl_Finished);
		

		
		
		// creation des transitions
		Transition tr_Start = myFactory.createTransition();
		tr_Start.setName(wd.getName() + "start");
		petriNet.getPetriNetElements().add(tr_Start);
		
		
		Transition tr_Finish = myFactory.createTransition();
		tr_Finish.setName(wd.getName() + "finish");
		petriNet.getPetriNetElements().add(tr_Finish);
		
		
		// enregistrer wd et ses caractéristiques dans le registre
		registre.put(wd, new ArrayList<Node>());
		registre.get(wd).add(tr_Start);
		registre.get(wd).add(pl_Started);
		registre.get(wd).add(tr_Finish);
		registre.get(wd).add(pl_Finished);


		
		//creation des arcs
		// l'arc entre activite_Not_started et la transition activite_Start
		 arc arc_NS2TrS = myFactory.createarc();
		 arc_NS2TrS.setSource(pl_not_Started);
		 arc_NS2TrS.setCible(tr_Start);
		 arc_NS2TrS.setKind(ArcKind.NORMAL);
		 arc_NS2TrS.setWeight(1);
		 petriNet.getPetriNetElements().add(arc_NS2TrS);

    
		// l'arc entre la transition activite_Start et la place activite_started
				 arc arc_TrS2pl_S = myFactory.createarc();
				 arc_TrS2pl_S.setSource(tr_Start);
				 arc_TrS2pl_S.setCible(pl_Started);
				 arc_TrS2pl_S.setKind(ArcKind.NORMAL);
				 arc_TrS2pl_S.setWeight(1);
				 petriNet.getPetriNetElements().add(arc_TrS2pl_S);

		// l'arc entre la transition activite_Start et la place activite_In_progress
				 arc arc_TrS2pl_progress = myFactory.createarc();
				 arc_TrS2pl_progress.setSource(tr_Start);
				 arc_TrS2pl_progress.setCible(pl_in_Progress);
				 arc_TrS2pl_progress.setKind(ArcKind.NORMAL);
				 arc_TrS2pl_progress.setWeight(1);
			     petriNet.getPetriNetElements().add(arc_TrS2pl_progress);

			// l'arc entre la place activite_In_progress et la transitions activite_finish
				 arc arc_pl_progress2TrF = myFactory.createarc();
				 arc_pl_progress2TrF.setSource(pl_in_Progress);
				 arc_pl_progress2TrF.setCible(tr_Finish);
				 arc_pl_progress2TrF.setKind(ArcKind.NORMAL);
				 arc_pl_progress2TrF.setWeight(1);
			   	 petriNet.getPetriNetElements().add(arc_pl_progress2TrF);

			// l'arc entre la transitions activite_finish et la place activite_Finished
				 arc arc_TrF2pl_F = myFactory.createarc();
				 arc_TrF2pl_F.setSource(tr_Finish);
				 arc_TrF2pl_F.setCible(pl_Finished);
				 arc_TrF2pl_F.setKind(ArcKind.NORMAL);
				 arc_TrF2pl_F.setWeight(1);
  			 petriNet.getPetriNetElements().add(arc_TrF2pl_F);
	
	}
	private static void convertRessource(Ressource R){
		//creation de la place Ressource
		Place pl_ressource = myFactory.createPlace();
		//Nommer la ressource
		pl_ressource.setName(R.getName());
		// initialisation du nombre de jetons
		pl_ressource.setTokens(R.getQuantite());
		// ajouter la place à petriNet
		petriNet.getPetriNetElements().add(pl_ressource);
		
		// les arcs entre la ressource R et WorkDefinition
		for(Allocate A : R.getAllocate()) {
			// ajouter l'arc entre pl_ressource et la transition Start
			arc arc_R2S = myFactory.createarc();
			arc_R2S.setSource(pl_ressource);
			arc_R2S.setCible(registre.get(A.getWorkdefinition()).get(0));
			arc_R2S.setWeight(1);
			arc_R2S.setKind(ArcKind.NORMAL);
			petriNet.getPetriNetElements().add(arc_R2S);
			
			// ajouter l'arc entre pl_ressource et la transition Finish
			arc arc_F2R = myFactory.createarc();
			arc_F2R.setSource(registre.get(A.getWorkdefinition()).get(2));
			arc_F2R.setCible(pl_ressource);
			arc_F2R.setWeight(1);
			arc_F2R.setKind(ArcKind.NORMAL);
			petriNet.getPetriNetElements().add(arc_F2R);
		}
	 	
	}		
	
}




