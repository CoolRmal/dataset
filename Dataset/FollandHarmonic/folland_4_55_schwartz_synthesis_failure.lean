module

public import Dataset.FollandHarmonic.Defs
public import Mathlib.Analysis.Fourier.FourierTransform
public import Mathlib.Analysis.InnerProductSpace.PiL2
public import Mathlib.MeasureTheory.Measure.Haar.InnerProductSpace

/-!
# `folland_4_55_schwartz_synthesis_failure`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `folland_4_55_schwartz_synthesis_failure.md`.
Quality rubric: `folland_4_55_schwartz_synthesis_failure.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory Set Topology
open scoped ENNReal FourierTransform NNReal Topology

namespace Dataset
namespace FollandHarmonic

/-- Folland 4.55, Schwartz's example: for `n ≥ 3` the unit sphere in `ℝⁿ` is not a set of
spectral synthesis — some closed ideal of `𝓛¹(ℝⁿ)` has the sphere as its hull yet is strictly
smaller than the kernel of the sphere. -/
theorem folland_4_55_schwartz_synthesis_failure {n : ℕ} (hn : 3 ≤ n) :
    ∃ I : Submodule ℂ (EuclideanSpace ℝ (Fin n) → ℂ),
      IsLpClosed 1 volume (I : Set (EuclideanSpace ℝ (Fin n) → ℂ)) ∧
        (∀ f ∈ I, Integrable f volume) ∧
        (∀ (y : EuclideanSpace ℝ (Fin n)), ∀ f ∈ I, (fun x ↦ f (x - y)) ∈ I) ∧
        {ξ : EuclideanSpace ℝ (Fin n) | ∀ f ∈ I, 𝓕 f ξ = 0} =
          Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1 ∧
        (I : Set (EuclideanSpace ℝ (Fin n) → ℂ)) ≠
          {f : EuclideanSpace ℝ (Fin n) → ℂ | Integrable f volume ∧
          ∀ ξ ∈ Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1, 𝓕 f ξ = 0} := by
  sorry

end FollandHarmonic
end Dataset
