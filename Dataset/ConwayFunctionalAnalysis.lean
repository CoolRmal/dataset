module

import Mathlib.Analysis.CStarAlgebra.GelfandNaimarkSegal
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.InnerProductSpace.Adjoint
import Mathlib.Analysis.Normed.Operator.Compact.Basic
import Mathlib.MeasureTheory.Measure.Complex
import Mathlib.MeasureTheory.VectorMeasure.Integral
import Mathlib.Topology.Algebra.Module.Spaces.WeakDual
import Mathlib.Topology.ContinuousMap.Bounded.Basic
import Mathlib.Tactic.TFAE

/-!
# Hard functional-analysis statements from Conway

Ten statement-only formalizations selected from John B. Conway,
*A Course in Functional Analysis*, second edition.
-/

open Filter MeasureTheory Set Topology

open scoped BoundedContinuousFunction Topology

namespace Dataset
namespace ConwayFunctionalAnalysis

universe u

/-- A bounded operator on a Hilbert space is an orthogonal projection. -/
abbrev IsOrthogonalProjection {H : Type*} [NormedAddCommGroup H]
    [InnerProductSpace ℂ H] [CompleteSpace H] (P : H →L[ℂ] H) : Prop :=
  IsStarProjection P

/-- A countably additive projection-valued measure, with additivity in the strong topology. -/
structure ProjectionValuedMeasure (H : Type*) [NormedAddCommGroup H]
    [InnerProductSpace ℂ H] [CompleteSpace H] where
  toFun : Set ℂ → H →L[ℂ] H
  empty : toFun ∅ = 0
  univ : toFun univ = ContinuousLinearMap.id ℂ H
  projection : ∀ B : Set ℂ, MeasurableSet B → IsOrthogonalProjection (toFun B)
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

/-- A unitary bounded operator. -/
def IsUnitaryOperator {H : Type*} [NormedAddCommGroup H]
    [InnerProductSpace ℂ H] [CompleteSpace H] (U : H →L[ℂ] H) : Prop :=
  U.adjoint.comp U = ContinuousLinearMap.id ℂ H ∧
    U.comp U.adjoint = ContinuousLinearMap.id ℂ H

/-- A strongly continuous one-parameter unitary group. -/
def StronglyContinuousUnitaryGroup {H : Type*} [NormedAddCommGroup H]
    [InnerProductSpace ℂ H] [CompleteSpace H] (U : ℝ → H →L[ℂ] H) : Prop :=
  U 0 = ContinuousLinearMap.id ℂ H ∧
    (∀ s t : ℝ, U (s + t) = (U s).comp (U t)) ∧
    (∀ t : ℝ, IsUnitaryOperator (U t)) ∧
    ∀ x : H, Continuous fun t ↦ U t x

/-- Left invertibility modulo compact operators. -/
def IsLeftSemiFredholm {H K : Type*} [NormedAddCommGroup H] [NormedAddCommGroup K]
    [InnerProductSpace ℂ H] [InnerProductSpace ℂ K] [CompleteSpace H]
    [CompleteSpace K] (A : H →L[ℂ] K) : Prop :=
  ∃ B : K →L[ℂ] H, ∃ C : H →L[ℂ] H,
    IsCompactOperator C ∧ B.comp A = ContinuousLinearMap.id ℂ H + C

/-- Conway V.13.1, the Eberlein-Smulian theorem. -/
theorem conway_V_13_1_eberlein_smulian
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℂ E] [CompleteSpace E]
    (A : Set E) :
    let subsequences := ∀ u : ℕ → E, (∀ n, u n ∈ A) →
      ∃ φ : ℕ → ℕ, StrictMono φ ∧ ∃ x : E,
        Tendsto (fun n ↦ toWeakSpace ℂ E (u (φ n))) atTop (𝓝 (toWeakSpace ℂ E x))
    let clusterPoints := ∀ u : ℕ → E, (∀ n, u n ∈ A) →
      ∃ x : E, MapClusterPt (toWeakSpace ℂ E x) atTop (fun n ↦ toWeakSpace ℂ E (u n))
    List.TFAE [subsequences, clusterPoints,
      IsCompact (closure (toWeakSpace ℂ E '' A))] := by
  sorry

/-- Conway V.13.3, James's weak compactness theorem. -/
theorem conway_V_13_3_james
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℂ E] [CompleteSpace E]
    (A : Set E) (hAclosed : IsClosed A) (hAconvex : Convex ℝ A)
    (hattains : ∀ φ : E →L[ℂ] ℂ,
      ∃ x₀ ∈ A, ∀ x ∈ A, ‖φ x‖ ≤ ‖φ x₀‖) :
    IsCompact (toWeakSpace ℂ E '' A) := by
  sorry

/-- Conway VI.2.1, the Banach-Stone theorem. -/
theorem conway_VI_2_1_banach_stone
    {X Y : Type*} [TopologicalSpace X] [TopologicalSpace Y]
    [CompactSpace X] [CompactSpace Y] [T2Space X] [T2Space Y]
    (T : (X →ᵇ ℂ) →ₗᵢ[ℂ] (Y →ᵇ ℂ)) (hT : Function.Surjective T) :
    ∃ τ : Y ≃ₜ X, ∃ α : Y →ᵇ ℂ,
      (∀ y : Y, ‖α y‖ = 1) ∧ ∀ f : X →ᵇ ℂ, ∀ y : Y,
        T f y = α y * f (τ y) := by
  sorry

/-- Conway VIII.3.6, five equivalent characterizations of positivity. -/
theorem conway_VIII_3_6_positive_element_characterizations
    {A : Type*} [CStarAlgebra A] [PartialOrder A] [StarOrderedRing A] (a : A) :
    let hermitianSquare := ∃ b : A, IsSelfAdjoint b ∧ a = b ^ 2
    let starSquare := ∃ x : A, a = star x * x
    let normBoundForAll := IsSelfAdjoint a ∧ ∀ t : ℝ, ‖a‖ ≤ t →
      ‖algebraMap ℂ A (t : ℂ) - a‖ ≤ t
    let normBoundForSome := IsSelfAdjoint a ∧ ∃ t : ℝ, ‖a‖ ≤ t ∧
      ‖algebraMap ℂ A (t : ℂ) - a‖ ≤ t
    List.TFAE [0 ≤ a, hermitianSquare, starSquare, normBoundForAll,
      normBoundForSome] := by
  sorry

/-- Conway VII.7.1, Riesz's spectral theorem for compact operators. -/
theorem conway_VII_7_1_riesz_compact_operator_spectrum
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℂ E] [CompleteSpace E]
    (hE : ¬FiniteDimensional ℂ E) (T : E →L[ℂ] E) (hT : IsCompactOperator T) :
    spectrum ℂ T = {0} ∨
      (∃ n : ℕ, 0 < n ∧ ∃ eig : Fin n → ℂ,
        Function.Injective eig ∧ (∀ i, eig i ≠ 0) ∧
        spectrum ℂ T = insert 0 (range eig) ∧
        ∀ i, (∃ x : E, x ≠ 0 ∧ T x = eig i • x) ∧
          FiniteDimensional ℂ
            (LinearMap.ker
              (T - eig i • ContinuousLinearMap.id ℂ E).toLinearMap)) ∨
      ∃ eig : ℕ → ℂ,
        Function.Injective eig ∧ (∀ n, eig n ≠ 0) ∧
        spectrum ℂ T = insert 0 (range eig) ∧ Tendsto eig atTop (𝓝 0) ∧
        ∀ n, (∃ x : E, x ≠ 0 ∧ T x = eig n • x) ∧
          FiniteDimensional ℂ
            (LinearMap.ker
              (T - eig n • ContinuousLinearMap.id ℂ E).toLinearMap) := by
  sorry

/-- Conway VIII.5.17, the Gelfand-Naimark representation theorem. -/
theorem conway_VIII_5_17_gelfand_naimark {A : Type u} [CStarAlgebra A] :
    (∃ (H : Type u) (_ : NormedAddCommGroup H) (_ : InnerProductSpace ℂ H)
      (_ : CompleteSpace H) (π : A →⋆ₐ[ℂ] (H →L[ℂ] H)), Isometry π) ∧
    (TopologicalSpace.SeparableSpace A →
      ∃ (H : Type u) (_ : NormedAddCommGroup H) (_ : InnerProductSpace ℂ H)
        (_ : CompleteSpace H) (_ : TopologicalSpace.SeparableSpace H)
        (π : A →⋆ₐ[ℂ] (H →L[ℂ] H)), Isometry π) := by
  sorry

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

/-- Conway II.7.6, the spectral theorem for compact normal operators. -/
theorem conway_II_7_6_compact_normal_spectral_theorem
    {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
    (T : H →L[ℂ] H) (hnormal : T.adjoint.comp T = T.comp T.adjoint)
    (hcompact : IsCompactOperator T) :
    ∃ (ι : Type) (_ : Countable ι) (eigenvalue : ι → ℂ)
      (projection : ι → H →L[ℂ] H),
      (∀ i, eigenvalue i ≠ 0) ∧ Function.Injective eigenvalue ∧
      (∀ i, projection i ≠ 0) ∧ (∀ i, IsOrthogonalProjection (projection i)) ∧
      Pairwise (fun i j ↦ (projection i).comp (projection j) = 0) ∧
      (∀ i, LinearMap.range (projection i).toLinearMap =
        LinearMap.ker (T - eigenvalue i • ContinuousLinearMap.id ℂ H).toLinearMap) ∧
      (∀ ε : ℝ, 0 < ε → {i : ι | ε ≤ ‖eigenvalue i‖}.Finite) ∧
      HasSum (fun i ↦ eigenvalue i • projection i) T := by
  sorry

/-- Conway IX.2.2, the spectral theorem for bounded normal operators. -/
theorem conway_IX_2_2_bounded_normal_spectral_theorem
    {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
    (T : H →L[ℂ] H) (hnormal : T.adjoint.comp T = T.comp T.adjoint) :
    ∃! E : ProjectionValuedMeasure H,
      E.toFun (spectrum ℂ T) = ContinuousLinearMap.id ℂ H ∧
      (∃ scalarMeasure : H → H → ComplexMeasure ℂ,
        (∀ x y : H, ∀ B : Set ℂ, MeasurableSet B →
          scalarMeasure x y B = inner ℂ (E.toFun B x) y) ∧
        ∀ x y : H, inner ℂ (T x) y =
          ∫ᵛ z, z ∂[ContinuousLinearMap.mul ℝ ℂ; scalarMeasure x y]) ∧
      (∀ G : Set ℂ, G.Nonempty →
        (∃ O : Set ℂ, IsOpen O ∧ G = O ∩ spectrum ℂ T) → E.toFun G ≠ 0) ∧
      ∀ A : H →L[ℂ] H,
        (A.comp T = T.comp A ∧ A.comp T.adjoint = T.adjoint.comp A) ↔
          ∀ Δ : Set ℂ, MeasurableSet Δ → A.comp (E.toFun Δ) = (E.toFun Δ).comp A := by
  sorry

/-- Conway X.5.6, Stone's theorem for strongly continuous unitary groups. -/
theorem conway_X_5_6_stone_theorem
    {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
    (U : ℝ → H →L[ℂ] H) (hU : StronglyContinuousUnitaryGroup U) :
    ∃! A : DenselyDefinedOperator H, IsSelfAdjointUnbounded A ∧
      ∀ x : A.domain, HasDerivAt (fun t : ℝ ↦ U t x) (Complex.I • A.op x) 0 := by
  sorry

end ConwayFunctionalAnalysis
end Dataset
