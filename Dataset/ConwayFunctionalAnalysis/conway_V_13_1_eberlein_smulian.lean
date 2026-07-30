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
# `conway_V_13_1_eberlein_smulian` — V.13.1

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `conway_V_13_1_eberlein_smulian.md`.
Quality rubric: `conway_V_13_1_eberlein_smulian.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory Set Topology
open scoped BoundedContinuousFunction Topology

namespace Dataset
namespace ConwayFunctionalAnalysis

universe u

/-- Conway V.13.1, the Eberlein-Smulian theorem. -/
theorem conway_V_13_1_eberlein_smulian
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℂ E] [CompleteSpace E]
    (A : Set E) :
    let subsequences := ∀ u : ℕ → E, (∀ n, u n ∈ A) →
      ∃ φ : ℕ → ℕ, StrictMono φ ∧ ∃ x : E,
        Tendsto (fun n ↦ toWeakSpace ℂ E (u (φ n))) atTop (𝓝 (toWeakSpace ℂ E x))
    let clusterPoints := ∀ u : ℕ → E, (∀ n, u n ∈ A) →
      ∃ x : E, MapClusterPt (toWeakSpace ℂ E x) atTop (fun n ↦ toWeakSpace ℂ E (u n))
    List.TFAE [subsequences, clusterPoints,
      IsCompact (closure (toWeakSpace ℂ E '' A))] := by
  sorry

end ConwayFunctionalAnalysis
end Dataset
