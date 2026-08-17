import Dataset.KrylovHolder.Defs

/-!
# `krylov_2_9_2_bounded_maximum_principle_resolvent`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_2_9_2_bounded_maximum_principle_resolvent.md`.
Quality rubric: `krylov_2_9_2_bounded_maximum_principle_resolvent.criteria.md`.
-/

namespace Dataset
namespace KrylovHolder

/-- Krylov 2.9.2, the bounded maximum-principle resolvent estimate. -/
theorem krylov_2_9_2_bounded_maximum_principle_resolvent
    {d : ℕ} {Ω : Set (EuclideanSpace ℝ (Fin d))}
    {a : EuclideanSpace ℝ (Fin d) → Fin d → Fin d → ℝ}
    {b : EuclideanSpace ℝ (Fin d) → Fin d → ℝ} {c : EuclideanSpace ℝ (Fin d) → ℝ}
    {lam : ℝ} {u : EuclideanSpace ℝ (Fin d) → ℝ}
    (hΩ : IsOpen Ω) (huDiff : ContDiffOn ℝ 2 u Ω)
    (huContinuous : ContinuousOn u (closure Ω))
    (huBounded : Bornology.IsBounded (u '' Ω))
    (huBoundary : ∀ x ∈ frontier Ω, u x = 0)
    (hsym : ∀ x i j, a x i j = a x j i)
    (hnonneg : ∀ x (ξ : Fin d → ℝ), 0 ≤ ∑ i, ∑ j, a x i j * ξ i * ξ j)
    (haBounded : ∃ C : ℝ, ∀ x i j, |a x i j| ≤ C)
    (hbBounded : ∃ C : ℝ, ∀ x i, |b x i| ≤ C)
    (hlam : 0 < lam) (hc : ∀ x, c x ≤ -lam) :
    functionSupNorm Ω (fun x ↦ max (u x) 0) ≤
        (ENNReal.ofReal lam)⁻¹ *
          functionSupNorm Ω (fun x ↦ max (-(secondOrderOperator a b c u x)) 0) ∧
      functionSupNorm Ω u ≤
        (ENNReal.ofReal lam)⁻¹ * functionSupNorm Ω (secondOrderOperator a b c u) := by
  sorry

end KrylovHolder
end Dataset
