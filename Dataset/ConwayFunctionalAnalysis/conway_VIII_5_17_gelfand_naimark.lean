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
# `conway_VIII_5_17_gelfand_naimark` — VIII.5.17

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `conway_VIII_5_17_gelfand_naimark.md`.
Quality rubric: `conway_VIII_5_17_gelfand_naimark.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory Set Topology
open scoped BoundedContinuousFunction Topology

namespace Dataset
namespace ConwayFunctionalAnalysis

universe u

/-- Conway VIII.5.17, the Gelfand-Naimark representation theorem. -/
theorem conway_VIII_5_17_gelfand_naimark {A : Type u} [CStarAlgebra A] :
    (∃ (H : Type u) (_ : NormedAddCommGroup H) (_ : InnerProductSpace ℂ H)
      (_ : CompleteSpace H) (π : A →⋆ₐ[ℂ] (H →L[ℂ] H)), Isometry π) ∧
    (TopologicalSpace.SeparableSpace A →
      ∃ (H : Type u) (_ : NormedAddCommGroup H) (_ : InnerProductSpace ℂ H)
        (_ : CompleteSpace H) (_ : TopologicalSpace.SeparableSpace H)
        (π : A →⋆ₐ[ℂ] (H →L[ℂ] H)), Isometry π) := by
  sorry

end ConwayFunctionalAnalysis
end Dataset
