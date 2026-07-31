module

public import Dataset.KongODE.Defs
public import Dataset.KongODE.kong_1_3_3_nth_order_scalar_ivp
public import Dataset.KongODE.kong_1_5_3_differentiable_dependence
public import Dataset.KongODE.kong_2_3_1_variation_of_parameters
public import Dataset.KongODE.kong_2_5_3_floquet_theorem
public import Dataset.KongODE.kong_3_2_3_characteristic_multiplier_stability
public import Dataset.KongODE.kong_3_4_2_integrable_perturbation_stability
public import Dataset.KongODE.kong_3_5_2_lasalle_invariance_stability
public import Dataset.KongODE.kong_4_5_3_generalized_poincare_bendixson
public import Dataset.KongODE.kong_5_4_2_hopf_friedrich_dichotomy
public import Dataset.KongODE.kong_6_6_4_periodic_sturm_liouville_coupling

/-!
# Hard ordinary-differential-equation statements from Kong

Ten statement-only formalizations selected from Qingkai Kong,
*A Short Course in Ordinary Differential Equations*.

Each problem lives in `Dataset/KongODE/<declaration_name>.lean`,
accompanied by `<declaration_name>.md` (the natural-language statement from
the textbook) and `<declaration_name>.criteria.md` (a quality rubric for
judging formalizations of that statement).
Custom notions shared between problems are in `Dataset/KongODE/Defs.lean`.
-/
