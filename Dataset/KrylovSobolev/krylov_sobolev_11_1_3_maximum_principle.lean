module

public import Dataset.KrylovSobolev.Defs
public import Mathlib.Analysis.Calculus.ContDiff.Basic

/-!
# `krylov_sobolev_11_1_3_maximum_principle`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_sobolev_11_1_3_maximum_principle.md`.
Quality rubric: `krylov_sobolev_11_1_3_maximum_principle.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology
open scoped ContDiff ENNReal Topology

namespace Dataset
namespace KrylovSobolev

/-- Krylov 11.1.3, the maximum principle: for a second-order elliptic operator with
`L1 = c ≤ 0` on a bounded domain, a subsolution is bounded by the boundary maximum of
its positive part. -/
theorem krylov_sobolev_11_1_3_maximum_principle {d : ℕ} (hd : 1 ≤ d)
    {κ K : ℝ} (L : EllipticCoefficients d κ K) (hc : ∀ x, L.c x ≤ 0)
    (Ω : Set (EuclideanSpace ℝ (Fin d))) (hΩopen : IsOpen Ω)
    (hΩbdd : Bornology.IsBounded Ω)
    (u : EuclideanSpace ℝ (Fin d) → ℝ)
    (hu : ContDiffOn ℝ 2 u Ω) (hucont : ContinuousOn u (closure Ω))
    (hLu : ∀ x ∈ Ω, 0 ≤ L.op u x) :
    ∀ x ∈ Ω, u x ≤ sSup ((fun y ↦ max (u y) 0) '' frontier Ω) := by
  sorry

end KrylovSobolev
end Dataset
