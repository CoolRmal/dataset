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
# `nikolski_B_2_2_hartman_compact_hankel` — 2.2.5

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `nikolski_B_2_2_hartman_compact_hankel.md`.
Quality rubric: `nikolski_B_2_2_hartman_compact_hankel.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory Set Topology
open scoped BigOperators ENNReal Interval lp Topology

namespace Dataset
namespace NikolskiOperators

/--
Nikol'ski, *Operators, Functions, and Systems*, Volume 1, Part B, Section 2.2:
Hartman's compactness theorem in the Adamyan-Arov-Krein form: a bounded Hankel
operator is compact exactly when its symbol belongs to `H∞ + C`.
-/
theorem nikolski_B_2_2_hartman_compact_hankel
    {a : ℕ → ℂ} :
    CompactHankel a ↔ ∃ φ : {z : ℂ // ‖z‖ = 1} → ℂ,
      HasBoundedHankelSymbol a φ ∧ InHInfinityPlusContinuous φ := by
  sorry

end NikolskiOperators
end Dataset
