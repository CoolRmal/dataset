import Dataset.KrylovHolder.Defs

/-!
# `krylov_6_5_3_smooth_domain_dirichlet_solvability`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_6_5_3_smooth_domain_dirichlet_solvability.md`.
Quality rubric: `krylov_6_5_3_smooth_domain_dirichlet_solvability.criteria.md`.
-/

namespace Dataset
namespace KrylovHolder

/-- Krylov 6.5.3, the Holder Dirichlet problem on a `C^{k+2+δ}` domain. -/
theorem krylov_6_5_3_smooth_domain_dirichlet_solvability
    {d k : ℕ} {δ κ K : ℝ} {Ω : Set (EuclideanSpace ℝ (Fin d))}
    {a : EuclideanSpace ℝ (Fin d) → Fin d → Fin d → ℝ}
    {b : EuclideanSpace ℝ (Fin d) → Fin d → ℝ} {c : EuclideanSpace ℝ (Fin d) → ℝ}
    (hδ : 0 < δ ∧ δ < 1) (hκ : 0 < κ) (hΩ : IsDomainOfClass (k + 2) δ Ω)
    (hsym : ∀ x i j, a x i j = a x j i)
    (hell : ∀ x ξ : EuclideanSpace ℝ (Fin d),
      κ * ‖ξ‖ ^ 2 ≤ ∑ i, ∑ j, a x i j * ξ i * ξ j)
    (hc : ∀ x, c x ≤ 0)
    (haK : ∀ i j, krylovHolderNorm k δ Set.univ (fun x ↦ a x i j) ≤ ENNReal.ofReal K)
    (hbK : ∀ i, krylovHolderNorm k δ Set.univ (fun x ↦ b x i) ≤ ENNReal.ofReal K)
    (hcK : krylovHolderNorm k δ Set.univ c ≤ ENNReal.ofReal K) :
    ∀ f g, HolderOn (k + δ) Ω f → HolderOn (k + 2 + δ) (closure Ω) g →
      ∃ u, HolderOn (k + 2 + δ) (closure Ω) u ∧
        (∀ x ∈ Ω, secondOrderOperator a b c u x = f x) ∧
        (∀ x ∈ frontier Ω, u x = g x) ∧
        ∀ v, HolderOn (k + 2 + δ) (closure Ω) v →
          (∀ x ∈ Ω, secondOrderOperator a b c v x = f x) →
          (∀ x ∈ frontier Ω, v x = g x) → Set.EqOn v u (closure Ω) := by
  sorry

end KrylovHolder
end Dataset
