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
# `nikolski_A_2_4_inner_outer_factorization` — 2.4.1

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `nikolski_A_2_4_inner_outer_factorization.md`.
Quality rubric: `nikolski_A_2_4_inner_outer_factorization.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory Set Topology
open scoped BigOperators ENNReal Interval lp Topology

namespace Dataset
namespace NikolskiOperators

/--
Nikol'ski, *Operators, Functions, and Systems*, Volume 1, Part A, Theorem 2.4.1:
inner-outer factorization in `H²`.
-/
theorem nikolski_A_2_4_inner_outer_factorization
    {f : ℂ → ℂ} (hf : HardyClass 2 f)
    (hnonzero : ∃ z ∈ Metric.ball (0 : ℂ) 1, f z ≠ 0) :
    ∃ θ g : ℂ → ℂ, InnerFunction θ ∧ OuterFunction 2 g ∧
      (∀ z ∈ Metric.ball (0 : ℂ) 1, f z = θ z * g z) ∧
      ∀ θ' g' : ℂ → ℂ, InnerFunction θ' → OuterFunction 2 g' →
        (∀ z ∈ Metric.ball (0 : ℂ) 1, f z = θ' z * g' z) →
          ∃ c : ℂ, ‖c‖ = 1 ∧ ∀ z ∈ Metric.ball (0 : ℂ) 1,
            θ' z = c * θ z ∧ g' z = star c * g z := by
  sorry

end NikolskiOperators
end Dataset
