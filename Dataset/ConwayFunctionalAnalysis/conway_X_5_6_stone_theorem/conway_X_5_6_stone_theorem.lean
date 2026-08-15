import Dataset.ConwayFunctionalAnalysis.Defs
import Mathlib.Analysis.CStarAlgebra.GelfandNaimarkSegal
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.InnerProductSpace.Adjoint
import Mathlib.Analysis.Normed.Operator.Compact.Basic
import Mathlib.MeasureTheory.Measure.Complex
import Mathlib.MeasureTheory.VectorMeasure.Integral
import Mathlib.Topology.Algebra.Module.Spaces.WeakDual
import Mathlib.Topology.ContinuousMap.Bounded.Basic
import Mathlib.Tactic.TFAE

/-!
# `conway_X_5_6_stone_theorem` — X.5.6

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `conway_X_5_6_stone_theorem.md`.
Quality rubric: `conway_X_5_6_stone_theorem.criteria.md`.
-/

open Filter MeasureTheory Set Topology
open scoped BoundedContinuousFunction Topology

namespace Dataset
namespace ConwayFunctionalAnalysis

universe u

/-- Conway X.5.6, Stone's theorem for strongly continuous unitary groups. -/
theorem conway_X_5_6_stone_theorem
    {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
    (U : ℝ → H →L[ℂ] H) (hU : StronglyContinuousUnitaryGroup U) :
    ∃! A : DenselyDefinedOperator H,
      IsSelfAdjointUnbounded A ∧ IsSpectralExponential A U := by
  sorry

end ConwayFunctionalAnalysis
end Dataset
