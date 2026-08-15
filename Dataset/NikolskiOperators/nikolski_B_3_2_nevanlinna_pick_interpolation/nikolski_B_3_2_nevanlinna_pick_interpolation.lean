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
# `nikolski_B_3_2_nevanlinna_pick_interpolation` — 3.2.4

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `nikolski_B_3_2_nevanlinna_pick_interpolation.md`.
Quality rubric: `nikolski_B_3_2_nevanlinna_pick_interpolation.criteria.md`.
-/

open Filter MeasureTheory Set Topology
open scoped BigOperators ENNReal Interval lp Topology

namespace Dataset
namespace NikolskiOperators

/--
Nikol'ski, *Operators, Functions, and Systems*, Volume 1, Part B, Section 3.2:
Nevanlinna-Pick interpolation: finite disk data admit a Schur-class interpolant
if and only if the Pick matrix is positive semidefinite.
-/
theorem nikolski_B_3_2_nevanlinna_pick_interpolation
    {n : ℕ} {z w : Fin n → ℂ} (hz : ∀ i : Fin n, z i ∈ Metric.ball (0 : ℂ) 1)
    (hz_injective : Function.Injective z) :
    let solutions := {f : ℂ → ℂ | SchurFunction f ∧ ∀ i : Fin n, f (z i) = w i}
    (solutions.Nonempty ↔ PositiveSemidefiniteMatrix (PickMatrix z w)) ∧
      (solutions.Nonempty →
        ((∀ f ∈ solutions, ∀ g ∈ solutions, Set.EqOn f g (Metric.ball (0 : ℂ) 1)) ↔
          Matrix.det (PickMatrix z w) = 0)) := by
  sorry

end NikolskiOperators
end Dataset
