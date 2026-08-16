import Mathlib.Analysis.Calculus.IteratedDeriv.Defs
import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
import Mathlib.MeasureTheory.Measure.Hausdorff

/-!
# Shared definitions for the KrylovHolder problems

Custom notions used by the statement files in `Dataset/KrylovHolder/` that are
not already supplied by Mathlib. Each problem file that needs them imports
this module.
-/

open MeasureTheory Set
open scoped ContDiff ENNReal Topology

namespace Dataset
namespace KrylovHolder

/-- Repeated coordinate directional differentiation along a list of coordinate axes. -/
noncomputable def directionalDerivativeList {d : ℕ} :
    List (Fin d) → (EuclideanSpace ℝ (Fin d) → ℝ) → EuclideanSpace ℝ (Fin d) → ℝ
  | [], u => u
  | i :: indices, u => fun x ↦
      fderiv ℝ (directionalDerivativeList indices u) x (EuclideanSpace.single i 1)

/-- A deterministic list containing coordinate `i` exactly `α i` times. -/
noncomputable def multiIndexDirections {d : ℕ} (α : (Fin d → ℕ)) : List (Fin d) :=
  Finset.univ.toList.flatMap fun i ↦ List.replicate (α i) i

/-- The classical mixed derivative selected by a multi-index. -/
noncomputable def multiDerivative {d : ℕ} (α : (Fin d → ℕ))
    (u : EuclideanSpace ℝ (Fin d) → ℝ) : EuclideanSpace ℝ (Fin d) → ℝ :=
  directionalDerivativeList (multiIndexDirections α) u

/-- The Laplacian as the sum of the repeated coordinate derivatives. -/
noncomputable def laplacian {d : ℕ} (u : EuclideanSpace ℝ (Fin d) → ℝ)
    (x : EuclideanSpace ℝ (Fin d)) : ℝ :=
  ∑ i, directionalDerivativeList [i, i] u x

/-- The iterated directional derivative taken **within** a set. On an open set this agrees with
`directionalDerivativeList`; on a set with boundary, such as `closure Ω`, it is the version that
still says something at the boundary points, where the global `fderiv` is typically the junk
value `0`. -/
noncomputable def directionalDerivativeListWithin {d : ℕ}
    (Ω : Set (EuclideanSpace ℝ (Fin d))) :
    List (Fin d) → (EuclideanSpace ℝ (Fin d) → ℝ) → EuclideanSpace ℝ (Fin d) → ℝ
  | [], u => u
  | i :: indices, u => fun x ↦
      fderivWithin ℝ (directionalDerivativeListWithin Ω indices u) Ω x
        (EuclideanSpace.single i 1)

/-- `D^α u` taken within a set, for use in Hölder gauges on non-open domains. -/
noncomputable def multiDerivativeWithin {d : ℕ} (Ω : Set (EuclideanSpace ℝ (Fin d)))
    (α : (Fin d → ℕ)) (u : EuclideanSpace ℝ (Fin d) → ℝ) :
    EuclideanSpace ℝ (Fin d) → ℝ :=
  directionalDerivativeListWithin Ω (multiIndexDirections α) u

/-- A quantitative `C^{k,δ}` gauge: derivative suprema plus the top-order Holder quotient,
with all derivatives taken within `Ω`. -/
noncomputable def holderGauge {d : ℕ} (k : ℕ) (δ : ℝ)
    (Ω : Set (EuclideanSpace ℝ (Fin d))) (u : EuclideanSpace ℝ (Fin d) → ℝ) : ℝ≥0∞ :=
  (⨆ α : {α : (Fin d → ℕ) // ∑ i, α i ≤ k},
      ⨆ x : Ω, ENNReal.ofReal |multiDerivativeWithin Ω α u x|) ⊔
    ⨆ α : {α : (Fin d → ℕ) // ∑ i, α i = k},
      ⨆ x : Ω, ⨆ y : Ω, ⨆ (_ : (x : EuclideanSpace ℝ (Fin d)) ≠ y),
        ENNReal.ofReal
          (|multiDerivativeWithin Ω α u x - multiDerivativeWithin Ω α u y| /
            ‖(x : EuclideanSpace ℝ (Fin d)) - y‖ ^ δ)

/-- Local `C^r` Holder regularity, including all derivatives through `⌊r⌋`. -/
def HolderOn {d : ℕ} (r : ℝ) (Ω : Set (EuclideanSpace ℝ (Fin d)))
    (u : EuclideanSpace ℝ (Fin d) → ℝ) : Prop :=
  ∃ k : ℕ, ∃ δ : ℝ, r = k + δ ∧ 0 ≤ δ ∧ δ < 1 ∧
    ContDiffOn ℝ k u Ω ∧ holderGauge k δ Ω u < ⊤

/-- Local Holder regularity on every compact subset of an open domain. -/
def HolderLocallyOn {d : ℕ} (r : ℝ) (Ω : Set (EuclideanSpace ℝ (Fin d)))
    (u : EuclideanSpace ℝ (Fin d) → ℝ) : Prop :=
  ∀ K : Set (EuclideanSpace ℝ (Fin d)), IsCompact K → K ⊆ Ω → HolderOn r K u

/-- One-dimensional `C^r` Holder regularity on a time set. -/
def HolderOnReal (r : ℝ) (I : Set ℝ) (u : ℝ → ℝ) : Prop :=
  ∃ (k : ℕ) (δ : ℝ) (hδ : 0 ≤ δ), r = k + δ ∧ δ < 1 ∧ ContDiffOn ℝ k u I ∧
    ∃ C : NNReal, HolderOnWith C (⟨δ, hδ⟩ : NNReal) (iteratedDeriv k u) I

/-- An anisotropic parabolic Holder condition with time exponent `r/2`. -/
def ParabolicHolderOn {d : ℕ} (r : ℝ) (Q : Set (ℝ × EuclideanSpace ℝ (Fin d)))
  (u : (ℝ × EuclideanSpace ℝ (Fin d)) → ℝ) : Prop :=
  (∀ t, HolderOn r {x | (t, x) ∈ Q} fun x ↦ u (t, x)) ∧
    (∀ x, HolderOnReal (r / 2) {t | (t, x) ∈ Q} fun t ↦ u (t, x)) ∧
    -- one constant for the whole of `Q`, not a constant per slice
    ∃ C : ℝ, ∀ p ∈ Q, ∀ q ∈ Q,
      |u p - u q| ≤ C * (‖p.2 - q.2‖ ^ r + |p.1 - q.1| ^ (r / 2))

/-- A bounded regular domain admitting barriers at every boundary point. -/
def RegularBoundedDomain {d : ℕ} (Ω : Set (EuclideanSpace ℝ (Fin d))) : Prop :=
  IsOpen Ω ∧ Bornology.IsBounded Ω ∧ Ω.Nonempty ∧
    ∀ z ∈ frontier Ω, ∃ barrier : EuclideanSpace ℝ (Fin d) → ℝ,
      ContinuousOn barrier (closure Ω) ∧ ContDiffOn ℝ 2 barrier Ω ∧
      barrier z = 0 ∧ (∀ x ∈ closure Ω, x ≠ z → 0 < barrier x) ∧
      ∀ x ∈ Ω, laplacian barrier x ≤ 0

/-- A unit normal which points from the domain into its complement. -/
def IsOutwardUnitNormal {d : ℕ} (Ω : Set (EuclideanSpace ℝ (Fin d)))
    (normal : EuclideanSpace ℝ (Fin d) → EuclideanSpace ℝ (Fin d)) : Prop :=
  ∀ y ∈ frontier Ω, ‖normal y‖ = 1 ∧
    (∀ γ : ℝ → EuclideanSpace ℝ (Fin d), ∀ velocity,
      γ 0 = y → (∀ᶠ t in 𝓝 0, γ t ∈ frontier Ω) → HasDerivAt γ velocity 0 →
        inner ℝ (normal y) velocity = 0) ∧
    ∃ ε : ℝ, 0 < ε ∧ y - ε • normal y ∈ Ω ∧ y + ε • normal y ∉ closure Ω

/-- A bounded domain with a smooth defining function and nonvanishing boundary gradient. -/
def SmoothBoundedDomain {d : ℕ} (Ω : Set (EuclideanSpace ℝ (Fin d))) : Prop :=
  RegularBoundedDomain Ω ∧ ∃ ρ : EuclideanSpace ℝ (Fin d) → ℝ,
    ContDiff ℝ ∞ ρ ∧ Ω = {x | ρ x < 0} ∧
      ∀ x ∈ frontier Ω, fderiv ℝ ρ x ≠ 0

/-- Classical harmonicity in a domain. -/
def HarmonicIn {d : ℕ} (Ω : Set (EuclideanSpace ℝ (Fin d)))
    (u : EuclideanSpace ℝ (Fin d) → ℝ) : Prop :=
  ContDiffOn ℝ 2 u Ω ∧ ∀ x ∈ Ω, laplacian u x = 0

/-- A classical solution of `Δu=f` with prescribed boundary values. -/
def LaplaceDirichletSolution {d : ℕ} (Ω : Set (EuclideanSpace ℝ (Fin d)))
    (f g u : EuclideanSpace ℝ (Fin d) → ℝ) : Prop :=
  ContDiffOn ℝ 2 u Ω ∧ ContinuousOn u (closure Ω) ∧
    (∀ x ∈ Ω, laplacian u x = f x) ∧ ∀ x ∈ frontier Ω, u x = g x

/-- A kernel is a fundamental solution when it represents the Dirac distribution. -/
def IsLaplaceFundamentalSolution {d : ℕ}
    (K : EuclideanSpace ℝ (Fin d) → EuclideanSpace ℝ (Fin d) → ℝ) : Prop :=
  ∀ x, ∀ φ : EuclideanSpace ℝ (Fin d) → ℝ,
    ContDiff ℝ ∞ φ → HasCompactSupport φ →
      Integrable (fun y ↦ K x y * laplacian φ y) →
        ∫ y, K x y * laplacian φ y = φ x

/-- A coefficient representation of an elliptic differential operator of order `m`. -/
structure EllipticOperatorData {d : ℕ} (m : ℕ)
    (L : (EuclideanSpace ℝ (Fin d) → ℝ) → EuclideanSpace ℝ (Fin d) → ℝ) where
  terms : Finset ((Fin d → ℕ))
  order_le : ∀ α ∈ terms, ∑ i, α i ≤ m
  coefficient : (Fin d → ℕ) → EuclideanSpace ℝ (Fin d) → ℝ
  formula : ∀ u x, L u x = ∑ α ∈ terms, coefficient α x * multiDerivative α u x
  ellipticityConstant : ℝ
  ellipticityConstant_pos : 0 < ellipticityConstant
  /-- Uniform ellipticity, with the sign normalised by the parity of `m / 2` so that the
  shifted operator `L - λ` is the invertible one for `λ > 0` at every order. For `m = 2` the
  factor is `+1`, so `Δ` is elliptic and `Δ - λ` is invertible for `λ > 0`; for `m = 4` the
  factor is `-1`, so `-Δ²` is elliptic and `-Δ² - λ` is invertible for `λ > 0`. Without the
  parity factor the admissible sign of `λ` would flip whenever `m` is a multiple of `4`. -/
  principalSymbol : ∀ (x ξ : EuclideanSpace ℝ (Fin d)),
    ellipticityConstant * ‖ξ‖ ^ m ≤
      (-1) ^ (m / 2 + 1) *
        ∑ α ∈ terms with ∑ i, α i = m,
          coefficient α x * ∏ i, (ξ i) ^ (α i)

/-- A uniformly elliptic operator with constant coefficients. -/
def ConstantCoefficientEllipticOperator {d : ℕ} (m : ℕ)
    (L : (EuclideanSpace ℝ (Fin d) → ℝ) → EuclideanSpace ℝ (Fin d) → ℝ) : Prop :=
  ∃ data : EllipticOperatorData m L,
    ∀ α ∈ data.terms, ∀ x y, data.coefficient α x = data.coefficient α y

/-- A uniformly elliptic variable-coefficient operator. -/
def VariableCoefficientEllipticOperator {d : ℕ} (m : ℕ)
    (L : (EuclideanSpace ℝ (Fin d) → ℝ) → EuclideanSpace ℝ (Fin d) → ℝ) : Prop :=
  Nonempty (EllipticOperatorData m L)

/-- The coefficients in an elliptic representation possess the stated Holder regularity. -/
def OperatorCoefficientsHolder {d : ℕ} (m : ℕ) (r : ℝ)
    (L : (EuclideanSpace ℝ (Fin d) → ℝ) → EuclideanSpace ℝ (Fin d) → ℝ) : Prop :=
  ∃ data : EllipticOperatorData m L,
    ∀ α ∈ data.terms, HolderOn r univ (data.coefficient α)

/-- A quantitative uniform bound for the Holder gauges of all operator coefficients. -/
def OperatorCoefficientGaugeLE {d : ℕ} (m k : ℕ) (δ : ℝ) (K : ℝ≥0∞)
    (L : (EuclideanSpace ℝ (Fin d) → ℝ) → EuclideanSpace ℝ (Fin d) → ℝ) : Prop :=
  ∃ data : EllipticOperatorData m L,
    ∀ α ∈ data.terms, holderGauge k δ univ (data.coefficient α) ≤ K

/-- A second-order elliptic operator whose zeroth coefficient is at most `-λ`. -/
def SecondOrderEllipticOperator {d : ℕ}
    (L : (EuclideanSpace ℝ (Fin d) → ℝ) → EuclideanSpace ℝ (Fin d) → ℝ)
    (lam : ℝ) : Prop :=
  ∃ data : EllipticOperatorData 2 L, ∃ zeroIndex ∈ data.terms,
    (∀ i, zeroIndex i = 0) ∧ (∀ x, data.coefficient zeroIndex x ≤ -lam) ∧
      ∃ C : ℝ, ∀ α ∈ data.terms, ∀ x, |data.coefficient α x| ≤ C

/-- The shifted elliptic equation `Lu - λu=f`. -/
def ShiftedEllipticEquation {d : ℕ}
    (L : (EuclideanSpace ℝ (Fin d) → ℝ) → EuclideanSpace ℝ (Fin d) → ℝ) (lam : ℝ)
    (u f : EuclideanSpace ℝ (Fin d) → ℝ) : Prop :=
  ∀ x, L u x - lam * u x = f x

/-- The shifted elliptic equation restricted to a domain. -/
def ShiftedEllipticEquationOn {d : ℕ} (Ω : Set (EuclideanSpace ℝ (Fin d)))
    (L : (EuclideanSpace ℝ (Fin d) → ℝ) → EuclideanSpace ℝ (Fin d) → ℝ) (lam : ℝ)
    (u f : EuclideanSpace ℝ (Fin d) → ℝ) : Prop :=
  ∀ x ∈ Ω, L u x - lam * u x = f x

/-- Extended supremum norm on a set. -/
noncomputable def functionSupNorm {X : Type*} (Ω : Set X) (u : X → ℝ) : ℝ≥0∞ :=
  ⨆ x : Ω, ENNReal.ofReal |u x|

/-- A classical elliptic Dirichlet solution. -/
def EllipticDirichletSolution {d : ℕ} (Ω : Set (EuclideanSpace ℝ (Fin d)))
    (L : (EuclideanSpace ℝ (Fin d) → ℝ) → EuclideanSpace ℝ (Fin d) → ℝ)
    (f g u : EuclideanSpace ℝ (Fin d) → ℝ) : Prop :=
  ContDiffOn ℝ 2 u Ω ∧ ContinuousOn u (closure Ω) ∧
    (∀ x ∈ Ω, L u x = f x) ∧ ∀ x ∈ frontier Ω, u x = g x

/-- The shifted heat equation `Δu-u_t-u=f`. -/
def ShiftedHeatEquation {d : ℕ} (u f : (ℝ × EuclideanSpace ℝ (Fin d)) → ℝ) : Prop :=
  ∀ t x, laplacian (fun y ↦ u (t, y)) x - deriv (fun s ↦ u (s, x)) t - u (t, x) =
    f (t, x)

/-- A uniformly parabolic second-order operator with Holder coefficients. -/
def ParabolicOperator {d : ℕ}
    (L : ((ℝ × EuclideanSpace ℝ (Fin d)) → ℝ) →
      (ℝ × EuclideanSpace ℝ (Fin d)) → ℝ) : Prop :=
  ∃ (a : (ℝ × EuclideanSpace ℝ (Fin d)) → Matrix (Fin d) (Fin d) ℝ)
    (b : (ℝ × EuclideanSpace ℝ (Fin d)) → EuclideanSpace ℝ (Fin d))
    (c : (ℝ × EuclideanSpace ℝ (Fin d)) → ℝ) (κ : ℝ),
    0 < κ ∧
    (∀ (p : (ℝ × EuclideanSpace ℝ (Fin d))) (ξ : EuclideanSpace ℝ (Fin d)),
      κ * ‖ξ‖ ^ 2 ≤ ∑ i, ∑ j, a p i j * ξ i * ξ j) ∧
    ∀ u p, L u p =
      ∑ i, ∑ j, a p i j *
        directionalDerivativeList [i, j] (fun x ↦ u (p.1, x)) p.2 +
      ∑ i, b p i * fderiv ℝ (fun x ↦ u (p.1, x)) p.2 (EuclideanSpace.single i 1) +
      c p * u p

/-- The coefficients of a parabolic operator have the stated anisotropic Holder regularity. -/
def ParabolicOperatorCoefficientsHolder {d : ℕ} (r : ℝ)
    (Q : Set (ℝ × EuclideanSpace ℝ (Fin d)))
    (L : ((ℝ × EuclideanSpace ℝ (Fin d)) → ℝ) →
      (ℝ × EuclideanSpace ℝ (Fin d)) → ℝ) : Prop :=
  ∃ (a : (ℝ × EuclideanSpace ℝ (Fin d)) → Matrix (Fin d) (Fin d) ℝ)
    (b : (ℝ × EuclideanSpace ℝ (Fin d)) → EuclideanSpace ℝ (Fin d))
    (c : (ℝ × EuclideanSpace ℝ (Fin d)) → ℝ),
    (∀ i j, ParabolicHolderOn r Q fun p ↦ a p i j) ∧
      (∀ i, ParabolicHolderOn r Q fun p ↦ b p i) ∧ ParabolicHolderOn r Q c ∧
      ∀ u p, L u p =
        ∑ i, ∑ j, a p i j *
          directionalDerivativeList [i, j] (fun x ↦ u (p.1, x)) p.2 +
        ∑ i, b p i * fderiv ℝ (fun x ↦ u (p.1, x)) p.2 (EuclideanSpace.single i 1) +
        c p * u p

/-- The incoming parabolic boundary, expressed by approach from earlier times. -/
def parabolicBoundary {d : ℕ} (Q : Set (ℝ × EuclideanSpace ℝ (Fin d))) :
    Set (ℝ × EuclideanSpace ℝ (Fin d)) :=
  {p ∈ frontier Q | ∀ ε : ℝ, 0 < ε →
    ∃ q ∈ Q, p.1 ≤ q.1 ∧ dist q p < ε}

/-- A bounded parabolic domain admitting a classical barrier at each incoming boundary point. -/
def RegularParabolicDomain {d : ℕ} (Q : Set (ℝ × EuclideanSpace ℝ (Fin d)))
    (L : ((ℝ × EuclideanSpace ℝ (Fin d)) → ℝ) →
      (ℝ × EuclideanSpace ℝ (Fin d)) → ℝ) : Prop :=
  IsOpen Q ∧ Bornology.IsBounded Q ∧ Q.Nonempty ∧
    ∀ z ∈ parabolicBoundary Q, ∃ barrier : (ℝ × EuclideanSpace ℝ (Fin d)) → ℝ,
      ContinuousOn barrier (closure Q) ∧ ParabolicHolderOn 2 Q barrier ∧ barrier z = 0 ∧
        (∀ p ∈ closure Q, p ≠ z → 0 < barrier p) ∧
        (∀ p ∈ Q, DifferentiableAt ℝ (fun t ↦ barrier (t, p.2)) p.1) ∧
        ∀ p ∈ Q, L barrier p - deriv (fun t ↦ barrier (t, p.2)) p.1 ≤ 0

/-- A classical parabolic Dirichlet solution. -/
def ParabolicDirichletSolution {d : ℕ} (Q : Set (ℝ × EuclideanSpace ℝ (Fin d)))
    (L : ((ℝ × EuclideanSpace ℝ (Fin d)) → ℝ) →
      (ℝ × EuclideanSpace ℝ (Fin d)) → ℝ)
    (f g u : (ℝ × EuclideanSpace ℝ (Fin d)) → ℝ) : Prop :=
  ContinuousOn u (Q ∪ parabolicBoundary Q) ∧
    (∀ p ∈ Q, DifferentiableAt ℝ (fun t ↦ u (t, p.2)) p.1) ∧
    (∀ p ∈ Q, L u p - deriv (fun t ↦ u (t, p.2)) p.1 = f p) ∧
    ∀ p ∈ parabolicBoundary Q, u p = g p

end KrylovHolder
end Dataset
