import Dataset.KrylovHolder.Defs

/-!
# `krylov_10_3_3_parabolic_dirichlet_domain_solvability`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_10_3_3_parabolic_dirichlet_domain_solvability.md`.
Quality rubric: `krylov_10_3_3_parabolic_dirichlet_domain_solvability.criteria.md`.
-/

namespace Dataset
namespace KrylovHolder

/-- Krylov 10.3.3, the parabolic Dirichlet problem in an infinite smooth cylinder. -/
theorem krylov_10_3_3_parabolic_dirichlet_domain_solvability
    {d : ℕ} {δ κ : ℝ} (T : WithTop ℝ) {Ω : Set (EuclideanSpace ℝ (Fin d))}
    {a : (ℝ × EuclideanSpace ℝ (Fin d)) → Fin d → Fin d → ℝ}
    {b : (ℝ × EuclideanSpace ℝ (Fin d)) → Fin d → ℝ}
    {c : (ℝ × EuclideanSpace ℝ (Fin d)) → ℝ}
    (hδ : 0 < δ ∧ δ < 1) (hκ : 0 < κ) (hΩ : IsDomainOfClass 2 δ Ω)
    (hsym : ∀ p i j, a p i j = a p j i)
    (hell : ∀ p (ξ : EuclideanSpace ℝ (Fin d)),
      κ * ‖ξ‖ ^ 2 ≤ ∑ i, ∑ j, a p i j * ξ i * ξ j)
    (hc : ∀ p, c p ≤ 0)
    (haHolder : ∀ i j, ParabolicHolderOn δ Set.univ (fun p ↦ a p i j))
    (hbHolder : ∀ i, ParabolicHolderOn δ Set.univ (fun p ↦ b p i))
    (hcHolder : ParabolicHolderOn δ Set.univ c) :
    let Q : Set (ℝ × EuclideanSpace ℝ (Fin d)) :=
      {p | (p.1 : WithTop ℝ) < T ∧ p.2 ∈ Ω}
    let lateralBoundary : Set (ℝ × EuclideanSpace ℝ (Fin d)) :=
      {p | (p.1 : WithTop ℝ) < T ∧ p.2 ∈ frontier Ω}
    ∀ f g, ParabolicHolderOn δ Q f → ParabolicHolderOn (2 + δ) Q g →
      ∃ u, ParabolicHolderOn (2 + δ) (closure Q) u ∧
        (∀ p ∈ Q, parabolicSecondOrderOperator a b c u p -
          deriv (fun s ↦ u (s, p.2)) p.1 = f p) ∧
        (∀ p ∈ lateralBoundary, u p = g p) ∧
        ∀ v, ParabolicHolderOn (2 + δ) (closure Q) v →
          (∀ p ∈ Q, parabolicSecondOrderOperator a b c v p -
            deriv (fun s ↦ v (s, p.2)) p.1 = f p) →
          (∀ p ∈ lateralBoundary, v p = g p) → Set.EqOn v u (closure Q) := by
  sorry

end KrylovHolder
end Dataset
