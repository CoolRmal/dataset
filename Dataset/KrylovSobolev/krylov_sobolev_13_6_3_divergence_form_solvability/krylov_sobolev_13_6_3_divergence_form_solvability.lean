import Dataset.KrylovSobolev.Defs

/-!
# `krylov_sobolev_13_6_3_divergence_form_solvability`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_sobolev_13_6_3_divergence_form_solvability.md`.
Quality rubric: `krylov_sobolev_13_6_3_divergence_form_solvability.criteria.md`.
-/

open Filter Function MeasureTheory Set Topology
open scoped ContDiff ENNReal Laplacian NNReal SchwartzMap Topology

namespace Dataset
namespace KrylovSobolev

/-- Krylov Theorem 13.6.3: for `Lu = D_i(a^{ij}D_ju + a^iu) + b^iD_iu + cu` with real bounded
measurable coefficients, uniformly elliptic with constant `κ` and with `a^{ij}` of modulus of
continuity `w`, there is a `λ₀ > 0` depending on `d, p, κ, w, K` such that for `λ ≥ λ₀` and
`f¹, …, f^d, g ∈ 𝓛_p` the equation `Lu - λu = D_if^i + g` has a unique solution `u ∈ W_p^1`, and
that solution obeys `√λ‖u‖ + ‖Du‖ ≤ N(‖g‖/√λ + ∑ᵢ‖f^i‖)` with `N` depending only on
`d, p, κ, K` — in particular not on `w`. -/
theorem krylov_sobolev_13_6_3_divergence_form_solvability {d : ℕ} (hd : 0 < d) (p : ℝ≥0∞)
    [Fact (1 ≤ p)] (hp₁ : 1 < p) (hp₂ : p ≠ ⊤) (κ K : ℝ) (hκ : 0 < κ) :
    ∃ N : ℝ, ∀ w : ℝ → ℝ, Tendsto w (𝓝[>] (0 : ℝ)) (𝓝 0) → ∃ lam₀ : ℝ, 0 < lam₀ ∧
      ∀ (a : Fin d → Fin d → EuclideanSpace ℝ (Fin d) → ℝ)
        (a' b : Fin d → EuclideanSpace ℝ (Fin d) → ℝ) (c : EuclideanSpace ℝ (Fin d) → ℝ),
        (∀ i j, Measurable (a i j)) → (∀ i, Measurable (a' i)) → (∀ i, Measurable (b i)) →
        Measurable c → (∀ i j x, |a i j x| ≤ K) → (∀ i x, |a' i x| ≤ K) →
        (∀ i x, |b i x| ≤ K) → (∀ x, |c x| ≤ K) →
        (∀ x ξ : EuclideanSpace ℝ (Fin d), κ * ‖ξ‖ ^ 2 ≤ ∑ r, ∑ k, a r k x * ξ r * ξ k) →
        (∀ ε : ℝ, 0 < ε → ∀ (i j : Fin d) (x y : EuclideanSpace ℝ (Fin d)), dist x y ≤ ε →
          |a i j x - a i j y| ≤ w ε) →
        ∀ lam : ℝ, lam₀ ≤ lam →
        ∀ (f : Fin d → Lp ℝ p (volume : Measure (EuclideanSpace ℝ (Fin d))))
          (g : Lp ℝ p (volume : Measure (EuclideanSpace ℝ (Fin d)))),
          (∃! u : Lp ℝ p (volume : Measure (EuclideanSpace ℝ (Fin d))),
            ∃ v : Fin d → Lp ℝ p (volume : Measure (EuclideanSpace ℝ (Fin d))),
              IsDivergenceFormSolution a a' b c lam (fun i ↦ ⇑(f i)) g u fun j ↦ ⇑(v j)) ∧
          ∀ (u : Lp ℝ p (volume : Measure (EuclideanSpace ℝ (Fin d))))
            (v : Fin d → Lp ℝ p (volume : Measure (EuclideanSpace ℝ (Fin d)))),
            IsDivergenceFormSolution a a' b c lam (fun i ↦ ⇑(f i)) g u (fun j ↦ ⇑(v j)) →
            Real.sqrt lam * ‖u‖ + (∑ j, ‖v j‖) ≤
              N * ((Real.sqrt lam)⁻¹ * ‖g‖ + ∑ i, ‖f i‖) := by
  sorry

end KrylovSobolev
end Dataset
