module

public import Dataset.NikolskiOperators.Defs
public import Mathlib.Analysis.Calculus.Deriv.Basic
public import Mathlib.Analysis.Calculus.IteratedDeriv.Defs
public import Mathlib.Analysis.Complex.Basic
public import Mathlib.Analysis.SpecialFunctions.Exp
public import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
public import Mathlib.Analysis.Normed.Lp.lpSpace
public import Mathlib.Data.ENNReal.Basic
public import Mathlib.Data.Matrix.Basic
public import Mathlib.MeasureTheory.Function.LpSeminorm.Basic
public import Mathlib.MeasureTheory.Integral.Bochner.Basic
public import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
public import Mathlib.Topology.Algebra.InfiniteSum.Basic
public import Mathlib.Tactic.TFAE

/-!
# `nikolski_A_1_3_beurling_invariant_subspaces` — 1.3.2

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `nikolski_A_1_3_beurling_invariant_subspaces.md`.
Quality rubric: `nikolski_A_1_3_beurling_invariant_subspaces.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory Set Topology
open scoped BigOperators ENNReal Interval lp Topology

namespace Dataset
namespace NikolskiOperators

/-- Nikol'ski A.1.3.2, the Beurling--Helson theorem for simply invariant `L²` subspaces. -/
theorem nikolski_A_1_3_beurling_invariant_subspaces
    {E : Set (ℝ → ℂ)} (hlinear : IsCircleL2Subspace E)
    (hclosed : ∀ f : ℝ → ℂ, MemLp f 2 circleMeasure →
      (∃ approximant : ℕ → ℝ → ℂ, (∀ j, approximant j ∈ E) ∧
        Tendsto (fun j ↦ eLpNorm (approximant j - f) 2 circleMeasure) atTop (𝓝 0)) → f ∈ E)
    (hshiftProper : {g : ℝ → ℂ | ∃ f ∈ E,
      g =ᵐ[circleMeasure] fun t ↦ Complex.exp (Complex.I * t) * f t} ⊂ E) :
    ∃ theta : ℝ → ℂ, UnimodularGeneratedSubspace E theta ∧
      ∀ eta : ℝ → ℂ, UnimodularGeneratedSubspace E eta →
        ∃ c : ℂ, ‖c‖ = 1 ∧ eta =ᵐ[circleMeasure] fun t ↦ c * theta t := by
  sorry

end NikolskiOperators
end Dataset
