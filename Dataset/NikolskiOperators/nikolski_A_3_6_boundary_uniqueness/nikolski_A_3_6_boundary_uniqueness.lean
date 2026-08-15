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
# `nikolski_A_3_6_boundary_uniqueness` — 3.6.1

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `nikolski_A_3_6_boundary_uniqueness.md`.
Quality rubric: `nikolski_A_3_6_boundary_uniqueness.criteria.md`.
-/

open Filter MeasureTheory Set Topology
open scoped BigOperators ENNReal Interval lp Topology

namespace Dataset
namespace NikolskiOperators

/--
Nikol'ski, *Operators, Functions, and Systems*, Volume 1, Part A, Section 3.6:
boundary uniqueness for Hardy classes: if the boundary values of a Hardy
function vanish on a positive boundary set, then the function is identically zero.
-/
theorem nikolski_A_3_6_boundary_uniqueness
    {p : ℝ≥0∞} {f : ℂ → ℂ} (hp : p ≠ 0) (hf : HardyClass p f) :
    HasRadialBoundaryValues f ∧
    ((∃ z ∈ Metric.ball (0 : ℂ) 1, f z ≠ 0) →
      IntegrableOn (fun t : ℝ ↦
        Real.log ‖boundaryValue f (unitCirclePoint t)‖) (Set.Ioc 0 (2 * Real.pi))) ∧
    ∀ E : Set {z : ℂ // ‖z‖ = 1},
      0 < volume {t ∈ Set.Ioc 0 (2 * Real.pi) | unitCirclePoint t ∈ E} →
        (∀ᵐ t ∂volume.restrict (Set.Ioc 0 (2 * Real.pi)),
          unitCirclePoint t ∈ E → boundaryValue f (unitCirclePoint t) = 0) →
        ∀ z ∈ Metric.ball (0 : ℂ) 1, f z = 0 := by
  sorry

end NikolskiOperators
end Dataset
