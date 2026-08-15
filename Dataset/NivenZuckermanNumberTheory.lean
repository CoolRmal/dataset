module

public import Dataset.NivenZuckermanNumberTheory.Defs
public import Dataset.NivenZuckermanNumberTheory.niven_zuckerman_10_14_euler_product_prime_power
public import Dataset.NivenZuckermanNumberTheory.niven_zuckerman_10_15_mod_five_coefficients
public import Dataset.NivenZuckermanNumberTheory.niven_zuckerman_10_16_ramanujan_congruence
public import Dataset.NivenZuckermanNumberTheory.niven_zuckerman_11_2_divisor_bound
public import Dataset.NivenZuckermanNumberTheory.niven_zuckerman_11_3_moebius_zeta_product
public import Dataset.NivenZuckermanNumberTheory.niven_zuckerman_11_4_moebius_sum_eq_six_div_pi_sq
public import Dataset.NivenZuckermanNumberTheory.niven_zuckerman_11_5_squarefree_density
public import Dataset.NivenZuckermanNumberTheory.niven_zuckerman_11_6_divergent_product_tendsto_zero
public import Dataset.NivenZuckermanNumberTheory.niven_zuckerman_11_8_few_prime_factors_density_zero
public import Dataset.NivenZuckermanNumberTheory.niven_zuckerman_11_mann_alpha_beta_theorem

/-!
# Hard number-theory statements from Niven and Zuckerman

Ten statement-only formalizations selected from I. Niven and H. S. Zuckerman,
*An Introduction to the Theory of Numbers*, Third Edition.

Each problem lives in `Dataset/NivenZuckermanNumberTheory/<declaration_name>.lean`,
accompanied by `<declaration_name>.md` (the natural-language statement from
the textbook) and `<declaration_name>.criteria.md` (a quality rubric for
judging formalizations of that statement).
Custom notions shared between problems are in `Dataset/NivenZuckermanNumberTheory/Defs.lean`.
-/
