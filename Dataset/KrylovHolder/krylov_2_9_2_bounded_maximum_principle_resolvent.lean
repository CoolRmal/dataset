module

public import Dataset.KrylovHolder.Defs
public import Mathlib.Analysis.Calculus.ContDiff.Basic
public import Mathlib.Analysis.Calculus.IteratedDeriv.Defs
public import Mathlib.MeasureTheory.Integral.Bochner.Basic
public import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
public import Mathlib.MeasureTheory.Measure.Hausdorff

/-!
# `krylov_2_9_2_bounded_maximum_principle_resolvent`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_2_9_2_bounded_maximum_principle_resolvent.md`.
Quality rubric: `krylov_2_9_2_bounded_maximum_principle_resolvent.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology
open scoped ENNReal Topology

namespace Dataset
namespace KrylovHolder

/-- Krylov 2.9.2, the bounded maximum-principle resolvent estimate. -/
theorem krylov_2_9_2_bounded_maximum_principle_resolvent
    {d : ℕ} {Ω : Set (Fin d → ℝ)}
    {L : ((Fin d → ℝ) → ℝ) → (Fin d → ℝ) → ℝ} {lam : ℝ}
    {u : (Fin d → ℝ) → ℝ}
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
