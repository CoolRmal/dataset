module

import Mathlib.Analysis.Calculus.ContDiff.Basic
import Mathlib.Analysis.Calculus.IteratedDeriv.Defs
import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
import Mathlib.MeasureTheory.Measure.Hausdorff

/-!
# Hard PDE and Holder-space statements from Krylov

Ten statement-only formalizations selected from N. V. Krylov,
*Lectures on Elliptic and Parabolic Equations in Holder Spaces*.
-/

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

/-- Krylov 2.3.1, the Green-Poisson representation formula. -/
theorem krylov_2_3_1_green_poisson_representation
    {d : ℕ} {Ω : Set (Fin d → ℝ)}
    {K h G H : (Fin d → ℝ) → (Fin d → ℝ) → ℝ} {f g u : (Fin d → ℝ) → ℝ}
    (hd : 0 < d) (hΩ : RegularBoundedDomain Ω)
    (boundaryMeasure : Measure (Fin d → ℝ))
    (hmeasure : boundaryMeasure = μH[((d : ℝ) - 1)].restrict (frontier Ω))
    (normal : (Fin d → ℝ) → (Fin d → ℝ))
    (hnormal : IsOutwardUnitNormal Ω normal)
    (hharmonic : ∀ x ∈ Ω, HarmonicIn Ω (h x))
    (hboundary : ∀ x ∈ Ω, ∀ y ∈ frontier Ω, h x y = K x y)
    (hgreen : ∀ x y, G x y = K x y - h x y)
    (hgreenHarmonic : ∀ x ∈ Ω, HarmonicIn (Ω \ {x}) (G x))
    (hgreenBoundary : ∀ x ∈ Ω, ∀ y ∈ frontier Ω, G x y = 0)
    (hpoisson : ∀ x ∈ Ω, ∀ y ∈ frontier Ω,
      H x y = -fderiv ℝ (G x) y (normal y))
    (hGintegrable : ∀ x ∈ Ω, IntegrableOn (fun y ↦ G x y * f y) Ω)
    (hHintegrable : ∀ x ∈ Ω, Integrable (fun y ↦ H x y * g y) boundaryMeasure)
    (hu : LaplaceDirichletSolution Ω f g u) :
    ∀ x ∈ Ω, u x = ∫ y in Ω, G x y * f y +
      ∫ y, H x y * g y ∂boundaryMeasure := by
  sorry

/-- Krylov 2.5.2, smoothness and interior estimates for harmonic functions. -/
theorem krylov_2_5_2_harmonic_smooth_interior_estimates
    {d : ℕ} {Ω : Set (Fin d → ℝ)} {u : (Fin d → ℝ) → ℝ}
    (hΩ : IsOpen Ω ∧ IsConnected Ω) (hu : HarmonicIn Ω u) :
    ContDiffOn ℝ ⊤ u Ω ∧
      ∀ α : (Fin d → ℕ), ∃ C : ℝ, 0 ≤ C ∧ ∀ x ∈ Ω,
        ∀ R : ℝ, 0 < R → Metric.closedBall x R ⊆ Ω →
          |multiDerivative α u x| ≤ C * R ^ (-(∑ i, α i : ℤ)) *
            sSup {|u y| | y ∈ Metric.closedBall x R} := by
  sorry

/-- Krylov 2.9.2, the bounded maximum-principle resolvent estimate. -/
theorem krylov_2_9_2_bounded_maximum_principle_resolvent
    {d : ℕ} {Ω : Set (Fin d → ℝ)}
    {L : ((Fin d → ℝ) → ℝ) → (Fin d → ℝ) → ℝ} {lam : ℝ}
    {u : (Fin d → ℝ) → ℝ}
    (hΩ : IsOpen Ω) (huDiff : ContDiffOn ℝ 2 u Ω)
    (huContinuous : ContinuousOn u (closure Ω))
    (huBounded : Bornology.IsBounded (u '' Ω))
    (huBoundary : ∀ x ∈ frontier Ω, u x = 0)
    (hlam : 0 < lam) (hL : SecondOrderEllipticOperator L lam) :
    functionSupNorm Ω (fun x ↦ max (u x) 0) ≤
        (ENNReal.ofReal lam)⁻¹ * functionSupNorm Ω (fun x ↦ max (-(L u x)) 0) ∧
      functionSupNorm Ω u ≤ (ENNReal.ofReal lam)⁻¹ * functionSupNorm Ω (L u) := by
  sorry

/-- Krylov 3.7.2, global Holder solvability for constant coefficients. -/
theorem krylov_3_7_2_constant_coefficient_holder_solvability
    {d m k : ℕ} {δ lam : ℝ} {L : ((Fin d → ℝ) → ℝ) → (Fin d → ℝ) → ℝ}
    (hm : 0 < m) (hδ : 0 < δ ∧ δ < 1) (hlam : lam ≠ 0)
    (hL : ConstantCoefficientEllipticOperator m L) :
    ∀ f, HolderOn (k + δ) univ f →
      ∃! u, HolderOn (k + m + δ) univ u ∧ ShiftedEllipticEquation L lam u f := by
  sorry

/-- Krylov 4.2.1, improved regularity and the high-parameter Schauder estimate. -/
theorem krylov_4_2_1_better_regular_data_better_regular_solution
    {d m k : ℕ} {δ lam₀ K₁ : ℝ} {L : ((Fin d → ℝ) → ℝ) → (Fin d → ℝ) → ℝ}
    (hm : 0 < m) (hδ : 0 < δ ∧ δ < 1) (hlam₀ : 0 ≤ lam₀) (hK₁ : 1 ≤ K₁)
    (hL : VariableCoefficientEllipticOperator m L)
    (hcoeff : OperatorCoefficientsHolder m (k + δ) L)
    (hcoeffBound : OperatorCoefficientGaugeLE m k δ (ENNReal.ofReal K₁) L) :
    ∃ C : ℝ≥0∞, C < ∞ ∧ ∀ (lam : ℝ) (u f : (Fin d → ℝ) → ℝ),
      HolderOn (m + δ) univ u → ShiftedEllipticEquation L lam u f →
      HolderOn (k + δ) univ f → HolderOn (k + m + δ) univ u ∧
        (lam₀ ≤ |lam| →
          holderGauge (k + m) δ univ u +
              ENNReal.rpow (ENNReal.ofReal |lam|) ((((k + m : ℕ) : ℝ) + δ) / m) *
                functionSupNorm univ u ≤
            C * (holderGauge k δ univ f +
              ENNReal.rpow (ENNReal.ofReal |lam|) ((((k : ℕ) : ℝ) + δ) / m) *
                functionSupNorm univ f)) := by
  sorry

/-- Krylov 4.5.1, global solvability for variable coefficients. -/
theorem krylov_4_5_1_variable_coefficient_global_solvability
    {d m k : ℕ} {δ : ℝ} {L : ((Fin d → ℝ) → ℝ) → (Fin d → ℝ) → ℝ}
    (hm : 0 < m) (hδ : 0 < δ ∧ δ < 1)
    (hL : VariableCoefficientEllipticOperator m L)
    (hcoeff : OperatorCoefficientsHolder m (k + δ) L) :
    ∃ lam₀ : ℝ, 0 ≤ lam₀ ∧ ∀ lam : ℝ, lam₀ ≤ |lam| →
      ∀ f, HolderOn (k + δ) univ f →
        ∃! u, HolderOn (k + m + δ) univ u ∧ ShiftedEllipticEquation L lam u f := by
  sorry

/-- Krylov 6.5.3, the Holder Dirichlet problem on a smooth domain. -/
theorem krylov_6_5_3_smooth_domain_dirichlet_solvability
    {d k : ℕ} {δ : ℝ} {Ω : Set (Fin d → ℝ)}
    {L : ((Fin d → ℝ) → ℝ) → (Fin d → ℝ) → ℝ}
    (hδ : 0 < δ ∧ δ < 1) (hΩ : SmoothBoundedDomain Ω)
    (hL : VariableCoefficientEllipticOperator 2 L)
    (hcoeff : OperatorCoefficientsHolder 2 (k + δ) L) :
    ∀ f g, HolderOn (k + δ) Ω f → HolderOn (k + 2 + δ) (closure Ω) g →
      ∃ u, HolderOn (k + 2 + δ) Ω u ∧ EllipticDirichletSolution Ω L f g u ∧
        ∀ v, HolderOn (k + 2 + δ) Ω v → EllipticDirichletSolution Ω L f g v →
          Set.EqOn v u (closure Ω) := by
  sorry

/-- Krylov 7.1.2, interior Holder regularization. -/
theorem krylov_7_1_2_interior_holder_regularization
    {d m k : ℕ} {δ lam : ℝ} {Ω : Set (Fin d → ℝ)}
    {L : ((Fin d → ℝ) → ℝ) → (Fin d → ℝ) → ℝ} {u f : (Fin d → ℝ) → ℝ}
    (hδ : 0 < δ ∧ δ < 1) (hΩ : IsOpen Ω)
    (hL : VariableCoefficientEllipticOperator m L)
    (hcoeff : OperatorCoefficientsHolder m (k + δ) L)
    (hu : HolderOn (m + δ) Ω u)
    (hLu : ShiftedEllipticEquation L lam u f) (hf : HolderOn (k + δ) Ω f) :
    HolderOn (k + m + δ) Ω u := by
  sorry

/-- Krylov 8.7.3, whole-space solvability for the shifted heat equation. -/
theorem krylov_8_7_3_shifted_heat_holder_solvability
    {d : ℕ} {δ : ℝ} (hδ : 0 < δ ∧ δ < 1) :
    ∀ f : (ℝ × (Fin d → ℝ)) → ℝ, ParabolicHolderOn δ univ f →
      ∃! u : (ℝ × (Fin d → ℝ)) → ℝ,
        ParabolicHolderOn (2 + δ) univ u ∧ ShiftedHeatEquation u f := by
  sorry

/-- Krylov 10.3.3, the parabolic Dirichlet problem in a domain. -/
theorem krylov_10_3_3_parabolic_dirichlet_domain_solvability
    {d : ℕ} {δ : ℝ} {Q : Set (ℝ × (Fin d → ℝ))}
    {L : ((ℝ × (Fin d → ℝ)) → ℝ) → (ℝ × (Fin d → ℝ)) → ℝ}
    (hδ : 0 < δ ∧ δ < 1)
    (hQ : IsOpen Q ∧ Bornology.IsBounded Q ∧ Q.Nonempty)
    (hL : ParabolicOperator L) (hcoeff : ParabolicOperatorCoefficientsHolder δ Q L) :
    ∀ f g, ParabolicHolderOn δ Q f → ParabolicHolderOn (2 + δ) Q g →
      ∃ u, ParabolicHolderOn (2 + δ) Q u ∧
        ParabolicDirichletSolution Q L f g u ∧
        ∀ v, ParabolicHolderOn (2 + δ) Q v →
          ParabolicDirichletSolution Q L f g v →
            Set.EqOn v u (Q ∪ parabolicBoundary Q) := by
  sorry

end KrylovHolder
end Dataset
