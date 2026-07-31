module

public import Dataset.ConwayFunctionalAnalysis.Defs
public import Mathlib.Analysis.CStarAlgebra.GelfandNaimarkSegal
public import Mathlib.Analysis.Calculus.Deriv.Basic
public import Mathlib.Analysis.InnerProductSpace.Adjoint
public import Mathlib.Analysis.Normed.Operator.Compact.Basic
public import Mathlib.MeasureTheory.Measure.Complex
public import Mathlib.MeasureTheory.VectorMeasure.Integral
public import Mathlib.Topology.Algebra.Module.Spaces.WeakDual
public import Mathlib.Topology.ContinuousMap.Bounded.Basic
public import Mathlib.Tactic.TFAE

/-!
# `conway_XI_2_3_left_semi_fredholm_characterizations` — XI.2.3

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `conway_XI_2_3_left_semi_fredholm_characterizations.md`.
Quality rubric: `conway_XI_2_3_left_semi_fredholm_characterizations.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory Set Topology
open scoped BoundedContinuousFunction Topology

namespace Dataset
namespace ConwayFunctionalAnalysis

universe u

/-- Conway XI.2.3, the Atkinson-Wolf-Schechter-Fillmore-Stampfli-Williams theorem. -/
theorem conway_XI_2_3_left_semi_fredholm_characterizations
    {H K : Type*} [NormedAddCommGroup H] [NormedAddCommGroup K]
    [InnerProductSpace ℂ H] [InnerProductSpace ℂ K] [CompleteSpace H]
    [CompleteSpace K] (A : H →L[ℂ] K) :
    let a := IsLeftSemiFredholm A
    let b := IsClosed (range A) ∧ FiniteDimensional ℂ (LinearMap.ker A.toLinearMap)
    let c := ∃ B : K →L[ℂ] H, ∃ F : H →L[ℂ] H,
      FiniteDimensional ℂ (LinearMap.range F.toLinearMap) ∧
        B.comp A = ContinuousLinearMap.id ℂ H + F
    let d := ¬∃ u : ℕ → H, (∀ n, ‖u n‖ = 1) ∧
      Tendsto (fun n ↦ toWeakSpace ℂ H (u n)) atTop (𝓝 0) ∧
        Tendsto (fun n ↦ ‖A (u n)‖) atTop (𝓝 0)
    let e := ¬∃ u : ℕ → H,
      Orthonormal ℂ u ∧ Tendsto (fun n ↦ ‖A (u n)‖) atTop (𝓝 0)
    let f := ∃ δ : ℝ, 0 < δ ∧ ∀ M : Submodule ℂ H,
      (∀ x : M, ‖A x‖ ≤ δ * ‖(x : H)‖) → FiniteDimensional ℂ M
    let g := ∃ modulus : H →L[ℂ] H,
      modulus.comp modulus = A.adjoint.comp A ∧ modulus.adjoint = modulus ∧
        (∀ x : H, 0 ≤ (inner ℂ (modulus x) x).re) ∧
          ∃ E : ProjectionValuedMeasure H,
            E.toFun (spectrum ℂ modulus) = ContinuousLinearMap.id ℂ H ∧
            (∃ scalarMeasure : H → H → ComplexMeasure ℂ,
              (∀ x y : H, ∀ B : Set ℂ, MeasurableSet B →
                scalarMeasure x y B = inner ℂ (E.toFun B x) y) ∧
              ∀ x y : H, inner ℂ (modulus x) y =
                ∫ᵛ z, z ∂[ContinuousLinearMap.mul ℝ ℂ; scalarMeasure x y]) ∧
            ∃ δ : ℝ, 0 < δ ∧ FiniteDimensional ℂ
              (LinearMap.range (E.toFun (Metric.closedBall (0 : ℂ) δ)).toLinearMap)
    let h := ∀ C : H →L[ℂ] K, IsCompactOperator C →
      FiniteDimensional ℂ (LinearMap.ker (A + C).toLinearMap)
    List.TFAE [a, b, c, d, e, f, g, h] := by
  sorry

end ConwayFunctionalAnalysis
end Dataset
