module

public import Dataset.KrylovSobolev.Defs

/-!
# `krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement:
`krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership.md`.
Quality rubric:
`krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Set TemperedDistribution Topology
open scoped ContDiff ENNReal Laplacian NNReal SchwartzMap Topology

namespace Dataset
namespace KrylovSobolev

/-- Coercing an `𝓛¹` function to a tempered distribution needs `Fact (1 ≤ (1 : ℝ≥0∞))`. -/
local instance factOneLeOne : Fact (1 ≤ (1 : ℝ≥0∞)) := ⟨le_rfl⟩

/-- Krylov Exercise 13.3.16: a function supported in `B_ρ` and obeying `|u(x)| ≤ N₀|x|^{-ν}` with
`ν < d`, `0 < (ν + γ)p < d` and `γ < 0` lies in `H_p^γ`, with `‖u‖_{H_p^γ}` bounded by a constant
depending only on `d, p, ρ, ν, γ, N₀`; and, more generally, if `|D^αu(x)| ≤ N₀|x|^{-ν}` for all
`|α| ≤ n` and either `γ < n` with `0 < (ν + γ - n)p < d` or `γ = n` with `νp < d`, then again
`u ∈ H_p^γ` with `‖u‖_{H_p^γ}` bounded in terms of `d, p, ρ, ν, γ, n, N₀` alone. -/
theorem krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership (d : ℕ)
    (p : ℝ≥0∞) [Fact (1 ≤ p)] (hp₁ : 1 < p) (hp₂ : p ≠ ⊤) :
    (∀ ρ ν γ N₀ : ℝ, 0 < ρ → ν < d → γ < 0 → 0 < (ν + γ) * p.toReal → (ν + γ) * p.toReal < d →
        ∃ C : ℝ≥0∞, C ≠ ⊤ ∧ ∀ u : EuclideanSpace ℝ (Fin d) → ℂ, AEStronglyMeasurable u volume →
          support u ⊆ Metric.ball 0 ρ → (∀ x ≠ 0, ‖u x‖ ≤ N₀ * ‖x‖ ^ (-ν)) →
          ∃ U : Lp ℂ 1 (volume : Measure (EuclideanSpace ℝ (Fin d))), u =ᵐ[volume] ⇑U ∧
            MemSobolev γ p (U : 𝓢'(EuclideanSpace ℝ (Fin d), ℂ)) ∧
              sobolevNorm γ p (U : 𝓢'(EuclideanSpace ℝ (Fin d), ℂ)) ≤ C) ∧
      ∀ (n : ℕ) (ρ ν γ N₀ : ℝ), 0 < ρ → ν < d → γ ≤ n →
        ((γ < n ∧ 0 < (ν + γ - n) * p.toReal ∧ (ν + γ - n) * p.toReal < d) ∨
          (γ = n ∧ ν * p.toReal < d)) →
        ∃ C : ℝ≥0∞, C ≠ ⊤ ∧ ∀ u : EuclideanSpace ℝ (Fin d) → ℂ, ContDiff ℝ n u →
          support u ⊆ Metric.ball 0 ρ →
          (∀ α : Fin d → ℕ, (∑ i, α i) ≤ n → ∀ x ≠ 0, ‖multiDeriv α u x‖ ≤ N₀ * ‖x‖ ^ (-ν)) →
          ∃ U : Lp ℂ 1 (volume : Measure (EuclideanSpace ℝ (Fin d))), u =ᵐ[volume] ⇑U ∧
            MemSobolev γ p (U : 𝓢'(EuclideanSpace ℝ (Fin d), ℂ)) ∧
              sobolevNorm γ p (U : 𝓢'(EuclideanSpace ℝ (Fin d), ℂ)) ≤ C := by
  sorry

end KrylovSobolev
end Dataset
