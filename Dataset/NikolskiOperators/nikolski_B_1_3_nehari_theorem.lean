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
# `nikolski_B_1_3_nehari_theorem` — 1.3.2

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `nikolski_B_1_3_nehari_theorem.md`.
Quality rubric: `nikolski_B_1_3_nehari_theorem.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory Set Topology
open scoped BigOperators ENNReal Interval lp Topology

namespace Dataset
namespace NikolskiOperators

/--
Nikol'ski, *Operators, Functions, and Systems*, Volume 1, Part B, Sections 1.3
and 1.4: Nehari's theorem: a Hankel matrix defines a bounded Hankel form if and
only if it has an essentially bounded symbol with the prescribed negative Fourier
coefficients.
-/
theorem nikolski_B_1_3_nehari_theorem
    {a : ℕ → ℂ} :
    BoundedHankelForm a ↔ ∃ φ : {z : ℂ // ‖z‖ = 1} → ℂ,
      HasBoundedHankelSymbol a φ ∧
        eLpNorm (fun t : ℝ ↦ φ (unitCirclePoint t)) ∞
            (volume.restrict (Set.Ioc 0 (2 * Real.pi))) = hankelFormNorm a ∧
          symbolDistanceToHInfinity φ = hankelFormNorm a := by
  sorry

end NikolskiOperators
end Dataset
