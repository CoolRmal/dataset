import Dataset.NikolskiOperators.Defs
import Dataset.NikolskiOperators.nikolski_A_1_3_beurling_invariant_subspaces.nikolski_A_1_3_beurling_invariant_subspaces
import Dataset.NikolskiOperators.nikolski_A_2_4_inner_outer_factorization.nikolski_A_2_4_inner_outer_factorization
import Dataset.NikolskiOperators.nikolski_A_3_6_boundary_uniqueness.nikolski_A_3_6_boundary_uniqueness
import Dataset.NikolskiOperators.nikolski_A_3_7_blaschke_zero_sets.nikolski_A_3_7_blaschke_zero_sets
import Dataset.NikolskiOperators.nikolski_A_5_4_helson_szego.nikolski_A_5_4_helson_szego
import Dataset.NikolskiOperators.nikolski_B_1_3_nehari_theorem.nikolski_B_1_3_nehari_theorem
import Dataset.NikolskiOperators.nikolski_B_2_2_hartman_compact_hankel.nikolski_B_2_2_hartman_compact_hankel
import Dataset.NikolskiOperators.nikolski_B_3_2_nevanlinna_pick_interpolation.nikolski_B_3_2_nevanlinna_pick_interpolation
import Dataset.NikolskiOperators.nikolski_B_4_3_3_devinatz_widom.nikolski_B_4_3_3_devinatz_widom
import Dataset.NikolskiOperators.nikolski_B_7_2_1_adamyan_arov_krein.nikolski_B_7_2_1_adamyan_arov_krein

/-!
# Hard Hardy/Hankel/Toeplitz statement dataset

This file contains ten statement-only formalizations selected from Nikolai K.
Nikol'ski, *Operators, Functions, and Systems: An Easy Reading*, Volume 1,
*Hardy, Hankel, and Toeplitz*. They are chosen as hard autoformalization targets
because the statements mix Hardy-space boundary behavior, factorization,
interpolation matrices, Hankel and Toeplitz symbols, singular numbers, and
meromorphic approximation.

Each problem lives in `Dataset/NikolskiOperators/<declaration_name>.lean`,
accompanied by `<declaration_name>.md` (the natural-language statement from
the textbook) and `<declaration_name>.criteria.md` (a quality rubric for
judging formalizations of that statement).
Custom notions shared between problems are in `Dataset/NikolskiOperators/Defs.lean`.
-/
