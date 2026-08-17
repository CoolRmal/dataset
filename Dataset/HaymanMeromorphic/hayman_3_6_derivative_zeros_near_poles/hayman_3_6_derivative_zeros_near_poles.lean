import Dataset.HaymanMeromorphic.Defs

/-!
# `hayman_3_6_derivative_zeros_near_poles`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `hayman_3_6_derivative_zeros_near_poles.md`.
Quality rubric: `hayman_3_6_derivative_zeros_near_poles.criteria.md`.
-/

open Filter
open scoped Topology

namespace Dataset
namespace HaymanMeromorphic

/-- Hayman 3.6: if `f` is meromorphic in a disk with at least two distinct poles and `r` is the
radius of the largest pole-free circle about the centre, then high derivatives of `f` either
have zeros arbitrarily close to that circle or blow up uniformly near it. -/
theorem hayman_3_6_derivative_zeros_near_poles (f : ℂ → ℂ) (z₀ : ℂ) (R : ℝ) (hR : 0 < R)
    (hf : ∀ z ∈ Metric.ball z₀ R, MeromorphicAt f z)
    (P : Set ℂ) (hP : P = {z ∈ Metric.ball z₀ R | meromorphicOrderAt f z < 0})
    (hfa : ∀ z ∈ Metric.ball z₀ R, z ∉ P → AnalyticAt ℂ f z)
    (htwo : ∃ p ∈ P, ∃ q ∈ P, p ≠ q) (r : ℝ)
    (hrmax : IsGreatest {t : ℝ | 0 < t ∧ ∀ z ∈ P, ¬ ‖z - z₀‖ < t} r) :
    ((∃ p ∈ P, ∃ q ∈ P, p ≠ q ∧ ‖p - z₀‖ = r ∧ ‖q - z₀‖ = r) →
        ∀ δ : ℝ, 0 < δ → ∀ᶠ l in atTop,
          ∃ z ∈ Metric.ball z₀ δ, 0 < meromorphicOrderAt (iteratedDeriv l f) z) ∧
      ((∃! p, p ∈ P ∧ ‖p - z₀‖ = r) → ∀ᶠ δ in 𝓝[>] (0 : ℝ),
        Tendsto (fun l ↦ ⨅ z : Metric.closedBall z₀ δ, ‖iteratedDeriv l f z‖) atTop atTop) := by
  sorry

end HaymanMeromorphic
end Dataset
