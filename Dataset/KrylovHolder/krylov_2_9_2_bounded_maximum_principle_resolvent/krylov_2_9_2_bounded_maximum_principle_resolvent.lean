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
    {L : (EuclideanSpace ℝ (Fin d) → ℝ) → EuclideanSpace ℝ (Fin d) → ℝ} {lam : ℝ}
    {u : EuclideanSpace ℝ (Fin d) → ℝ}
    (hΩ : IsOpen Ω) (huDiff : ContDiffOn ℝ 2 u Ω)
    (huContinuous : ContinuousOn u (closure Ω))
    (huBounded : Bornology.IsBounded (u '' Ω))
    (huBoundary : ∀ x ∈ frontier Ω, u x = 0)
    (hlam : 0 < lam) (hL : SecondOrderEllipticOperator L lam) :
    functionSupNorm Ω (fun x ↦ max (u x) 0) ≤
        (ENNReal.ofReal lam)⁻¹ * functionSupNorm Ω (fun x ↦ max (-(L u x)) 0) ∧
      functionSupNorm Ω u ≤ (ENNReal.ofReal lam)⁻¹ * functionSupNorm Ω (L u) := by
  sorry

end KrylovHolder
end Dataset
