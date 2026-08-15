module

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
# `bogachev_9_1_9_radon_preimage_from_compact_approximation` — 9.1.9

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `bogachev_9_1_9_radon_preimage_from_compact_approximation.md`.
Quality rubric: `bogachev_9_1_9_radon_preimage_from_compact_approximation.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory ProbabilityTheory Set Topology
open scoped BoundedContinuousFunction ENNReal MeasureTheory NNReal ProbabilityTheory Topology

namespace Dataset
namespace Bogachev

/--
Bogachev, *Measure Theory*, Volume II, Theorem 9.1.9:
"Let `f : X → Y` and let `ν` be a Radon signed measure on `Y`. Suppose there is
an increasing sequence of compact sets `Kₙ ⊂ X` such that `f` is continuous on
each `Kₙ` and `limₙ |ν|(f(Kₙ)) = ‖ν‖`. Then there exists a Radon signed measure
`μ` on `X` with `μ ∘ f⁻¹ = ν`, and it can be chosen with `‖μ‖ = ‖ν‖`."
-/
theorem bogachev_9_1_9_radon_preimage_from_compact_approximation
    {X Y : Type*} [TopologicalSpace X] [MeasurableSpace X] [BorelSpace X]
    [TopologicalSpace Y] [MeasurableSpace Y] [BorelSpace Y]
    {f : X → Y} {ν : SignedMeasure Y} (hν : Measure.InnerRegular ν.totalVariation) :
    (∀ K : ℕ → Set X, Monotone K → (∀ n, IsCompact (K n)) → (∀ n, ContinuousOn f (K n)) →
      Tendsto (fun n ↦ ν.totalVariation (f '' K n)) atTop (𝓝 (ν.totalVariation univ)) →
      ∃ μ : SignedMeasure X, Measure.InnerRegular μ.totalVariation ∧
        μ.totalVariation univ = ν.totalVariation univ ∧
          ∀ A : Set Y, MeasurableSet A → ∃ B : Set X, MeasurableSet B ∧
            (∀ᵐ x ∂μ.totalVariation, x ∈ B ↔ x ∈ f ⁻¹' A) ∧ μ B = ν A) ∧
      (CompactSpace X → CompactSpace Y → Continuous f → Function.Surjective f →
        ∃ μ : SignedMeasure X, Measure.InnerRegular μ.totalVariation ∧
          μ.totalVariation univ = ν.totalVariation univ ∧
            ∀ A : Set Y, MeasurableSet A → ∃ B : Set X, MeasurableSet B ∧
              (∀ᵐ x ∂μ.totalVariation, x ∈ B ↔ x ∈ f ⁻¹' A) ∧ μ B = ν A) := by
  sorry

end Bogachev
end Dataset
