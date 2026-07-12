import Mathlib.Analysis.Calculus.Deriv.Basic
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
# Hard Hardy/Hankel/Toeplitz statement dataset

This file contains ten statement-only formalizations selected from Nikolai K.
Nikol'ski, *Operators, Functions, and Systems: An Easy Reading*, Volume 1,
*Hardy, Hankel, and Toeplitz*. They are chosen as hard autoformalization targets
because the statements mix Hardy-space boundary behavior, factorization,
interpolation matrices, Hankel and Toeplitz symbols, singular numbers, and
meromorphic approximation.
-/

open Filter MeasureTheory Set Topology

open scoped BigOperators ENNReal Interval lp Topology

namespace Dataset
namespace NikolskiOperators

/-- Boundary values, represented in this dataset by evaluating on the unit circle. -/
noncomputable def boundaryValue (f : ℂ → ℂ) (ζ : {z : ℂ // ‖z‖ = 1}) : ℂ :=
  limUnder (𝓝[<] (1 : ℝ)) fun r ↦ f (r • ζ.1)

/-- Standard angular parametrization of the unit circle. -/
noncomputable def unitCirclePoint (t : ℝ) : {z : ℂ // ‖z‖ = 1} :=
  ⟨Complex.exp (Complex.I * t), by rw [Complex.norm_exp]; simp⟩

/-- Analytic Hardy-class functions, using uniformly bounded radial `L^p` norms. -/
def HardyClass (p : ℝ≥0∞) (f : ℂ → ℂ) : Prop :=
  DifferentiableOn ℂ f (Metric.ball (0 : ℂ) 1) ∧
    ∃ C : ℝ≥0∞, C < ∞ ∧ ∀ r : ℝ, 0 ≤ r → r < 1 →
      eLpNorm (fun t : ℝ ↦ f (r • (unitCirclePoint t).1)) p
        (volume.restrict (Set.Ioc 0 (2 * Real.pi))) ≤ C

/-- A sequence is the Taylor coefficient sequence of an analytic function on the disk. -/
def HasTaylorSeries (f : ℂ → ℂ) (a : ℕ → ℂ) : Prop :=
  ∀ z ∈ Metric.ball (0 : ℂ) 1, HasSum (fun n : ℕ ↦ a n * z ^ n) (f z)

/-- Square-summable Taylor coefficient sequences, used as a model for `H²`. -/
def HardySquareSummable (a : ℕ → ℂ) : Prop :=
  Summable fun n : ℕ ↦ ‖a n‖ ^ 2

/-- The Cauchy product of two Taylor coefficient sequences. -/
noncomputable def CauchyProduct (a b : ℕ → ℂ) : ℕ → ℂ :=
  fun n : ℕ ↦ Finset.sum (Finset.range (n + 1)) (fun k ↦ a k * b (n - k))

/-- A set of Taylor coefficient sequences is a complex linear subspace. -/
def IsComplexLinearSubspace (M : Set (ℕ → ℂ)) : Prop :=
  (0 : ℕ → ℂ) ∈ M ∧
    ∀ a b : ℂ, ∀ f g : ℕ → ℂ, f ∈ M → g ∈ M → a • f + b • g ∈ M

/-- Shift-invariance for coefficient subspaces of `H²`. -/
def ShiftInvariant (M : Set (ℕ → ℂ)) : Prop :=
  ∀ f ∈ M, (fun n : ℕ ↦ if n = 0 then 0 else f (n - 1)) ∈ M

/-- Inner functions: bounded analytic functions with unimodular boundary values almost
everywhere. -/
def InnerFunction (θ : ℂ → ℂ) : Prop :=
  HardyClass ⊤ θ ∧
    ∀ᵐ t ∂volume.restrict (Set.Ioc 0 (2 * Real.pi)),
      ‖boundaryValue θ (unitCirclePoint t)‖ = 1

/-- Outer functions, given by the standard exponential Poisson-integral representation. -/
def OuterFunction (p : ℝ≥0∞) (g : ℂ → ℂ) : Prop :=
  HardyClass p g ∧ ∃ c : ℂ, ‖c‖ = 1 ∧ ∀ z ∈ Metric.ball (0 : ℂ) 1,
    g z = c * Complex.exp
      ((2 * Real.pi : ℂ)⁻¹ *
        ∫ t in Set.Ioc 0 (2 * Real.pi),
          ((unitCirclePoint t).1 + z) / ((unitCirclePoint t).1 - z) *
            Real.log ‖boundaryValue g (unitCirclePoint t)‖)

/-- The trigonometric polynomial with Fourier coefficient sequence `c`. -/
noncomputable def trigonometricPolynomial (c : ℤ → ℂ) (t : ℝ) : ℂ :=
  ∑' k : ℤ, c k * Complex.exp (Complex.I * k * t)

/-- Its squared norm in the weighted space `L²(w dm)`. -/
noncomputable def weightedL2NormSq (w : {z : ℂ // ‖z‖ = 1} → ℝ) (c : ℤ → ℂ) : ℝ :=
  ∫ t in Set.Ioc 0 (2 * Real.pi),
    ‖trigonometricPolynomial c t‖ ^ 2 * w (unitCirclePoint t)

/-- The nonnegative-frequency part of a Fourier coefficient sequence. -/
def analyticFourierPart (c : ℤ → ℂ) (k : ℤ) : ℂ :=
  if 0 ≤ k then c k else 0

/-- The circle Hilbert transform, encoded by its Fourier multiplier. -/
noncomputable def circleHilbertTransform (v : {z : ℂ // ‖z‖ = 1} → ℝ) (t : ℝ) : ℝ :=
  Complex.re <| ∑' k : ℤ,
    (if k = 0 then 0 else if 0 < k then -Complex.I else Complex.I) *
      ((2 * Real.pi : ℂ)⁻¹ * ∫ s in Set.Ioc 0 (2 * Real.pi),
        (v (unitCirclePoint s) : ℂ) * Complex.exp (-Complex.I * k * s)) *
        Complex.exp (Complex.I * k * t)

/-- The coefficient subspace `θ H²`, expressed through Cauchy products. -/
def InnerGeneratedSubspace (M : Set (ℕ → ℂ)) (hθ : ℕ → ℂ) : Prop :=
  HardySquareSummable hθ ∧
    M = {f : ℕ → ℂ | ∃ g : ℕ → ℂ, HardySquareSummable g ∧ f = CauchyProduct hθ g}

/-- Blaschke summability for a sequence in the disk. -/
def BlaschkeCondition (a : ℕ → ℂ) : Prop :=
  (∀ n : ℕ, a n ∈ Metric.ball (0 : ℂ) 1) ∧ Summable (fun n : ℕ ↦ 1 - ‖a n‖)

/-- Schur-class functions on the disk. -/
def SchurFunction (f : ℂ → ℂ) : Prop :=
  HardyClass ⊤ f ∧ ∀ z ∈ Metric.ball (0 : ℂ) 1, ‖f z‖ ≤ 1

/-- The Pick matrix for finite Nevanlinna-Pick interpolation data. -/
noncomputable def PickMatrix {n : ℕ} (z w : Fin n → ℂ) : Matrix (Fin n) (Fin n) ℂ :=
  fun i j ↦ (1 - w i * star (w j)) / (1 - z i * star (z j))

/-- Positive semidefiniteness of a complex matrix, phrased by quadratic forms. -/
def PositiveSemidefiniteMatrix {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) : Prop :=
  ∀ c : Fin n → ℂ, 0 ≤ Complex.re (∑ i, ∑ j, star (c i) * A i j * c j)

/-- Boundedness of the Hankel form with entries `a_{i+j}` on finite sections. -/
def BoundedHankelForm (a : ℕ → ℂ) : Prop :=
  ∃ C : ℝ, 0 ≤ C ∧ ∀ N : ℕ, ∀ x y : ℕ → ℂ,
    ‖Finset.sum (Finset.range N)
      (fun i ↦ Finset.sum (Finset.range N) (fun j ↦ x i * a (i + j) * y j))‖ ^ 2 ≤
      C ^ 2 * Finset.sum (Finset.range N) (fun i ↦ ‖x i‖ ^ 2) *
        Finset.sum (Finset.range N) (fun j ↦ ‖y j‖ ^ 2)

/-- The integer Fourier coefficient of a circle function. -/
noncomputable def circleFourierCoefficient
    (φ : {z : ℂ // ‖z‖ = 1} → ℂ) (k : ℤ) : ℂ :=
  (2 * Real.pi : ℂ)⁻¹ *
    ∫ t in Set.Ioc 0 (2 * Real.pi),
      φ (unitCirclePoint t) * Complex.exp (-Complex.I * k * t)

/-- A bounded symbol with the prescribed negative Fourier coefficients. -/
def HasBoundedHankelSymbol (a : ℕ → ℂ) (φ : {z : ℂ // ‖z‖ = 1} → ℂ) : Prop :=
  AEStronglyMeasurable (fun t : ℝ ↦ φ (unitCirclePoint t))
      (volume.restrict (Set.Ioc 0 (2 * Real.pi))) ∧
    eLpNorm (fun t : ℝ ↦ φ (unitCirclePoint t)) ∞
      (volume.restrict (Set.Ioc 0 (2 * Real.pi))) < ∞ ∧
    ∀ n : ℕ, circleFourierCoefficient φ (-((n : ℤ) + 1)) = a n

/-- The operator norm of a bounded Hankel form, defined from its finite sections. -/
noncomputable def hankelFormNorm (a : ℕ → ℂ) : ℝ≥0∞ :=
  sInf {C : ℝ≥0∞ | C < ∞ ∧ ∀ N : ℕ, ∀ x y : ℕ → ℂ,
    ‖Finset.sum (Finset.range N)
      (fun i ↦ Finset.sum (Finset.range N) (fun j ↦ x i * a (i + j) * y j))‖ ≤
      C.toReal * (Finset.sum (Finset.range N) (fun i ↦ ‖x i‖ ^ 2)) ^ (1 / 2 : ℝ) *
        (Finset.sum (Finset.range N) (fun j ↦ ‖y j‖ ^ 2)) ^ (1 / 2 : ℝ)}

/-- Essential-supremum distance of a circle symbol from bounded analytic boundary values. -/
noncomputable def symbolDistanceToHInfinity (φ : {z : ℂ // ‖z‖ = 1} → ℂ) : ℝ≥0∞ :=
  sInf {r : ℝ≥0∞ | ∃ h : ℂ → ℂ, HardyClass ⊤ h ∧
    eLpNorm (fun t : ℝ ↦
      φ (unitCirclePoint t) - boundaryValue h (unitCirclePoint t)) ∞
        (volume.restrict (Set.Ioc 0 (2 * Real.pi))) ≤ r}

/-- Compactness of a Hankel form, expressed by small operator-norm tails. -/
def CompactHankel (a : ℕ → ℂ) : Prop :=
  BoundedHankelForm a ∧ ∀ ε : ℝ, 0 < ε → ∃ N : ℕ, ∀ M : ℕ, ∀ x y : ℕ → ℂ,
    ‖∑ i ∈ Finset.Icc N M,
      ∑ j ∈ Finset.Icc N M, x i * a (i + j) * y j‖ ≤
      ε * (∑ i ∈ Finset.Icc N M, ‖x i‖ ^ 2) ^ (1 / 2 : ℝ) *
        (∑ j ∈ Finset.Icc N M, ‖y j‖ ^ 2) ^ (1 / 2 : ℝ)

/-- Symbols in `H∞ + C`, the Hartman compactness class for Hankel operators. -/
def InHInfinityPlusContinuous (φ : {z : ℂ // ‖z‖ = 1} → ℂ) : Prop :=
  ∃ h : ℂ → ℂ, ∃ c : {z : ℂ // ‖z‖ = 1} → ℂ,
    HardyClass ⊤ h ∧ Continuous c ∧
    ∀ ζ : {z : ℂ // ‖z‖ = 1}, φ ζ = boundaryValue h ζ + c ζ

/-- The Toeplitz matrix formula for an operator on `H²`. -/
def RepresentsToeplitzOperator (φ : {z : ℂ // ‖z‖ = 1} → ℂ)
    (T : ℓ²(ℕ, ℂ) → ℓ²(ℕ, ℂ)) : Prop :=
  (∀ f g, T (f + g) = T f + T g) ∧
    (∀ (c : ℂ) f, T (c • f) = c • T f) ∧
    Continuous T ∧ ∀ f n,
      T f n = ∑' j : ℕ, circleFourierCoefficient φ ((n : ℤ) - j) * f j

/-- An essentially bounded measurable function on the unit circle. -/
def EssentiallyBoundedCircleSymbol (u : {z : ℂ // ‖z‖ = 1} → ℂ) : Prop :=
  AEStronglyMeasurable (fun t : ℝ ↦ u (unitCirclePoint t))
      (volume.restrict (Set.Ioc 0 (2 * Real.pi))) ∧
    eLpNorm (fun t : ℝ ↦ u (unitCirclePoint t)) ∞
      (volume.restrict (Set.Ioc 0 (2 * Real.pi))) < ∞

/-- A circle symbol is unimodular when its modulus is one almost everywhere. -/
def IsUnimodularCircleSymbol (u : {z : ℂ // ‖z‖ = 1} → ℂ) : Prop :=
  ∀ᵐ t ∂volume.restrict (Set.Ioc 0 (2 * Real.pi)), ‖u (unitCirclePoint t)‖ = 1

/--
Nikol'ski, *Operators, Functions, and Systems*, Volume 1, Part A, Section 1.3:
Beurling's invariant subspace theorem for `H²`: every nonzero closed
shift-invariant subspace is generated by an inner function.
-/
theorem nikolski_A_1_3_beurling_invariant_subspaces
    {M : Set (ℕ → ℂ)}
    (hlinear : IsComplexLinearSubspace M) (hclosed : IsClosed M)
    (hshift : ShiftInvariant M) (hne : ∃ f ∈ M, f ≠ 0) :
    ∃ θ : ℂ → ℂ, ∃ hθ : ℕ → ℂ,
      InnerFunction θ ∧ HasTaylorSeries θ hθ ∧ InnerGeneratedSubspace M hθ ∧
        ∀ η : ℂ → ℂ, ∀ hη : ℕ → ℂ,
          InnerFunction η → HasTaylorSeries η hη → InnerGeneratedSubspace M hη →
            ∃ c : ℂ, ‖c‖ = 1 ∧ ∀ z ∈ Metric.ball (0 : ℂ) 1, η z = c * θ z := by
  sorry

/--
Nikol'ski, *Operators, Functions, and Systems*, Volume 1, Part A, Theorem 2.4.1:
inner-outer factorization in `H²`.
-/
theorem nikolski_A_2_4_inner_outer_factorization
    {f : ℂ → ℂ} (hf : HardyClass 2 f) (hnonzero : ∃ z, f z ≠ 0) :
    ∃ θ g : ℂ → ℂ, InnerFunction θ ∧ OuterFunction 2 g ∧
      (∀ z ∈ Metric.ball (0 : ℂ) 1, f z = θ z * g z) ∧
      ∀ θ' g' : ℂ → ℂ, InnerFunction θ' → OuterFunction 2 g' →
        (∀ z ∈ Metric.ball (0 : ℂ) 1, f z = θ' z * g' z) →
          ∃ c : ℂ, ‖c‖ = 1 ∧ ∀ z ∈ Metric.ball (0 : ℂ) 1,
            θ' z = c * θ z ∧ g' z = star c * g z := by
  sorry

/--
Nikol'ski, *Operators, Functions, and Systems*, Volume 1, Part A, Section 3.6:
boundary uniqueness for Hardy classes: if the boundary values of a Hardy
function vanish on a positive boundary set, then the function is identically zero.
-/
theorem nikolski_A_3_6_boundary_uniqueness
    {p : ℝ≥0∞} {f : ℂ → ℂ} (hp : p ≠ 0) (hf : HardyClass p f) :
    ((∃ z ∈ Metric.ball (0 : ℂ) 1, f z ≠ 0) →
      IntegrableOn (fun t : ℝ ↦
        Real.log ‖boundaryValue f (unitCirclePoint t)‖) (Set.Ioc 0 (2 * Real.pi))) ∧
    ∀ E : Set {z : ℂ // ‖z‖ = 1},
      0 < volume {t ∈ Set.Ioc 0 (2 * Real.pi) | unitCirclePoint t ∈ E} →
        (∀ ζ ∈ E, boundaryValue f ζ = 0) → ∀ z ∈ Metric.ball (0 : ℂ) 1, f z = 0 := by
  sorry

/--
Nikol'ski, *Operators, Functions, and Systems*, Volume 1, Part A, Section 3.7:
the zero sets of nontrivial Hardy-class functions are precisely Blaschke
sequences in the disk.
-/
theorem nikolski_A_3_7_blaschke_zero_sets
    {p : ℝ≥0∞} {a : ℕ → ℂ} :
    (∃ f : ℂ → ℂ, HardyClass p f ∧ (∃ z, f z ≠ 0) ∧
      ∀ z ∈ Metric.ball (0 : ℂ) 1, f z = 0 ↔ z ∈ range a) ↔
      BlaschkeCondition a := by
  sorry

/--
Nikol'ski, *Operators, Functions, and Systems*, Volume 1, Part A, Section 5.4:
the Helson-Szego theorem, in Hardy-space language: the exponential system is a
basis in weighted `L²(T, μ)` exactly when the weight admits the Helson-Szego
factorization.
-/
theorem nikolski_A_5_4_helson_szego
    {w : {z : ℂ // ‖z‖ = 1} → ℝ} :
    let basis := ∃ A B : ℝ, 0 < A ∧ A ≤ B ∧ ∀ c : ℤ → ℂ, c.support.Finite →
      A * ∑' k : ℤ, ‖c k‖ ^ 2 ≤ weightedL2NormSq w c ∧
        weightedL2NormSq w c ≤ B * ∑' k : ℤ, ‖c k‖ ^ 2
    let boundedProjection := ∃ C : ℝ, 0 ≤ C ∧ ∀ c : ℤ → ℂ, c.support.Finite →
      weightedL2NormSq w (analyticFourierPart c) ≤ C ^ 2 * weightedL2NormSq w c
    let positiveAngle := ∃ δ : ℝ, 0 < δ ∧ ∀ plus minus : ℤ → ℂ,
      plus.support.Finite → minus.support.Finite →
        (∀ k, plus k ≠ 0 → 0 ≤ k) → (∀ k, minus k ≠ 0 → k < 0) →
          δ * weightedL2NormSq w plus ≤
            weightedL2NormSq w (fun k ↦ plus k + minus k)
    let outerDistance := ∃ h q : ℂ → ℂ, OuterFunction 2 h ∧ HardyClass ⊤ q ∧
      (∀ᵐ t ∂volume.restrict (Set.Ioc 0 (2 * Real.pi)),
        w (unitCirclePoint t) = ‖boundaryValue h (unitCirclePoint t)‖ ^ 2) ∧
      eLpNorm (fun t : ℝ ↦ star (boundaryValue h (unitCirclePoint t)) /
        boundaryValue h (unitCirclePoint t) - boundaryValue q (unitCirclePoint t)) ∞
        (volume.restrict (Set.Ioc 0 (2 * Real.pi))) < 1
    let helsonSzego := ∃ u v : {z : ℂ // ‖z‖ = 1} → ℝ,
      eLpNorm (fun t : ℝ ↦ u (unitCirclePoint t)) ∞
          (volume.restrict (Set.Ioc 0 (2 * Real.pi))) < ∞ ∧
        eLpNorm (fun t : ℝ ↦ v (unitCirclePoint t)) ∞
          (volume.restrict (Set.Ioc 0 (2 * Real.pi))) < ENNReal.ofReal (Real.pi / 2) ∧
        ∀ᵐ t ∂volume.restrict (Set.Ioc 0 (2 * Real.pi)),
          w (unitCirclePoint t) =
            Real.exp (u (unitCirclePoint t) + circleHilbertTransform v t)
    List.TFAE [basis, boundedProjection, positiveAngle, outerDistance, helsonSzego] := by
  sorry

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

/--
Nikol'ski, *Operators, Functions, and Systems*, Volume 1, Part B, Section 3.2:
Nevanlinna-Pick interpolation: finite disk data admit a Schur-class interpolant
if and only if the Pick matrix is positive semidefinite.
-/
theorem nikolski_B_3_2_nevanlinna_pick_interpolation
    {n : ℕ} {z w : Fin n → ℂ} (hz : ∀ i : Fin n, z i ∈ Metric.ball (0 : ℂ) 1) :
    let solutions := {f : ℂ → ℂ | SchurFunction f ∧ ∀ i : Fin n, f (z i) = w i}
    (solutions.Nonempty ↔ PositiveSemidefiniteMatrix (PickMatrix z w)) ∧
      (solutions.Nonempty →
        (solutions.Subsingleton ↔ Matrix.det (PickMatrix z w) = 0)) := by
  sorry

/-- Nikol'ski, Part B, Lemma 4.3.3 (Devinatz–Widom criterion). -/
theorem nikolski_B_4_3_3_devinatz_widom
    {u : {z : ℂ // ‖z‖ = 1} → ℂ}
    (hu : EssentiallyBoundedCircleSymbol u) (hmod : IsUnimodularCircleSymbol u) :
    let a := ∃ T : ℓ²(ℕ, ℂ) → ℓ²(ℕ, ℂ),
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

/-- Nikol'ski, Part B, Theorem 7.2.1 (Adamyan–Arov–Krein). -/
theorem nikolski_B_7_2_1_adamyan_arov_krein
    {a : ℕ → ℂ} {φ : {z : ℂ // ‖z‖ = 1} → ℂ} {n : ℕ} :
    HasBoundedHankelSymbol a φ →
      ∀ r : ℝ,
        (0 ≤ r ∧ r = sInf {C : ℝ | 0 ≤ C ∧ ∃ b : ℕ → ℂ, BoundedHankelForm b ∧
          ∃ correction : Fin n → ℕ → ℂ, ∀ N : ℕ, ∀ x y : ℕ → ℂ,
            ‖∑ i ∈ Finset.range N, ∑ j ∈ Finset.range N,
              x i * (a (i + j) - b (i + j) - ∑ q, correction q i * correction q j) * y j‖ ≤
              C * (∑ i ∈ Finset.range N, ‖x i‖ ^ 2) ^ (1 / 2 : ℝ) *
                (∑ j ∈ Finset.range N, ‖y j‖ ^ 2) ^ (1 / 2 : ℝ)}) ↔
        (0 ≤ r ∧ r = sInf {C : ℝ | 0 ≤ C ∧
          ∃ ψ : {z : ℂ // ‖z‖ = 1} → ℂ,
            (∃ numerator denominator : Polynomial ℂ, denominator.natDegree ≤ n ∧
              (∀ ζ : {z : ℂ // ‖z‖ = 1}, denominator.eval ζ.1 ≠ 0) ∧
              ∀ ζ : {z : ℂ // ‖z‖ = 1},
                ψ ζ = numerator.eval ζ.1 / denominator.eval ζ.1) ∧
            eLpNorm (fun t : ℝ ↦ φ (unitCirclePoint t) - ψ (unitCirclePoint t)) ∞
              (volume.restrict (Set.Ioc 0 (2 * Real.pi))) ≤ ENNReal.ofReal C}) := by
  sorry

end NikolskiOperators
end Dataset
