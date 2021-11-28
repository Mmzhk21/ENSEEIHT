(* Les règles de la déduction naturelle doivent être ajoutées à Coq. *)
Require Import Naturelle.
(* Ouverture d’une section *)
Section CalculPropositionnel.
(* Déclaration de variables propositionnelles *)
Variable A B C E Y R : Prop.
 
Theorem Thm0 :  A /\ B -> B /\ A.
I_imp H.
I_et.
E_et_d A.
Hyp H.
E_et_g B.
Hyp H.
Qed.
Theorem Thm_1 : ((A \/ B) -> C) -> (B -> C).
I_imp H.
E_ou A (B->C).
I_ou_d .
I_imp H1.
E_ou A B .
I_ou_d.
Hyp H1.
I_imp H2.
E_imp (A \/ B).
Hyp H.
I_ou_g.
Hyp H2.
E_imp B.
I_imp H3.
I_imp H4.
E_imp (A \/ B).
Hyp H.
I_ou_d.
Hyp H1.
Hyp H1.
I_imp H5.
I_imp H6.
E_imp (A\/B).
Hyp H.
I_ou_g.
Hyp H5.
I_imp H7.
I_imp H8.
E_imp B.
Hyp H7.
Hyp H8.
Qed.
Theorem Thm_2 : A -> ~~A.
I_imp H.
I_non H1.
I_antiT A.
Hyp H.
Hyp H1.
Qed.
Theorem Thm_3 : (A -> B) -> (~B -> ~A).
I_imp H.
I_imp H1.
I_non H2.
I_antiT B.
E_imp A.
Hyp H.
Hyp H2.
Hyp H1.
Qed.
Theorem Thm_4 : ~~A -> A.
I_imp H.
absurde H1.
E_non (~ A).
Hyp H1.
Hyp H.
Qed.
Theorem Thm_5 : (~B -> ~A) -> (A -> B).
I_imp H.
I_imp H1.
absurde H2.
I_antiT A.
Hyp H1.
E_imp (~B).
Hyp H.
Hyp H2.
Qed.
Theorem Thm_6 : ((E -> (Y \/ R)) /\ (Y -> R)) -> (~R -> ~E).
I_imp H.
I_imp H1.
I_non H2.
E_non R.
2: Hyp H1.
E_ou Y R.
E_imp E.
E_et_g (Y -> R).
Hyp H.
Hyp H2.
I_imp H4.
E_imp Y.
E_et_d (E -> Y \/ R).
Hyp H.
Hyp H4.
I_imp H6.
Hyp H6.
Qed.
Theorem Thm00 : A /\ B -> B /\ A.
intro H.    (* introduction implication *)
destruct H as (HA,HB).  (* élimination conjonction *)
split.                  (* introduction conjonction *)
exact HB.               (* hypothèse *)
exact HA.               (* hypothèse *)
Qed.
Theorem Coq_E_imp : ((A -> B) /\ A) -> B.
intro H.
destruct H as (H1,H2).
cut A.
exact H1.
exact H2.
Qed.
Theorem Coq_E_et_g : (A /\ B) -> A.
intro H.
cut (A /\ B).
intro H1.
elim H1.
intros HA HB.
exact HA.
exact H.
Qed.



End CalculPropositionnel.




