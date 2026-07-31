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
# `nikolski_A_3_7_blaschke_zero_sets` — 3.7.1

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `nikolski_A_3_7_blaschke_zero_sets.md`.
Quality rubric: `nikolski_A_3_7_blaschke_zero_sets.criteria.md`.
-/

@[expose] public section

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
