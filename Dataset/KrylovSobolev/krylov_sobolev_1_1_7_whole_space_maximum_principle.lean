module

public import Dataset.KrylovSobolev.Defs
public import Mathlib.Analysis.Calculus.ContDiff.Basic

/-!
# `krylov_sobolev_1_1_7_whole_space_maximum_principle`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_sobolev_1_1_7_whole_space_maximum_principle.md`.
Quality rubric: `krylov_sobolev_1_1_7_whole_space_maximum_principle.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology
open scoped ContDiff ENNReal Laplacian Topology

namespace Dataset
namespace KrylovSobolev

/-- Krylov 1.1.7: a `C²` function on `ℝ^d` that is bounded from above and satisfies
`Δu - λu ≥ 0` with `λ > 0` is nonpositive; a bounded `C²` solution of `Δu - λu = 0`
vanishes identically. -/
theorem krylov_sobolev_1_1_7_whole_space_maximum_principle {d : ℕ} (lam : ℝ) (hlam : 0 < lam) :
    (∀ u : EuclideanSpace ℝ (Fin d) → ℝ, ContDiff ℝ 2 u → BddAbove (range u) →
        (∀ x, 0 ≤ Δ u x - lam * u x) → ∀ x, u x ≤ 0) ∧
      ∀ u : EuclideanSpace ℝ (Fin d) → ℝ, ContDiff ℝ 2 u → Bornology.IsBounded (range u) →
        (∀ x, Δ u x - lam * u x = 0) → u = 0 := by
  sorry

end KrylovSobolev
end Dataset
