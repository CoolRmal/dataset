module

public import Dataset.FollandHarmonic.Defs
public import Dataset.FollandHarmonic.folland_2_31_modular_inversion_formula
public import Dataset.FollandHarmonic.folland_2_45_closed_ideals_are_translation_invariant
public import Dataset.FollandHarmonic.folland_2_51_invariant_measure_on_quotient
public import Dataset.FollandHarmonic.folland_2_69_convolution_factorization
public import Dataset.FollandHarmonic.folland_4_43_subgroup_fourier_formula
public import Dataset.FollandHarmonic.folland_4_52_hull_of_kernel
public import Dataset.FollandHarmonic.folland_4_54_spectral_synthesis_compact
public import Dataset.FollandHarmonic.folland_4_55_schwartz_synthesis_failure
public import Dataset.FollandHarmonic.folland_4_67_synthesis_from_thin_boundary
public import Dataset.FollandHarmonic.folland_4_81_almost_periodic_characterization

/-!
# Hard abstract-harmonic-analysis statements from Folland

Ten statement-only formalizations selected from G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition.

Each problem lives in `Dataset/FollandHarmonic/<declaration_name>.lean`,
accompanied by `<declaration_name>.md` (the natural-language statement from
the textbook) and `<declaration_name>.criteria.md` (a quality rubric for
judging formalizations of that statement).
Custom notions shared between problems are in `Dataset/FollandHarmonic/Defs.lean`.
-/
