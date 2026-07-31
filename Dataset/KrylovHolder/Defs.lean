module

public import Mathlib.Analysis.Calculus.ContDiff.Basic
public import Mathlib.Analysis.Calculus.IteratedDeriv.Defs
public import Mathlib.MeasureTheory.Integral.Bochner.Basic
public import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
public import Mathlib.MeasureTheory.Measure.Hausdorff

/-!
# Shared definitions for the KrylovHolder problems

Custom notions used by the statement files in `Dataset/KrylovHolder/` that are
not already supplied by Mathlib. Each problem file that needs them imports
this module.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology
open scoped ENNReal Topology

namespace Dataset
namespace KrylovHolder

/-- Repeated coordinate directional differentiation along a list of coordinate axes. -/
noncomputable def directionalDerivativeList {d : ℕ} :
    List (Fin d) → ((Fin d → ℝ) → ℝ) → (Fin d → ℝ) → ℝ
  | [], u => u
  | i :: indices, u => fun x ↦
      fderiv ℝ (directionalDerivativeList indices u) x (Pi.single i 1)

/-- A deterministic list containing coordinate `i` exactly `α i` times. -/
noncomputable def multiIndexDirections {d : ℕ} (α : (Fin d → ℕ)) : List (Fin d) :=
  Finset.univ.toList.flatMap fun i ↦ List.replicate (α i) i

/-- The classical mixed derivative selected by a multi-index. -/
noncomputable def multiDerivative {d : ℕ} (α : (Fin d → ℕ))
    (u : (Fin d → ℝ) → ℝ) : (Fin d → ℝ) → ℝ :=
  directionalDerivativeList (multiIndexDirections α) u

/-- The Laplacian as the sum of the repeated coordinate derivatives. -/
noncomputable def laplacian {d : ℕ} (u : (Fin d → ℝ) → ℝ) (x : (Fin d → ℝ)) : ℝ :=
  ∑ i, directionalDerivativeList [i, i] u x

/-- A quantitative `C^{k,δ}` gauge: derivative suprema plus the top-order Holder quotient. -/
noncomputable def holderGauge {d : ℕ} (k : ℕ) (δ : ℝ)
    (Ω : Set (Fin d → ℝ)) (u : (Fin d → ℝ) → ℝ) : ℝ≥0∞ :=
  (⨆ α : {α : (Fin d → ℕ) // ∑ i, α i ≤ k},
      ⨆ x : Ω, ENNReal.ofReal |multiDerivative α u x|) ⊔
    ⨆ α : {α : (Fin d → ℕ) // ∑ i, α i = k},
      ⨆ x : Ω, ⨆ y : Ω, ⨆ (_ : (x : (Fin d → ℝ)) ≠ y),
        ENNReal.ofReal
          (|multiDerivative α u x - multiDerivative α u y| /
            ‖(x : (Fin d → ℝ)) - y‖ ^ δ)

/-- Local `C^r` Holder regularity, including all derivatives through `⌊r⌋`. -/
def HolderOn {d : ℕ} (r : ℝ) (Ω : Set (Fin d → ℝ))
    (u : (Fin d → ℝ) → ℝ) : Prop :=
  ∃ k : ℕ, ∃ δ : ℝ, r = k + δ ∧ 0 ≤ δ ∧ δ < 1 ∧
    ContDiffOn ℝ k u Ω ∧ holderGauge k δ Ω u < ∞

/-- One-dimensional `C^r` Holder regularity on a time set. -/
def HolderOnReal (r : ℝ) (I : Set ℝ) (u : ℝ → ℝ) : Prop :=
  ∃ (k : ℕ) (δ : ℝ) (hδ : 0 ≤ δ), r = k + δ ∧ δ < 1 ∧ ContDiffOn ℝ k u I ∧
    ∃ C : NNReal, HolderOnWith C (⟨δ, hδ⟩ : NNReal) (iteratedDeriv k u) I

/-- An anisotropic parabolic Holder condition with time exponent `r/2`. -/
def ParabolicHolderOn {d : ℕ} (r : ℝ) (Q : Set (ℝ × (Fin d → ℝ)))
  (u : (ℝ × (Fin d → ℝ)) → ℝ) : Prop :=
  (∀ t, HolderOn r {x | (t, x) ∈ Q} fun x ↦ u (t, x)) ∧
    ∀ x, HolderOnReal (r / 2) {t | (t, x) ∈ Q} fun t ↦ u (t, x)

/-- A bounded regular domain admitting barriers at every boundary point. -/
def RegularBoundedDomain {d : ℕ} (Ω : Set (Fin d → ℝ)) : Prop :=
  IsOpen Ω ∧ Bornology.IsBounded Ω ∧ Ω.Nonempty ∧
    ∀ z ∈ frontier Ω, ∃ barrier : (Fin d → ℝ) → ℝ,
      ContinuousOn barrier (closure Ω) ∧
      barrier z = 0 ∧ (∀ x ∈ closure Ω, x ≠ z → 0 < barrier x) ∧
      ∀ x ∈ Ω, laplacian barrier x ≤ 0

/-- A unit normal which points from the domain into its complement. -/
def IsOutwardUnitNormal {d : ℕ} (Ω : Set (Fin d → ℝ))
    (normal : (Fin d → ℝ) → (Fin d → ℝ)) : Prop :=
  ∀ y ∈ frontier Ω, ‖normal y‖ = 1 ∧
    ∃ ε : ℝ, 0 < ε ∧ y - ε • normal y ∈ Ω ∧ y + ε • normal y ∉ closure Ω

/-- A bounded domain with a smooth defining function and nonvanishing boundary gradient. -/
def SmoothBoundedDomain {d : ℕ} (Ω : Set (Fin d → ℝ)) : Prop :=
  RegularBoundedDomain Ω ∧ ∃ ρ : (Fin d → ℝ) → ℝ,
    ContDiff ℝ ⊤ ρ ∧ Ω = {x | ρ x < 0} ∧
      ∀ x ∈ frontier Ω, fderiv ℝ ρ x ≠ 0

/-- Classical harmonicity in a domain. -/
def HarmonicIn {d : ℕ} (Ω : Set (Fin d → ℝ)) (u : (Fin d → ℝ) → ℝ) : Prop :=
  ContDiffOn ℝ 2 u Ω ∧ ∀ x ∈ Ω, laplacian u x = 0

/-- A classical solution of `Δu=f` with prescribed boundary values. -/
def LaplaceDirichletSolution {d : ℕ} (Ω : Set (Fin d → ℝ))
    (f g u : (Fin d → ℝ) → ℝ) : Prop :=
  ContDiffOn ℝ 2 u Ω ∧ ContinuousOn u (closure Ω) ∧
    (∀ x ∈ Ω, laplacian u x = f x) ∧ ∀ x ∈ frontier Ω, u x = g x

/-- A coefficient representation of an elliptic differential operator of order `m`. -/
structure EllipticOperatorData {d : ℕ} (m : ℕ)
    (L : ((Fin d → ℝ) → ℝ) → (Fin d → ℝ) → ℝ) where
  terms : Finset ((Fin d → ℕ))
  order_le : ∀ α ∈ terms, ∑ i, α i ≤ m
  coefficient : (Fin d → ℕ) → (Fin d → ℝ) → ℝ
  formula : ∀ u x, L u x = ∑ α ∈ terms, coefficient α x * multiDerivative α u x
  ellipticityConstant : ℝ
  ellipticityConstant_pos : 0 < ellipticityConstant
  principalSymbol : ∀ (x ξ : (Fin d → ℝ)),
    ellipticityConstant * ‖ξ‖ ^ m ≤
      ∑ α ∈ terms with ∑ i, α i = m,
        coefficient α x * ∏ i, (ξ i) ^ (α i)

/-- A uniformly elliptic operator with constant coefficients. -/
def ConstantCoefficientEllipticOperator {d : ℕ} (m : ℕ)
    (L : ((Fin d → ℝ) → ℝ) → (Fin d → ℝ) → ℝ) : Prop :=
  ∃ data : EllipticOperatorData m L,
    ∀ α ∈ data.terms, ∀ x y, data.coefficient α x = data.coefficient α y

/-- A uniformly elliptic variable-coefficient operator. -/
def VariableCoefficientEllipticOperator {d : ℕ} (m : ℕ)
    (L : ((Fin d → ℝ) → ℝ) → (Fin d → ℝ) → ℝ) : Prop :=
  Nonempty (EllipticOperatorData m L)

/-- The coefficients in an elliptic representation possess the stated Holder regularity. -/
def OperatorCoefficientsHolder {d : ℕ} (m : ℕ) (r : ℝ)
    (L : ((Fin d → ℝ) → ℝ) → (Fin d → ℝ) → ℝ) : Prop :=
  ∃ data : EllipticOperatorData m L,
    ∀ α ∈ data.terms, HolderOn r univ (data.coefficient α)

/-- A quantitative uniform bound for the Holder gauges of all operator coefficients. -/
def OperatorCoefficientGaugeLE {d : ℕ} (m k : ℕ) (δ : ℝ) (K : ℝ≥0∞)
    (L : ((Fin d → ℝ) → ℝ) → (Fin d → ℝ) → ℝ) : Prop :=
  ∃ data : EllipticOperatorData m L,
    ∀ α ∈ data.terms, holderGauge k δ univ (data.coefficient α) ≤ K

/-- A second-order elliptic operator whose zeroth coefficient is at most `-λ`. -/
def SecondOrderEllipticOperator {d : ℕ}
    (L : ((Fin d → ℝ) → ℝ) → (Fin d → ℝ) → ℝ) (lam : ℝ) : Prop :=
  ∃ data : EllipticOperatorData 2 L, ∃ zeroIndex ∈ data.terms,
    (∀ i, zeroIndex i = 0) ∧ (∀ x, data.coefficient zeroIndex x ≤ -lam) ∧
      ∃ C : ℝ, ∀ α ∈ data.terms, ∀ x, |data.coefficient α x| ≤ C

/-- The shifted elliptic equation `Lu - λu=f`. -/
def ShiftedEllipticEquation {d : ℕ}
    (L : ((Fin d → ℝ) → ℝ) → (Fin d → ℝ) → ℝ) (lam : ℝ)
    (u f : (Fin d → ℝ) → ℝ) : Prop :=
  ∀ x, L u x - lam * u x = f x

/-- Extended supremum norm on a set. -/
noncomputable def functionSupNorm {X : Type*} (Ω : Set X) (u : X → ℝ) : ℝ≥0∞ :=
  ⨆ x : Ω, ENNReal.ofReal |u x|

/-- A classical elliptic Dirichlet solution. -/
def EllipticDirichletSolution {d : ℕ} (Ω : Set (Fin d → ℝ))
    (L : ((Fin d → ℝ) → ℝ) → (Fin d → ℝ) → ℝ)
    (f g u : (Fin d → ℝ) → ℝ) : Prop :=
  (∀ x ∈ Ω, L u x = f x) ∧ ∀ x ∈ frontier Ω, u x = g x

/-- The shifted heat equation `Δu-u_t-u=f`. -/
def ShiftedHeatEquation {d : ℕ} (u f : (ℝ × (Fin d → ℝ)) → ℝ) : Prop :=
  ∀ t x, laplacian (fun y ↦ u (t, y)) x - deriv (fun s ↦ u (s, x)) t - u (t, x) =
    f (t, x)

/-- A uniformly parabolic second-order operator with Holder coefficients. -/
def ParabolicOperator {d : ℕ}
    (L : ((ℝ × (Fin d → ℝ)) → ℝ) → (ℝ × (Fin d → ℝ)) → ℝ) : Prop :=
  ∃ (a : (ℝ × (Fin d → ℝ)) → Matrix (Fin d) (Fin d) ℝ)
    (b : (ℝ × (Fin d → ℝ)) → (Fin d → ℝ))
    (c : (ℝ × (Fin d → ℝ)) → ℝ) (κ : ℝ),
    0 < κ ∧
    (∀ (p : (ℝ × (Fin d → ℝ))) (ξ : (Fin d → ℝ)),
      κ * ‖ξ‖ ^ 2 ≤ ∑ i, ∑ j, a p i j * ξ i * ξ j) ∧
    ∀ u p, L u p =
      ∑ i, ∑ j, a p i j *
        directionalDerivativeList [i, j] (fun x ↦ u (p.1, x)) p.2 +
      ∑ i, b p i * fderiv ℝ (fun x ↦ u (p.1, x)) p.2 (Pi.single i 1) +
      c p * u p

/-- The coefficients of a parabolic operator have the stated anisotropic Holder regularity. -/
def ParabolicOperatorCoefficientsHolder {d : ℕ} (r : ℝ)
    (Q : Set (ℝ × (Fin d → ℝ)))
    (L : ((ℝ × (Fin d → ℝ)) → ℝ) → (ℝ × (Fin d → ℝ)) → ℝ) : Prop :=
  ∃ (a : (ℝ × (Fin d → ℝ)) → Matrix (Fin d) (Fin d) ℝ)
    (b : (ℝ × (Fin d → ℝ)) → (Fin d → ℝ))
    (c : (ℝ × (Fin d → ℝ)) → ℝ),
    (∀ i j, ParabolicHolderOn r Q fun p ↦ a p i j) ∧
      (∀ i, ParabolicHolderOn r Q fun p ↦ b p i) ∧ ParabolicHolderOn r Q c ∧
      ∀ u p, L u p =
        ∑ i, ∑ j, a p i j *
          directionalDerivativeList [i, j] (fun x ↦ u (p.1, x)) p.2 +
        ∑ i, b p i * fderiv ℝ (fun x ↦ u (p.1, x)) p.2 (Pi.single i 1) +
        c p * u p

/-- The incoming parabolic boundary, expressed by approach from earlier times. -/
def parabolicBoundary {d : ℕ} (Q : Set (ℝ × (Fin d → ℝ))) : Set (ℝ × (Fin d → ℝ)) :=
  {p ∈ frontier Q | ∀ ε : ℝ, 0 < ε →
    ∃ q ∈ Q, q.1 ≤ p.1 ∧ dist q p < ε}

/-- A classical parabolic Dirichlet solution. -/
def ParabolicDirichletSolution {d : ℕ} (Q : Set (ℝ × (Fin d → ℝ)))
    (L : ((ℝ × (Fin d → ℝ)) → ℝ) → (ℝ × (Fin d → ℝ)) → ℝ)
    (f g u : (ℝ × (Fin d → ℝ)) → ℝ) : Prop :=
  (∀ p ∈ Q, L u p - deriv (fun t ↦ u (t, p.2)) p.1 = f p) ∧
    ∀ p ∈ parabolicBoundary Q, u p = g p

end KrylovHolder
end Dataset
