module

public import Dataset.ConwayFunctionalAnalysis.Defs
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
# `conway_II_7_6_compact_normal_spectral_theorem` — II.7.6

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `conway_II_7_6_compact_normal_spectral_theorem.md`.
Quality rubric: `conway_II_7_6_compact_normal_spectral_theorem.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory Set Topology
open scoped BoundedContinuousFunction Topology

namespace Dataset
namespace ConwayFunctionalAnalysis

universe u

/-- Conway II.7.6, the spectral theorem for compact normal operators. -/
theorem conway_II_7_6_compact_normal_spectral_theorem
    {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
    (T : H →L[ℂ] H) (hnormal : IsStarNormal T)
    (hcompact : IsCompactOperator T) :
    ∃ (ι : Type) (_ : Countable ι) (eigenvalue : ι → ℂ)
      (projection : ι → H →L[ℂ] H),
      (∀ i, eigenvalue i ≠ 0) ∧ Function.Injective eigenvalue ∧
      (∀ i, projection i ≠ 0) ∧ (∀ i, IsOrthogonalProjection (projection i)) ∧
      Pairwise (fun i j ↦ (projection i).comp (projection j) = 0) ∧
      (∀ i, LinearMap.range (projection i).toLinearMap =
        LinearMap.ker (T - eigenvalue i • ContinuousLinearMap.id ℂ H).toLinearMap) ∧
      (∀ ε : ℝ, 0 < ε → {i : ι | ε ≤ ‖eigenvalue i‖}.Finite) ∧
      HasSum (fun i ↦ eigenvalue i • projection i) T := by
  sorry

end ConwayFunctionalAnalysis
end Dataset
