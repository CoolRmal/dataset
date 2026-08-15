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
# `nikolski_B_7_2_1_adamyan_arov_krein` — 7.2.1

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `nikolski_B_7_2_1_adamyan_arov_krein.md`.
Quality rubric: `nikolski_B_7_2_1_adamyan_arov_krein.criteria.md`.
-/

open Filter MeasureTheory Set Topology
open scoped BigOperators ENNReal Interval lp Topology

namespace Dataset
namespace NikolskiOperators

/-- Nikol'ski, Part B, Theorem 7.2.1 (Adamyan–Arov–Krein). -/
theorem nikolski_B_7_2_1_adamyan_arov_krein
    {a : ℕ → ℂ} {φ : {z : ℂ // ‖z‖ = 1} → ℂ} {n : ℕ} :
    HasBoundedHankelSymbol a φ →
      hankelApproximationNumber a n = hankelRankApproximationDistance a n ∧
        hankelRankApproximationDistance a n = rationalPlusHInfinityDistance φ n ∧
        rationalPlusHInfinityDistance φ n = finiteBlaschkeHankelDistance φ n := by
  sorry

end NikolskiOperators
end Dataset
