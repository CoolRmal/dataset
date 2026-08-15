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
# `conway_VI_2_1_banach_stone` — VI.2.1

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `conway_VI_2_1_banach_stone.md`.
Quality rubric: `conway_VI_2_1_banach_stone.criteria.md`.
-/

open Filter MeasureTheory Set Topology
open scoped BoundedContinuousFunction Topology

namespace Dataset
namespace ConwayFunctionalAnalysis

universe u

/-- Conway VI.2.1, the Banach-Stone theorem. -/
theorem conway_VI_2_1_banach_stone
    {X Y : Type*} [TopologicalSpace X] [TopologicalSpace Y]
    [CompactSpace X] [CompactSpace Y] [T2Space X] [T2Space Y]
    (T : (X →ᵇ ℂ) →ₗᵢ[ℂ] (Y →ᵇ ℂ)) (hT : Function.Surjective T) :
    ∃ τ : Y ≃ₜ X, ∃ α : Y →ᵇ ℂ,
      (∀ y : Y, ‖α y‖ = 1) ∧ ∀ f : X →ᵇ ℂ, ∀ y : Y,
        T f y = α y * f (τ y) := by
  sorry

end ConwayFunctionalAnalysis
end Dataset
