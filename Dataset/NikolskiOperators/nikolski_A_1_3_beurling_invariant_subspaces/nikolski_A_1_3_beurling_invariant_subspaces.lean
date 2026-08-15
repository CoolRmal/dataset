import Dataset.NikolskiOperators.Defs
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.IteratedDeriv.Defs
import Mathlib.Analysis.Complex.Basic
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Analysis.Normed.Lp.lpSpace
import Mathlib.Data.ENNReal.Basic
import Mathlib.Data.Matrix.Basic
import Mathlib.MeasureTheory.Function.LpSeminorm.Basic
import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
import Mathlib.Topology.Algebra.InfiniteSum.Basic
import Mathlib.Tactic.TFAE

/-!
# `nikolski_A_1_3_beurling_invariant_subspaces` — 1.3.2

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `nikolski_A_1_3_beurling_invariant_subspaces.md`.
Quality rubric: `nikolski_A_1_3_beurling_invariant_subspaces.criteria.md`.
-/

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
