module

public import Dataset.KrylovSobolev.Defs
public import Dataset.KrylovSobolev.krylov_sobolev_1_1_1_energy_identity
public import Dataset.KrylovSobolev.krylov_sobolev_1_1_3_hessian_determinant_integral
public import Dataset.KrylovSobolev.krylov_sobolev_1_1_7_whole_space_maximum_principle
public import Dataset.KrylovSobolev.krylov_sobolev_1_5_1_multiplicative_inequality
public import Dataset.KrylovSobolev.krylov_sobolev_3_2_10_fefferman_stein
public import Dataset.KrylovSobolev.krylov_sobolev_10_2_1_morrey_embedding
public import Dataset.KrylovSobolev.krylov_sobolev_10_3_2_gagliardo_nirenberg
public import Dataset.KrylovSobolev.krylov_sobolev_10_5_1_kondrashov_compactness
public import Dataset.KrylovSobolev.krylov_sobolev_11_1_3_maximum_principle
public import Dataset.KrylovSobolev.krylov_sobolev_12_9_12_bessel_kernel

/-!
# Hard Sobolev-space and elliptic-equation statements from Krylov

Ten statement-only formalizations selected from N. V. Krylov,
*Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*.

Each problem lives in `Dataset/KrylovSobolev/<declaration_name>.lean`,
accompanied by `<declaration_name>.md` (the natural-language statement from
the textbook) and `<declaration_name>.criteria.md` (a quality rubric for
judging formalizations of that statement).
Custom notions shared between problems are in `Dataset/KrylovSobolev/Defs.lean`.
-/
