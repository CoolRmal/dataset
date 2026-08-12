module

public import Dataset.KrylovSobolev.Defs
public import Mathlib.Analysis.Calculus.ContDiff.Basic
public import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
public import Mathlib.MeasureTheory.Integral.Bochner.Basic

/-!
# `krylov_sobolev_1_1_3_hessian_determinant_integral`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_sobolev_1_1_3_hessian_determinant_integral.md`.
Quality rubric: `krylov_sobolev_1_1_3_hessian_determinant_integral.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology
open scoped ContDiff ENNReal Topology

namespace Dataset
namespace KrylovSobolev

/-- Krylov 1.1.3: the integral of the Hessian determinant of a compactly supported
`C²` function on the plane vanishes. -/
theorem krylov_sobolev_1_1_3_hessian_determinant_integral
    (u : EuclideanSpace ℝ (Fin 2) → ℝ) (hu : ContDiff ℝ 2 u) (hsupp : HasCompactSupport u) :
    ∫ x, (hessian u x).det = 0 := by
  sorry

end KrylovSobolev
end Dataset
