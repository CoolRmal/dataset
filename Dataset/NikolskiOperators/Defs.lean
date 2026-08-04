module

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
# Shared definitions for the NikolskiOperators problems

Custom notions used by the statement files in `Dataset/NikolskiOperators/` that are
not already supplied by Mathlib. Each problem file that needs them imports
this module.
-/

@[expose] public section

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

/-- The radial limit defining the boundary value exists almost everywhere. -/
def HasRadialBoundaryValues (f : ℂ → ℂ) : Prop :=
  ∀ᵐ t ∂volume.restrict (Set.Ioc 0 (2 * Real.pi)),
    Tendsto (fun r : ℝ ↦ f (r • (unitCirclePoint t).1)) (𝓝[<] 1)
      (𝓝 (boundaryValue f (unitCirclePoint t)))

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

/-- Lebesgue measure on one angular parametrization of the unit circle. -/
noncomputable abbrev circleMeasure : Measure ℝ :=
  volume.restrict (Set.Ioc 0 (2 * Real.pi))

/-- The Fourier coefficient of an angular representative of a circle function. -/
noncomputable def angularFourierCoefficient (f : ℝ → ℂ) (k : ℤ) : ℂ :=
  (2 * Real.pi : ℂ)⁻¹ * ∫ t in Set.Ioc 0 (2 * Real.pi),
    f t * Complex.exp (-Complex.I * k * t)

/-- The boundary-value model of `H²`: square integrable with no negative frequencies. -/
def HardyBoundaryFunction (f : ℝ → ℂ) : Prop :=
  MemLp f 2 circleMeasure ∧ ∀ k : ℤ, k < 0 → angularFourierCoefficient f k = 0

/-- A set of angular representatives is an a.e.-saturated complex `L²` subspace. -/
def IsCircleL2Subspace (E : Set (ℝ → ℂ)) : Prop :=
  (0 : ℝ → ℂ) ∈ E ∧
    (∀ a b : ℂ, ∀ f g : ℝ → ℂ, f ∈ E → g ∈ E → a • f + b • g ∈ E) ∧
    (∀ f ∈ E, MemLp f 2 circleMeasure) ∧
    ∀ f g : ℝ → ℂ, f ∈ E → f =ᵐ[circleMeasure] g → g ∈ E

/-- A unimodular multiplier generates a circle `L²` subspace from boundary `H²`. -/
def UnimodularGeneratedSubspace (E : Set (ℝ → ℂ)) (theta : ℝ → ℂ) : Prop :=
  AEStronglyMeasurable theta circleMeasure ∧
    (∀ᵐ t ∂circleMeasure, ‖theta t‖ = 1) ∧
    E = {f : ℝ → ℂ | ∃ h : ℝ → ℂ, HardyBoundaryFunction h ∧
      f =ᵐ[circleMeasure] fun t ↦ theta t * h t}

/-- Shift-invariance for coefficient subspaces of `H²`. -/
def ShiftInvariant (M : Set (ℕ → ℂ)) : Prop :=
  ∀ f ∈ M, (fun n : ℕ ↦ if n = 0 then 0 else f (n - 1)) ∈ M

/-- Inner functions: bounded analytic functions with unimodular boundary values almost
everywhere. -/
def InnerFunction (θ : ℂ → ℂ) : Prop :=
  HardyClass ⊤ θ ∧ HasRadialBoundaryValues θ ∧
    ∀ᵐ t ∂volume.restrict (Set.Ioc 0 (2 * Real.pi)),
      ‖boundaryValue θ (unitCirclePoint t)‖ = 1

/-- Outer functions, given by the standard exponential Poisson-integral representation. -/
def OuterFunction (p : ℝ≥0∞) (g : ℂ → ℂ) : Prop :=
  HardyClass p g ∧ HasRadialBoundaryValues g ∧ ∃ c : ℂ, ‖c‖ = 1 ∧
    ∀ z ∈ Metric.ball (0 : ℂ) 1,
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
  limUnder atTop fun N : ℕ ↦ Complex.re <|
    ∑ k ∈ Finset.Icc (-(N : ℤ)) N,
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

/-- A sequence enumerates all zeros of an analytic function with their multiplicities. -/
def HasZeroSequence (f : ℂ → ℂ) (a : ℕ → ℂ) : Prop :=
  (∀ n, a n ∈ Metric.ball (0 : ℂ) 1) ∧
    ∀ z ∈ Metric.ball (0 : ℂ) 1,
      {n : ℕ | a n = z}.Finite ∧
        ∃ k : ℕ, (∀ j < k, iteratedDeriv j f z = 0) ∧ iteratedDeriv k f z ≠ 0 ∧
          {n : ℕ | a n = z}.ncard = k

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

/-- A Hankel matrix has rank at most `n`, exhibited by a factorization through `Fin n`. -/
def HankelMatrixRankLE (n : ℕ) (b : ℕ → ℂ) : Prop :=
  ∃ u v : Fin n → ℕ → ℂ,
    (∀ q, HardySquareSummable (u q) ∧ HardySquareSummable (v q)) ∧
      ∀ i j, b (i + j) = ∑ q, u q i * v q j

/-- An arbitrary infinite matrix has rank at most `n`, witnessed by a factorization through
`Fin n`. -/
def MatrixRankLE (n : ℕ) (B : ℕ → ℕ → ℂ) : Prop :=
  ∃ u v : Fin n → ℕ → ℂ,
    (∀ q, HardySquareSummable (u q) ∧ HardySquareSummable (v q)) ∧
      ∀ i j, B i j = ∑ q, u q i * v q j

/-- The `n`th approximation number of a Hankel form: distance to arbitrary matrices of rank at
most `n`. -/
noncomputable def hankelApproximationNumber (a : ℕ → ℂ) (n : ℕ) : ℝ≥0∞ :=
  sInf {C : ℝ≥0∞ | C < ∞ ∧ ∃ B : ℕ → ℕ → ℂ, MatrixRankLE n B ∧
    ∀ N : ℕ, ∀ x y : ℕ → ℂ,
      ‖∑ i ∈ Finset.range N, ∑ j ∈ Finset.range N,
        x i * (a (i + j) - B i j) * y j‖ ≤
      C.toReal * (∑ i ∈ Finset.range N, ‖x i‖ ^ 2) ^ (1 / 2 : ℝ) *
        (∑ j ∈ Finset.range N, ‖y j‖ ^ 2) ^ (1 / 2 : ℝ)}

/-- Distance from a Hankel form to Hankel forms of rank at most `n`. -/
noncomputable def hankelRankApproximationDistance (a : ℕ → ℂ) (n : ℕ) : ℝ≥0∞ :=
  sInf {C : ℝ≥0∞ | C < ∞ ∧ ∃ b : ℕ → ℂ, HankelMatrixRankLE n b ∧
    ∀ N : ℕ, ∀ x y : ℕ → ℂ,
      ‖∑ i ∈ Finset.range N, ∑ j ∈ Finset.range N,
        x i * (a (i + j) - b (i + j)) * y j‖ ≤
      C.toReal * (∑ i ∈ Finset.range N, ‖x i‖ ^ 2) ^ (1 / 2 : ℝ) *
        (∑ j ∈ Finset.range N, ‖y j‖ ^ 2) ^ (1 / 2 : ℝ)}

/-- Boundary values of rational functions vanishing at infinity, with at most `n` poles in the
unit disk counted with multiplicity. -/
def RationalVanishingAtInfinityDegreeLE (n : ℕ)
    (ψ : {z : ℂ // ‖z‖ = 1} → ℂ) : Prop :=
  ψ = 0 ∨ ∃ numerator denominator : Polynomial ℂ,
      numerator.natDegree < denominator.natDegree ∧ denominator.natDegree ≤ n ∧
        denominator ≠ 0 ∧
        (∀ z : ℂ, denominator.IsRoot z → z ∈ Metric.ball (0 : ℂ) 1) ∧
        ∀ ζ, ψ ζ = numerator.eval ζ.1 / denominator.eval ζ.1

/-- Essential-supremum distance from a symbol to `Rₙ + H∞`. -/
noncomputable def rationalPlusHInfinityDistance
    (φ : {z : ℂ // ‖z‖ = 1} → ℂ) (n : ℕ) : ℝ≥0∞ :=
  sInf {C : ℝ≥0∞ | ∃ (ψ : {z : ℂ // ‖z‖ = 1} → ℂ) (h : ℂ → ℂ),
    RationalVanishingAtInfinityDegreeLE n ψ ∧ HardyClass ⊤ h ∧
      eLpNorm (fun t : ℝ ↦ φ (unitCirclePoint t) - ψ (unitCirclePoint t) -
        boundaryValue h (unitCirclePoint t)) ∞
        (volume.restrict (Set.Ioc 0 (2 * Real.pi))) ≤ C}

/-- A finite Blaschke product of degree at most `n`. -/
def FiniteBlaschkeProductDegreeLE (n : ℕ) (B : ℂ → ℂ) : Prop :=
  ∃ (m : ℕ) (_ : m ≤ n) (a : Fin m → ℂ) (c : ℂ), ‖c‖ = 1 ∧
    (∀ i, a i ∈ Metric.ball (0 : ℂ) 1) ∧ InnerFunction B ∧
      ∀ z ∈ Metric.ball (0 : ℂ) 1,
        B z = c * ∏ i, (z - a i) / (1 - star (a i) * z)

/-- Minimum norm of the Hankel operators with symbols `conj(B) * φ`, for finite Blaschke
products `B` of degree at most `n`. -/
noncomputable def finiteBlaschkeHankelDistance
    (φ : {z : ℂ // ‖z‖ = 1} → ℂ) (n : ℕ) : ℝ≥0∞ :=
  sInf {C : ℝ≥0∞ | ∃ (B : ℂ → ℂ) (b : ℕ → ℂ),
    FiniteBlaschkeProductDegreeLE n B ∧
      HasBoundedHankelSymbol b (fun ζ ↦ star (boundaryValue B ζ) * φ ζ) ∧
      hankelFormNorm b = C}

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
    (T : ℓ²(ℕ, ℂ) →L[ℂ] ℓ²(ℕ, ℂ)) : Prop :=
  ∀ f n, T f n = ∑' j : ℕ, circleFourierCoefficient φ ((n : ℤ) - j) * f j

/-- An essentially bounded measurable function on the unit circle. -/
def EssentiallyBoundedCircleSymbol (u : {z : ℂ // ‖z‖ = 1} → ℂ) : Prop :=
  AEStronglyMeasurable (fun t : ℝ ↦ u (unitCirclePoint t))
      (volume.restrict (Set.Ioc 0 (2 * Real.pi))) ∧
    eLpNorm (fun t : ℝ ↦ u (unitCirclePoint t)) ∞
      (volume.restrict (Set.Ioc 0 (2 * Real.pi))) < ∞

/-- A circle symbol is unimodular when its modulus is one almost everywhere. -/
def IsUnimodularCircleSymbol (u : {z : ℂ // ‖z‖ = 1} → ℂ) : Prop :=
  ∀ᵐ t ∂volume.restrict (Set.Ioc 0 (2 * Real.pi)), ‖u (unitCirclePoint t)‖ = 1

end NikolskiOperators
end Dataset
