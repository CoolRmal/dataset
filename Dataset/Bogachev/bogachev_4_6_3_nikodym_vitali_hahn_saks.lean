module

public import Dataset.Bogachev.Defs
public import Mathlib.Analysis.Calculus.ContDiff.Basic
public import Mathlib.Analysis.Convex.Function
public import Mathlib.Analysis.Normed.Module.FiniteDimension
public import Mathlib.MeasureTheory.Constructions.Polish.Basic
public import Mathlib.MeasureTheory.Function.UniformIntegrable
public import Mathlib.MeasureTheory.Integral.Prod
public import Mathlib.MeasureTheory.Measure.NullMeasurable
public import Mathlib.MeasureTheory.Measure.ProbabilityMeasure
public import Mathlib.MeasureTheory.Measure.Regular
public import Mathlib.MeasureTheory.Measure.Tight
public import Mathlib.MeasureTheory.VectorMeasure.Basic
public import Mathlib.MeasureTheory.VectorMeasure.Decomposition.Jordan

/-!
# `bogachev_4_6_3_nikodym_vitali_hahn_saks` — 4.6.3

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `bogachev_4_6_3_nikodym_vitali_hahn_saks.md`.
Quality rubric: `bogachev_4_6_3_nikodym_vitali_hahn_saks.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory ProbabilityTheory Set Topology
open scoped BoundedContinuousFunction ENNReal MeasureTheory NNReal ProbabilityTheory Topology

namespace Dataset
namespace Bogachev

/--
Bogachev, *Measure Theory*, Volume I, Theorem 4.6.3:
"Let a sequence of real measures `μₙ` be such that `limₙ μₙ(A)` exists and is
finite for every measurable set `A`. Then the pointwise limit is a measure.
Moreover, there are a finite nonnegative measure `ν` and a bounded nondecreasing
nonnegative function `α`, tending to zero at zero, such that
`|μₙ(A)| ≤ α(ν(A))` for all `n` and measurable `A`. In particular, the sequence
is uniformly bounded in total variation and uniformly countably additive. If
all `μₙ` are absolutely continuous with respect to a fixed finite nonnegative
measure, their absolute continuity is uniform."
-/
theorem bogachev_4_6_3_nikodym_vitali_hahn_saks
    {Ω : Type*} [MeasurableSpace Ω] {s : ℕ → SignedMeasure Ω}
    (hlim : ∀ A : Set Ω, MeasurableSet A →
      ∃ l : ℝ, Tendsto (fun n : ℕ ↦ s n A) atTop (𝓝 l)) :
    ∃ sLim : SignedMeasure Ω,
      (∀ A : Set Ω, MeasurableSet A →
        Tendsto (fun n : ℕ ↦ s n A) atTop (𝓝 (sLim A))) ∧
        (∃ ν : FiniteMeasure Ω, ∃ α : ℝ≥0 → ℝ≥0,
          Monotone α ∧
            (∃ C : ℝ≥0, ∀ t : ℝ≥0, α t ≤ C) ∧
              Tendsto α (𝓝 0) (𝓝 0) ∧
                ∀ n : ℕ, ∀ A : Set Ω, MeasurableSet A → |s n A| ≤ (α (ν A) : ℝ)) ∧
          UniformlyBoundedInTotalVariation (range s) ∧
            UniformlyCountablyAdditive (range s) ∧
              ∀ lam : FiniteMeasure Ω,
                (∀ n : ℕ, s n ≪ᵥ (lam : Measure Ω).toENNRealVectorMeasure) →
                  UniformlyAbsolutelyContinuous (range s) (lam : Measure Ω) := by
  sorry

end Bogachev
end Dataset
