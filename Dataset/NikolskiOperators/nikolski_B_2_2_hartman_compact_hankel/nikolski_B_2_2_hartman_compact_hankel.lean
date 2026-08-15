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
# `nikolski_B_2_2_hartman_compact_hankel` — 2.2.5

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `nikolski_B_2_2_hartman_compact_hankel.md`.
Quality rubric: `nikolski_B_2_2_hartman_compact_hankel.criteria.md`.
-/

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
