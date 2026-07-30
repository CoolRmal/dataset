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
# `nikolski_A_3_6_boundary_uniqueness` — 3.6.1

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `nikolski_A_3_6_boundary_uniqueness.md`.
Quality rubric: `nikolski_A_3_6_boundary_uniqueness.criteria.md`.
-/

@[expose] public section

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
