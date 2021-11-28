(* Ouverture d’une section *)
Section CalculPredicats.
(* Définition de 2 domaines pour les prédicats *)
Variable A B : Type.

(* Formule du second ordre : Quantification des prédicats phi et psi *)
Theorem Thm_8 : forall (P Q : A -> Prop),
(forall x1 : A, (P x1) /\ (Q x1))
-> (forall x2 : A, (P x2)) /\ (forall x3 : A, (Q x3)).
intros.
split.
apply H.
intros.
apply H.
Qed.
(* Formule du second ordre : Quantification du prédicat phi *)
Theorem Thm_9 : forall (P : A -> B -> Prop),
(exists x1 : A, forall y1 : B, (P x1 y1))
->  forall y2 : B, exists x2 : A, (P x2 y2).
intros.
destruct H.
exists x.
apply H.
Qed.
Theorem Thm10: forall (P Q : A -> Prop),
(exists x : A, (P x) -> (Q x))
-> (forall x : A, (P x)) -> exists x : A, (Q x).
intros.
destruct H.
exists x.
apply H.
apply H0.
Qed.
End CalculPredicats.
