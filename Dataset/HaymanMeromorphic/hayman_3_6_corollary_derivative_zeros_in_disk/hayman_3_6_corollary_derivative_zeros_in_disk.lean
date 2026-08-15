import Dataset.HaymanMeromorphic.Defs

/-!
# `hayman_3_6_corollary_derivative_zeros_in_disk`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `hayman_3_6_corollary_derivative_zeros_in_disk.md`.
Quality rubric: `hayman_3_6_corollary_derivative_zeros_in_disk.criteria.md`.
-/

open Filter MeasureTheory Set ValueDistribution
open scoped Topology

namespace Dataset
namespace HaymanMeromorphic

/-- Hayman, Corollary to 3.6: for all sufficiently large `l`, `f^{(l)}` has a zero in every disk
in which `f` is meromorphic and has at least two distinct poles. -/
theorem hayman_3_6_corollary_derivative_zeros_in_disk :
    ∀ᶠ l in atTop, ∀ (f : ℂ → ℂ) (z₀ : ℂ) (R : ℝ), 0 < R →
      (∀ z ∈ Metric.ball z₀ R, MeromorphicAt f z) →
      (∃ p ∈ Metric.ball z₀ R, ∃ q ∈ Metric.ball z₀ R, p ≠ q ∧
        meromorphicOrderAt f p < 0 ∧ meromorphicOrderAt f q < 0) →
      ∃ z ∈ Metric.ball z₀ R, iteratedDeriv l f z = 0 := by
  sorry

end HaymanMeromorphic
end Dataset
