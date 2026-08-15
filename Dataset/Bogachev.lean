module

public import Dataset.Bogachev.Defs
public import Dataset.Bogachev.hasLusinPropertyN_iff_maps_nullMeasurableSet.hasLusinPropertyN_iff_maps_nullMeasurableSet
public import Dataset.Bogachev.proposition_5_5_4.proposition_5_5_4
public import Dataset.Bogachev.hardy_average_and_tail_memLp.hardy_average_and_tail_memLp
public import Dataset.Bogachev.bogachev_8_6_2_prokhorov_signed_measures.bogachev_8_6_2_prokhorov_signed_measures
public import Dataset.Bogachev.bogachev_3_7_1_change_of_variables_in_Rn.bogachev_3_7_1_change_of_variables_in_Rn
public import Dataset.Bogachev.bogachev_4_5_9_de_la_vallee_poussin.bogachev_4_5_9_de_la_vallee_poussin
public import Dataset.Bogachev.bogachev_4_6_3_nikodym_vitali_hahn_saks.bogachev_4_6_3_nikodym_vitali_hahn_saks
public import Dataset.Bogachev.bogachev_9_12_37_simultaneous_transport.bogachev_9_12_37_simultaneous_transport
public import Dataset.Bogachev.bogachev_10_5_4_lifting.bogachev_10_5_4_lifting
public import Dataset.Bogachev.bogachev_9_1_9_radon_preimage_from_compact_approximation.bogachev_9_1_9_radon_preimage_from_compact_approximation

/-!
# Hard measure-theory statement dataset

This file contains ten statement-only formalizations selected from V. I. Bogachev,
*Measure Theory*, Volumes I-II. They were chosen as difficult autoformalization
targets because the theorem statements themselves have substantial mathematical
structure: Lusin's property, differentiability and image measure, Hardy inequalities,
Prokhorov compactness, change of variables, uniform integrability, uniform countable
additivity, simultaneous transport, liftings, and Radon preimages.

Each problem lives in `Dataset/Bogachev/<declaration_name>.lean`,
accompanied by `<declaration_name>.md` (the natural-language statement from
the textbook) and `<declaration_name>.criteria.md` (a quality rubric for
judging formalizations of that statement).
Custom notions shared between problems are in `Dataset/Bogachev/Defs.lean`.
-/
