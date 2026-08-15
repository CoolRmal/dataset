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
# `nikolski_B_4_3_3_devinatz_widom` — 4.3.3

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `nikolski_B_4_3_3_devinatz_widom.md`.
Quality rubric: `nikolski_B_4_3_3_devinatz_widom.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory Set Topology
open scoped BigOperators ENNReal Interval lp Topology

namespace Dataset
namespace NikolskiOperators

/-- Nikol'ski, Part B, Lemma 4.3.3 (Devinatz–Widom criterion). -/
theorem nikolski_B_4_3_3_devinatz_widom
    {u : {z : ℂ // ‖z‖ = 1} → ℂ}
    (hu : EssentiallyBoundedCircleSymbol u) (hmod : IsUnimodularCircleSymbol u) :
    let a := ∃ T : ℓ²(ℕ, ℂ) →L[ℂ] ℓ²(ℕ, ℂ),
      RepresentsToeplitzOperator u T ∧ Function.Bijective T
    let b := symbolDistanceToHInfinity u < 1 ∧
      symbolDistanceToHInfinity (fun ζ ↦ star (u ζ)) < 1
    let c := ∃ h : ℂ → ℂ, OuterFunction ⊤ h ∧
      eLpNorm (fun t : ℝ ↦ u (unitCirclePoint t) - boundaryValue h (unitCirclePoint t)) ∞
        (volume.restrict (Set.Ioc 0 (2 * Real.pi))) < 1
    let d := ∃ v w : {z : ℂ // ‖z‖ = 1} → ℝ, ∃ c : ℝ,
      eLpNorm (fun t : ℝ ↦ v (unitCirclePoint t)) ∞
          (volume.restrict (Set.Ioc 0 (2 * Real.pi))) < ENNReal.ofReal (Real.pi / 2) ∧
        eLpNorm (fun t : ℝ ↦ w (unitCirclePoint t)) ∞
          (volume.restrict (Set.Ioc 0 (2 * Real.pi))) < ∞ ∧
        ∀ᵐ t ∂volume.restrict (Set.Ioc 0 (2 * Real.pi)),
          u (unitCirclePoint t) = Complex.exp (Complex.I *
            (c + v (unitCirclePoint t) + circleHilbertTransform w t))
    List.TFAE [a, b, c, d] := by
  sorry

end NikolskiOperators
end Dataset
