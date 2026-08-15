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
# `nikolski_A_3_7_blaschke_zero_sets` — 3.7.1

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `nikolski_A_3_7_blaschke_zero_sets.md`.
Quality rubric: `nikolski_A_3_7_blaschke_zero_sets.criteria.md`.
-/

open Filter MeasureTheory Set Topology
open scoped BigOperators ENNReal Interval lp Topology

namespace Dataset
namespace NikolskiOperators

/--
Nikol'ski, *Operators, Functions, and Systems*, Volume 1, Part A, Section 3.7:
the zero sets of nontrivial Hardy-class functions are precisely Blaschke
sequences in the disk.
-/
theorem nikolski_A_3_7_blaschke_zero_sets
    {p : ℝ≥0∞} {a : ℕ → ℂ} (hp : p ≠ 0) :
    (∃ f : ℂ → ℂ, HardyClass p f ∧
      (∃ z ∈ Metric.ball (0 : ℂ) 1, f z ≠ 0) ∧ HasZeroSequence f a) ↔
      BlaschkeCondition a := by
  sorry

end NikolskiOperators
end Dataset
