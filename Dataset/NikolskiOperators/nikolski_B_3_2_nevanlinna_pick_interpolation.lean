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
# `nikolski_B_3_2_nevanlinna_pick_interpolation` — 3.2.4

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `nikolski_B_3_2_nevanlinna_pick_interpolation.md`.
Quality rubric: `nikolski_B_3_2_nevanlinna_pick_interpolation.criteria.md`.
-/

@[expose] public section

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
    {n : ℕ} {z w : Fin n → ℂ} (hz : ∀ i : Fin n, z i ∈ Metric.ball (0 : ℂ) 1) :
    let solutions := {f : ℂ → ℂ | SchurFunction f ∧ ∀ i : Fin n, f (z i) = w i}
    (solutions.Nonempty ↔ PositiveSemidefiniteMatrix (PickMatrix z w)) ∧
      (solutions.Nonempty →
        (solutions.Subsingleton ↔ Matrix.det (PickMatrix z w) = 0)) := by
  sorry

end NikolskiOperators
end Dataset
