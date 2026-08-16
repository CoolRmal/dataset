import Dataset.KrylovSobolev.Defs

/-!
# `krylov_sobolev_13_3_13_negative_order_divergence_decomposition`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_sobolev_13_3_13_negative_order_divergence_decomposition.md`.
Quality rubric: `krylov_sobolev_13_3_13_negative_order_divergence_decomposition.criteria.md`.
-/

open MeasureTheory TemperedDistribution
open scoped ENNReal LineDeriv NNReal SchwartzMap

namespace Dataset
namespace KrylovSobolev

/-- Krylov Exercise 13.3.13: for `p ∈ (1, ∞)` every `g ∈ H_p^{-1}` on `ℝ^d` can be written as
`g = f₀ + ∑_j D_j f_j` with `f₀, …, f_d ∈ L_p` and `∑_j ‖f_j‖_{L_p} ≤ N‖g‖_{H_p^{-1}}`, and
conversely any such `g` lies in `H_p^{-1}` with `‖g‖_{H_p^{-1}} ≤ N ∑_j ‖f_j‖_{L_p}`. -/
theorem krylov_sobolev_13_3_13_negative_order_divergence_decomposition {d : ℕ} (p : ℝ≥0∞)
    [Fact (1 ≤ p)] (hp₁ : 1 < p) (hp₂ : p ≠ ⊤) :
    ∃ N : ℝ≥0,
      (∀ g : 𝓢'(EuclideanSpace ℝ (Fin d), ℂ), MemSobolev (-1) p g →
          ∃ f : Fin (d + 1) → Lp ℂ p (volume : Measure (EuclideanSpace ℝ (Fin d))),
            (g = (f 0 : 𝓢'(EuclideanSpace ℝ (Fin d), ℂ)) +
                (∑ j : Fin d, ∂_{EuclideanSpace.single j (1 : ℝ)}
                  (f j.succ : 𝓢'(EuclideanSpace ℝ (Fin d), ℂ)))) ∧
              (∑ j, ‖f j‖ₑ) ≤ N * sobolevNorm (-1) p g) ∧
        ∀ (g : 𝓢'(EuclideanSpace ℝ (Fin d), ℂ))
            (f : Fin (d + 1) → Lp ℂ p (volume : Measure (EuclideanSpace ℝ (Fin d)))),
            g = (f 0 : 𝓢'(EuclideanSpace ℝ (Fin d), ℂ)) +
                (∑ j : Fin d, ∂_{EuclideanSpace.single j (1 : ℝ)}
                  (f j.succ : 𝓢'(EuclideanSpace ℝ (Fin d), ℂ))) →
              MemSobolev (-1) p g ∧ sobolevNorm (-1) p g ≤ N * (∑ j, ‖f j‖ₑ) := by
  sorry

end KrylovSobolev
end Dataset
