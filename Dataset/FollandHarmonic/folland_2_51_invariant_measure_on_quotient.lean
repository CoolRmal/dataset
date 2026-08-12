module

public import Dataset.FollandHarmonic.Defs
public import Mathlib.MeasureTheory.Group.ModularCharacter
public import Mathlib.Topology.Algebra.Group.Basic
public import Mathlib.MeasureTheory.Group.ModularCharacter

/-!
# `folland_2_51_invariant_measure_on_quotient`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `folland_2_51_invariant_measure_on_quotient.md`.
Quality rubric: `folland_2_51_invariant_measure_on_quotient.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory Set Topology
open scoped ENNReal NNReal Topology

namespace Dataset
namespace FollandHarmonic

/-- Folland 2.51: the homogeneous space `G/H` carries a `G`-invariant Radon measure exactly when
the modular functions of `G` and `H` agree on `H`, and then Weil's formula holds. -/
theorem folland_2_51_invariant_measure_on_quotient {G : Type*} [Group G]
    [TopologicalSpace G] [IsTopologicalGroup G]
    [LocallyCompactSpace G] [MeasurableSpace G] [BorelSpace G]
    (μ : Measure G) [μ.IsHaarMeasure]
    (H : Subgroup G) (hH : IsClosed (H : Set G)) [LocallyCompactSpace H]
    (ν : Measure H) [ν.IsHaarMeasure]
    [TopologicalSpace (G ⧸ H)] [MeasurableSpace (G ⧸ H)] [BorelSpace (G ⧸ H)] :
    (∃ ρ : Measure (G ⧸ H), ρ ≠ 0 ∧
        (∀ g : G, ρ.map (fun q ↦ g • q) = ρ) ∧
        ∀ f : G → ℂ, Continuous f → HasCompactSupport f →
          ∫ x, f x ∂μ = ∫ q : G ⧸ H, (∫ y : H, f (Quotient.out q * y) ∂ν) ∂ρ) ↔
      ∀ y : H, ((Measure.modularCharacterFun (y : G) : ℝ≥0) : ℝ) =
        ((Measure.modularCharacterFun y : ℝ≥0) : ℝ) := by
  sorry

end FollandHarmonic
end Dataset
