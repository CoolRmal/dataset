module

public import Mathlib.Analysis.CStarAlgebra.GelfandNaimarkSegal
public import Mathlib.Analysis.Calculus.Deriv.Basic
public import Mathlib.Analysis.InnerProductSpace.Adjoint
public import Mathlib.Analysis.Normed.Operator.Compact.Basic
public import Mathlib.MeasureTheory.Measure.Complex
public import Mathlib.MeasureTheory.VectorMeasure.Integral
public import Mathlib.Topology.Algebra.Module.Spaces.WeakDual
public import Mathlib.Topology.ContinuousMap.Bounded.Basic
public import Mathlib.Tactic.TFAE

/-!
# `conway_V_13_3_james` — V.13.3

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `conway_V_13_3_james.md`.
Quality rubric: `conway_V_13_3_james.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory Set Topology
open scoped BoundedContinuousFunction Topology

namespace Dataset
namespace ConwayFunctionalAnalysis

universe u

/-- Conway V.13.3, James's weak compactness theorem. -/
theorem conway_V_13_3_james
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℂ E] [CompleteSpace E]
    (A : Set E) (hAclosed : IsClosed A) (hAconvex : Convex ℝ A)
    (hattains : ∀ φ : E →L[ℂ] ℂ,
      ∃ x₀ ∈ A, ∀ x ∈ A, ‖φ x‖ ≤ ‖φ x₀‖) :
    IsCompact (toWeakSpace ℂ E '' A) := by
  sorry

end ConwayFunctionalAnalysis
end Dataset
