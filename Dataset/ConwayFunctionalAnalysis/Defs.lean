import Mathlib.Analysis.CStarAlgebra.GelfandNaimarkSegal
import Mathlib.Analysis.Normed.Operator.Compact.Basic
import Mathlib.MeasureTheory.Measure.Complex
import Mathlib.MeasureTheory.VectorMeasure.Integral

/-!
# Shared definitions for the ConwayFunctionalAnalysis problems

Custom notions used by the statement files in `Dataset/ConwayFunctionalAnalysis/` that are
not already supplied by Mathlib. Each problem file that needs them imports
this module.
-/

open Filter MeasureTheory Set
open scoped Topology

namespace Dataset
namespace ConwayFunctionalAnalysis

universe u

/-- A countably additive projection-valued measure, with additivity in the strong topology. -/
structure ProjectionValuedMeasure (H : Type*) [NormedAddCommGroup H]
    [InnerProductSpace ℂ H] [CompleteSpace H] where
  toFun : Set ℂ → H →L[ℂ] H
  univ : toFun univ = ContinuousLinearMap.id ℂ H
  projection : ∀ B : Set ℂ, MeasurableSet B → IsStarProjection (toFun B)
  nonmeasurable : ∀ B : Set ℂ, ¬MeasurableSet B → toFun B = 0
  orthogonal : ∀ B C : Set ℂ, MeasurableSet B → MeasurableSet C → Disjoint B C →
    (toFun B).comp (toFun C) = 0
  countablyAdditive : ∀ (B : ℕ → Set ℂ), (∀ n, MeasurableSet (B n)) →
    Pairwise (fun m n ↦ Disjoint (B m) (B n)) → ∀ x : H,
      Tendsto (fun N ↦ ∑ n ∈ Finset.range N, toFun (B n) x) atTop
        (𝓝 (toFun (⋃ n, B n) x))

/-- A densely defined linear operator, including density as part of the data. -/
structure DenselyDefinedOperator (H : Type*) [NormedAddCommGroup H]
    [InnerProductSpace ℂ H] where
  domain : Submodule ℂ H
  op : domain →ₗ[ℂ] H
  dense_domain : Dense (domain : Set H)

/-- The defining domain-and-adjoint identities for an unbounded self-adjoint operator. -/
def IsSelfAdjointUnbounded {H : Type*} [NormedAddCommGroup H]
    [InnerProductSpace ℂ H] (A : DenselyDefinedOperator H) : Prop :=
  (∀ y : H, y ∈ A.domain ↔
    ∃ z : H, ∀ x : A.domain, inner ℂ (A.op x) y = inner ℂ (x : H) z) ∧
  ∀ y : A.domain, ∀ z : H,
    (∀ x : A.domain, inner ℂ (A.op x) y = inner ℂ (x : H) z) → z = A.op y

/-- A strongly continuous one-parameter unitary group. -/
def StronglyContinuousUnitaryGroup {H : Type*} [NormedAddCommGroup H]
    [InnerProductSpace ℂ H] [CompleteSpace H] (U : ℝ → H →L[ℂ] H) : Prop :=
  U 0 = ContinuousLinearMap.id ℂ H ∧
    (∀ s t : ℝ, U (s + t) = (U s).comp (U t)) ∧
    (∀ t : ℝ, U t ∈ unitary (H →L[ℂ] H)) ∧
    ∀ x : H, Continuous fun t ↦ U t x

/-- A unitary group is the spectral-calculus exponential of an unbounded operator. -/
def IsSpectralExponential {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
    [CompleteSpace H] (A : DenselyDefinedOperator H) (U : ℝ → H →L[ℂ] H) : Prop :=
  ∃ (E : ProjectionValuedMeasure H) (scalarMeasure : H → H → ComplexMeasure ℂ),
    E.toFun {z : ℂ | z.im ≠ 0} = 0 ∧
      (∀ x y : H, ∀ B : Set ℂ, MeasurableSet B →
        scalarMeasure x y B = inner ℂ (E.toFun B x) y) ∧
      (∀ x : A.domain, ∀ y : H, inner ℂ (A.op x) y =
        ∫ᵛ z, z ∂[ContinuousLinearMap.mul ℝ ℂ; scalarMeasure x y]) ∧
      ∀ t : ℝ, ∀ x y : H, inner ℂ (U t x) y =
        ∫ᵛ z, Complex.exp (-(Complex.I * t * z))
          ∂[ContinuousLinearMap.mul ℝ ℂ; scalarMeasure x y]

/-- Left invertibility modulo compact operators. -/
def IsLeftSemiFredholm {H K : Type*} [NormedAddCommGroup H] [NormedAddCommGroup K]
    [InnerProductSpace ℂ H] [InnerProductSpace ℂ K] [CompleteSpace H]
    [CompleteSpace K] (A : H →L[ℂ] K) : Prop :=
  ∃ B : K →L[ℂ] H, ∃ C : H →L[ℂ] H,
    IsCompactOperator C ∧ B.comp A = ContinuousLinearMap.id ℂ H + C

end ConwayFunctionalAnalysis
end Dataset
