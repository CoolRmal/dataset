module

import Mathlib.Analysis.Calculus.ContDiff.Defs
import Mathlib.Analysis.ODE.PicardLindelof
import Mathlib.Analysis.Normed.Algebra.MatrixExponential
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.LinearAlgebra.Matrix.Charpoly.Basic
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic

/-!
# Hard ordinary-differential-equation statements from Kong

Ten statement-only formalizations selected from Qingkai Kong,
*A Short Course in Ordinary Differential Equations*.
-/

open Filter Function MeasureTheory Set Topology

open scoped ENNReal Matrix NNReal Topology

namespace Dataset
namespace KongODE

/-- A trajectory solving a nonautonomous first-order system. -/
def IsTrajectory {n : ℕ} (F : ℝ → (Fin n → ℝ) → (Fin n → ℝ))
    (x : ℝ → (Fin n → ℝ)) : Prop :=
  ∀ t : ℝ, HasDerivAt x (F t (x t)) t

/-- A trajectory solving an equation on a specified time set. -/
def IsTrajectoryOn {n : ℕ} (I : Set ℝ)
    (F : ℝ → (Fin n → ℝ) → (Fin n → ℝ))
    (x : ℝ → (Fin n → ℝ)) : Prop :=
  ∀ t ∈ I, HasDerivAt x (F t (x t)) t

/-- A trajectory solving an autonomous system. -/
def IsAutonomousTrajectory {n : ℕ} (F : (Fin n → ℝ) → (Fin n → ℝ))
    (x : ℝ → (Fin n → ℝ)) : Prop :=
  IsTrajectory (fun _ ↦ F) x

/-- The companion first-order system associated with a scalar equation of order `n`. -/
def companionField {n : ℕ} (g : ℝ → (Fin n → ℝ) → ℝ) (t : ℝ)
    (y : (Fin n → ℝ)) : (Fin n → ℝ) :=
  fun i : Fin n ↦ if h : i.1 + 1 < n then y ⟨i.1 + 1, h⟩ else g t y

/-- Local Lipschitz dependence on state, uniformly on a neighborhood of each domain point. -/
def LocallyLipschitzInState {n : ℕ} (D : Set (ℝ × (Fin n → ℝ)))
    (f : ℝ → (Fin n → ℝ) → (Fin n → ℝ)) : Prop :=
  ∀ p ∈ D, ∃ U ∈ 𝓝 p, ∃ K : NNReal,
    ∀ t : ℝ, LipschitzOnWith K (f t) {x | (t, x) ∈ U ∩ D}

/-- A nonsingular matrix solution of `X' = A X`. -/
def FundamentalMatrixSolution {n : ℕ} (I : Set ℝ) (A : ℝ → Matrix (Fin n) (Fin n) ℝ)
    (X : ℝ → Matrix (Fin n) (Fin n) ℝ) : Prop :=
  (∀ t ∈ I, HasDerivAt X (A t * X t) t) ∧ ∀ t ∈ I, IsUnit (X t)

/-- Periodicity of the coefficient matrix. -/
def PeriodicLinearEquation {n : ℕ} (ω : ℝ) (A : ℝ → Matrix (Fin n) (Fin n) ℝ) : Prop :=
  ∀ t, A (t + ω) = A t

/-- A list containing exactly the characteristic multipliers of a transition matrix. -/
def CharacteristicMultipliers {n : ℕ} (V : Matrix (Fin n) (Fin n) ℂ)
    (μ : Fin n → ℂ) : Prop :=
  Matrix.charpoly V = ∏ i, (Polynomial.X - Polynomial.C (μ i))

/-- The complexified one-period transition matrix of a periodic linear equation. -/
def IsPeriodTransitionMatrix {n : ℕ} (ω : ℝ)
    (A : ℝ → Matrix (Fin n) (Fin n) ℝ) (V : Matrix (Fin n) (Fin n) ℂ) : Prop :=
  ∃ X : ℝ → Matrix (Fin n) (Fin n) ℝ,
    FundamentalMatrixSolution univ A X ∧
      V = (X ω * (X 0)⁻¹).map (algebraMap ℝ ℂ)

/-- The multiplier has no nontrivial Jordan block. -/
def InDiagonalJordanBlock {n : ℕ} (V : Matrix (Fin n) (Fin n) ℂ) (μ : ℂ) : Prop :=
  ∀ v : (Fin n → ℂ),
    (V - μ • (1 : Matrix (Fin n) (Fin n) ℂ)) *ᵥ
        ((V - μ • (1 : Matrix (Fin n) (Fin n) ℂ)) *ᵥ v) = 0 →
      (V - μ • (1 : Matrix (Fin n) (Fin n) ℂ)) *ᵥ v = 0

/-- Uniform Lyapunov stability of the zero solution of a nonautonomous system. -/
def UniformlyStableZeroSolution {n : ℕ}
    (F : ℝ → (Fin n → ℝ) → (Fin n → ℝ)) : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ δ : ℝ, 0 < δ ∧ ∀ t₀ x,
    IsTrajectory F x → ‖x t₀‖ < δ → ∀ t, t₀ ≤ t → ‖x t‖ < ε

/-- Uniform stability together with convergence of all sufficiently small solutions to zero. -/
def AsymptoticallyStableZeroSolution {n : ℕ}
    (F : ℝ → (Fin n → ℝ) → (Fin n → ℝ)) : Prop :=
  UniformlyStableZeroSolution F ∧ ∃ δ : ℝ, 0 < δ ∧ ∀ t₀ x,
    IsTrajectory F x → ‖x t₀‖ < δ → Tendsto x atTop (𝓝 0)

/-- Instability is the negation of Lyapunov stability. -/
def UnstableZeroSolution {n : ℕ} (F : ℝ → (Fin n → ℝ) → (Fin n → ℝ)) : Prop :=
  ¬UniformlyStableZeroSolution F

/-- Stability of the linear system `x' = A(t)x`. -/
def UniformlyStableLinearEquation {n : ℕ} (A : ℝ → Matrix (Fin n) (Fin n) ℝ) : Prop :=
  UniformlyStableZeroSolution fun t x ↦ A t *ᵥ x

/-- Asymptotic stability of the linear system `x' = A(t)x`. -/
def AsymptoticallyStableLinearEquation {n : ℕ} (A : ℝ → Matrix (Fin n) (Fin n) ℝ) : Prop :=
  AsymptoticallyStableZeroSolution fun t x ↦ A t *ᵥ x

/-- Instability of the linear system `x' = A(t)x`. -/
def UnstableLinearEquation {n : ℕ} (A : ℝ → Matrix (Fin n) (Fin n) ℝ) : Prop :=
  UnstableZeroSolution fun t x ↦ A t *ᵥ x

/-- An integrable perturbation which is linearly small near the origin. -/
def IntegrableSmallPerturbation {n : ℕ} (p : ℝ → ℝ)
    (r : ℝ → (Fin n → ℝ) → (Fin n → ℝ)) : Prop :=
  ContinuousOn p (Set.Ici 0) ∧ (∀ t, 0 ≤ p t) ∧
    IntegrableOn p (Set.Ici 0) ∧
    ∃ ρ : ℝ, 0 < ρ ∧
      ∀ t, 0 ≤ t → ∀ x, ‖x‖ < ρ → ‖r t x‖ ≤ p t * ‖x‖

/-- A positive-definite Lyapunov function with nonpositive orbital derivative on a ball. -/
def LyapunovFunctionOnBall {n : ℕ} (l : ℝ) (V : (Fin n → ℝ) → ℝ)
    (F : (Fin n → ℝ) → (Fin n → ℝ)) : Prop :=
  ContDiffOn ℝ 1 V (Metric.closedBall 0 l) ∧ V 0 = 0 ∧
    (∀ x ∈ Metric.closedBall (0 : (Fin n → ℝ)) l, x ≠ 0 → 0 < V x) ∧
    ∀ x ∈ Metric.closedBall (0 : (Fin n → ℝ)) l, fderiv ℝ V x (F x) ≤ 0

/-- No complete nonzero trajectory remains in the zero orbital-derivative set. -/
def NoNontrivialOrbitInZeroDerivativeSet {n : ℕ} (l : ℝ)
    (V : (Fin n → ℝ) → ℝ) (F : (Fin n → ℝ) → (Fin n → ℝ)) : Prop :=
  ∀ x : ℝ → (Fin n → ℝ), IsAutonomousTrajectory F x →
    (∀ t, x t ∈ Metric.closedBall (0 : (Fin n → ℝ)) l ∧
      fderiv ℝ V (x t) (F (x t)) = 0) →
      x = 0

/-- The omega-limit set of a positive semi-orbit. -/
def omegaLimitSet {n : ℕ} (x : ℝ → (Fin n → ℝ)) : Set (Fin n → ℝ) :=
  {y | ∃ t : ℕ → ℝ, Tendsto t atTop atTop ∧ Tendsto (fun j ↦ x (t j)) atTop (𝓝 y)}

/-- The alpha-limit set of a negative semi-orbit. -/
def alphaLimitSet {n : ℕ} (x : ℝ → (Fin n → ℝ)) : Set (Fin n → ℝ) :=
  {y | ∃ t : ℕ → ℝ, Tendsto t atTop atBot ∧ Tendsto (fun j ↦ x (t j)) atTop (𝓝 y)}

/-- A periodic nonconstant trajectory. -/
def IsClosedOrbit {n : ℕ} (F : (Fin n → ℝ) → (Fin n → ℝ))
    (x : ℝ → (Fin n → ℝ)) : Prop :=
  IsAutonomousTrajectory F x ∧ (∃ t, x t ≠ x 0) ∧
    ∃ T : ℝ, 0 < T ∧ ∀ t, x (t + T) = x t

/-- A graphic is a connected finite union of equilibria and connecting complete orbits. -/
def GraphicForPlanarSystem (F : (Fin 2 → ℝ) → (Fin 2 → ℝ))
    (Γ : Set (Fin 2 → ℝ)) : Prop :=
  IsConnected Γ ∧
    ∃ (m : ℕ) (e : Fin m → (Fin 2 → ℝ)) (x : Fin m → ℝ → (Fin 2 → ℝ)),
    (∀ i, F (e i) = 0) ∧ (∀ i, IsAutonomousTrajectory F (x i)) ∧
      (∀ i, ∃ j k, Tendsto (x i) atBot (𝓝 (e j)) ∧ Tendsto (x i) atTop (𝓝 (e k))) ∧
      Γ = range e ∪ ⋃ i, range (x i)

/-- The matrix of the linearization at the origin. -/
noncomputable def linearizationMatrix (F : (Fin 2 → ℝ) → ℝ → (Fin 2 → ℝ))
    (μ : ℝ) : (Matrix (Fin 2) (Fin 2) ℝ) :=
  fun i j ↦ fderiv ℝ (fun x ↦ F x μ) 0 (Pi.single j 1) i

/-- A function solves the Sturm-Liouville equation for the given spectral value. -/
def IsSturmLiouvilleEigenfunction (p q w : ℝ → ℝ) (a b eigVal : ℝ)
    (boundary : (ℝ → ℝ) → Prop) (y : ℝ → ℝ) : Prop :=
  y ≠ 0 ∧ boundary y ∧ ∃ y' : ℝ → ℝ,
    (∀ x ∈ Set.Icc a b, HasDerivAt y (y' x) x) ∧
    ∀ x ∈ Set.Icc a b,
      HasDerivAt (fun t ↦ p t * y' t) ((q x - eigVal * w x) * y x) x

/-- Regular periodic Sturm-Liouville coefficient and boundary data. -/
def PeriodicSturmLiouvilleData (p q w : ℝ → ℝ) (a b : ℝ) : Prop :=
  a < b ∧ ContinuousOn p (Set.Icc a b) ∧ ContinuousOn q (Set.Icc a b) ∧
    ContinuousOn w (Set.Icc a b) ∧
    (∀ x ∈ Set.Icc a b, 0 < p x ∧ 0 < w x)

/-- Periodic, Dirichlet, and Neumann boundary conditions. -/
def periodicBoundary (p : ℝ → ℝ) (a b : ℝ) (y : ℝ → ℝ) : Prop :=
  y a = y b ∧ deriv y a * p a = deriv y b * p b

/-- Dirichlet boundary conditions at both endpoints. -/
def dirichletBoundary (a b : ℝ) (y : ℝ → ℝ) : Prop := y a = 0 ∧ y b = 0

/-- Neumann boundary conditions at both endpoints. -/
def neumannBoundary (a b : ℝ) (y : ℝ → ℝ) : Prop := deriv y a = 0 ∧ deriv y b = 0

/-- Kong 1.3.3, local existence and uniqueness for scalar higher-order IVPs. -/
theorem kong_1_3_3_nth_order_scalar_ivp
    {n : ℕ} {D : Set (ℝ × (Fin n → ℝ))} {g : ℝ → (Fin n → ℝ) → ℝ}
    {t₀ : ℝ} {a : (Fin n → ℝ)} (hD : IsOpen D) (hpoint : (t₀, a) ∈ D) :
    (ContinuousOn (fun p : ℝ × (Fin n → ℝ) ↦ g p.1 p.2) D →
      ∃ γ : ℝ, 0 < γ ∧ let I := Set.Icc (t₀ - γ) (t₀ + γ)
        ∃ y : ℝ → (Fin n → ℝ), IsTrajectoryOn I (companionField g) y ∧ y t₀ = a ∧
          ∀ t ∈ I, (t, y t) ∈ D) ∧
    (ContinuousOn (fun p : ℝ × (Fin n → ℝ) ↦ g p.1 p.2) D →
      LocallyLipschitzInState D (companionField g) →
        ∃ γ : ℝ, 0 < γ ∧ let I := Set.Icc (t₀ - γ) (t₀ + γ)
          ∃ y : ℝ → (Fin n → ℝ), IsTrajectoryOn I (companionField g) y ∧ y t₀ = a ∧
            (∀ t ∈ I, (t, y t) ∈ D) ∧
            ∀ z : ℝ → (Fin n → ℝ), IsTrajectoryOn I (companionField g) z →
              z t₀ = a → (∀ t ∈ I, (t, z t) ∈ D) → Set.EqOn z y I) := by
  sorry

/-- Kong 1.5.3, differentiable dependence on initial data and parameters. -/
theorem kong_1_5_3_differentiable_dependence
    {n k : ℕ} {D : Set (ℝ × (Fin n → ℝ) × (Fin k → ℝ))}
    {f : ℝ → (Fin n → ℝ) → (Fin k → ℝ) → (Fin n → ℝ)}
    (hf : ContDiffOn ℝ 1
      (fun p : ℝ × (Fin n → ℝ) × (Fin k → ℝ) ↦ f p.1 p.2.1 p.2.2) D) :
    ∃ (I : ℝ → (Fin n → ℝ) → (Fin k → ℝ) → Set ℝ)
      (x : ℝ → ℝ → (Fin n → ℝ) → (Fin k → ℝ) → (Fin n → ℝ)),
      (∀ t₀ x₀ μ, (t₀, x₀, μ) ∈ D → IsOpen (I t₀ x₀ μ) ∧
        (I t₀ x₀ μ).OrdConnected ∧ t₀ ∈ I t₀ x₀ μ ∧
        IsTrajectoryOn (I t₀ x₀ μ) (fun t y ↦ f t y μ) (fun t ↦ x t t₀ x₀ μ) ∧
        x t₀ t₀ x₀ μ = x₀ ∧
        (∀ t ∈ I t₀ x₀ μ, (t, x t t₀ x₀ μ, μ) ∈ D) ∧
        ∀ y, IsTrajectoryOn (I t₀ x₀ μ) (fun t z ↦ f t z μ) y → y t₀ = x₀ →
          (∀ t ∈ I t₀ x₀ μ, (t, y t, μ) ∈ D) →
          Set.EqOn y (fun t ↦ x t t₀ x₀ μ) (I t₀ x₀ μ)) ∧
      (let flowDomain := {p : ℝ × ℝ × (Fin n → ℝ) × (Fin k → ℝ) |
        p.1 ∈ I p.2.1 p.2.2.1 p.2.2.2};
        ContDiffOn ℝ 1 (fun p ↦ x p.1 p.2.1 p.2.2.1 p.2.2.2) flowDomain) ∧
      (∀ t₀ x₀ μ, (t₀, x₀, μ) ∈ D →
        let z := fun t ↦ fderiv ℝ (fun η ↦ x t t₀ x₀ η) μ
        z t₀ = 0 ∧ ∀ t ∈ I t₀ x₀ μ, HasDerivAt z
          ((fderiv ℝ (fun y ↦ f t y μ) (x t t₀ x₀ μ)).comp (z t) +
            fderiv ℝ (fun η ↦ f t (x t t₀ x₀ μ) η) μ) t) ∧
      (∀ t₀ x₀ μ, (t₀, x₀, μ) ∈ D →
        let z := fun t ↦ fderiv ℝ (fun y ↦ x t t₀ y μ) x₀
        z t₀ = ContinuousLinearMap.id ℝ (Fin n → ℝ) ∧ ∀ t ∈ I t₀ x₀ μ,
          HasDerivAt z ((fderiv ℝ (fun y ↦ f t y μ) (x t t₀ x₀ μ)).comp (z t)) t) ∧
      ∀ t₀ x₀ μ, (t₀, x₀, μ) ∈ D →
        let z := fun t ↦ deriv (fun s ↦ x t s x₀ μ) t₀
        z t₀ = -f t₀ x₀ μ ∧ ∀ t ∈ I t₀ x₀ μ,
          HasDerivAt z ((fderiv ℝ (fun y ↦ f t y μ) (x t t₀ x₀ μ)) (z t)) t := by
  sorry

/-- Kong 2.3.1, variation of parameters. -/
theorem kong_2_3_1_variation_of_parameters
    {n : ℕ} {I : Set ℝ} {A : ℝ → Matrix (Fin n) (Fin n) ℝ} {f : ℝ → (Fin n → ℝ)}
    {X : ℝ → Matrix (Fin n) (Fin n) ℝ} {t₀ : ℝ}
    (hI : I.OrdConnected) (hA : ContinuousOn A I) (hf : ContinuousOn f I)
    (hX : FundamentalMatrixSolution I A X) (ht₀ : t₀ ∈ I) :
    (∀ y : ℝ → (Fin n → ℝ),
      (∀ t ∈ I, HasDerivAt y (A t *ᵥ y t + f t) t) ↔
        ∃ c : Fin n → ℝ, ∀ t ∈ I,
          y t = X t *ᵥ c + ∫ s in t₀..t, (X t * (X s)⁻¹) *ᵥ f s) ∧
      ∀ x₀, ∃ y : ℝ → (Fin n → ℝ), y t₀ = x₀ ∧
        (∀ t ∈ I, HasDerivAt y (A t *ᵥ y t + f t) t) ∧
        (∀ t ∈ I, y t = (X t * (X t₀)⁻¹) *ᵥ x₀ +
          ∫ s in t₀..t, (X t * (X s)⁻¹) *ᵥ f s) ∧
        ∀ z : ℝ → (Fin n → ℝ), z t₀ = x₀ →
          (∀ t ∈ I, HasDerivAt z (A t *ᵥ z t + f t) t) → Set.EqOn z y I := by
  sorry

/-- Kong 2.5.3, Floquet's theorem. -/
theorem kong_2_5_3_floquet_theorem
    {n : ℕ} {ω : ℝ} {A : ℝ → Matrix (Fin n) (Fin n) ℝ}
    {X : ℝ → Matrix (Fin n) (Fin n) ℝ}
    (hω : 0 < ω) (hper : PeriodicLinearEquation ω A)
    (hX : FundamentalMatrixSolution univ A X) :
    ∃ R : Matrix (Fin n) (Fin n) ℂ, ∃ P : ℝ → Matrix (Fin n) (Fin n) ℂ,
      (∀ i j, ContDiff ℝ 1 fun t ↦ P t i j) ∧ (∀ t, P (t + ω) = P t) ∧
        (∀ t, IsUnit (P t)) ∧
          ∀ t, (X t).map (algebraMap ℝ ℂ) = P t * NormedSpace.exp (t • R) := by
  sorry

/-- Kong 3.2.3, stability in terms of characteristic multipliers. -/
theorem kong_3_2_3_characteristic_multiplier_stability
    {n : ℕ} {A : ℝ → Matrix (Fin n) (Fin n) ℝ} {μ : Fin n → ℂ}
    {V : Matrix (Fin n) (Fin n) ℂ} {ω : ℝ}
    (hω : 0 < ω) (hperiodic : PeriodicLinearEquation ω A)
    (hV : IsPeriodTransitionMatrix ω A V) (hμ : CharacteristicMultipliers V μ) :
    (UniformlyStableLinearEquation A ↔
      ∀ i, ‖μ i‖ ≤ 1 ∧ (‖μ i‖ = 1 → InDiagonalJordanBlock V (μ i))) ∧
    (AsymptoticallyStableLinearEquation A ↔ ∀ i, ‖μ i‖ < 1) ∧
    (UnstableLinearEquation A ↔
      ∃ i, 1 < ‖μ i‖ ∨ (‖μ i‖ = 1 ∧ ¬InDiagonalJordanBlock V (μ i))) := by
  sorry

/-- Kong 3.4.2, stability under an integrable small perturbation. -/
theorem kong_3_4_2_integrable_perturbation_stability
    {n : ℕ} {A : ℝ → Matrix (Fin n) (Fin n) ℝ}
    {r : ℝ → (Fin n → ℝ) → (Fin n → ℝ)} {p : ℝ → ℝ}
    (hr : IntegrableSmallPerturbation p r) :
    (UniformlyStableLinearEquation A →
      UniformlyStableZeroSolution (fun t x ↦ A t *ᵥ x + r t x)) ∧
    (UniformlyStableLinearEquation A → AsymptoticallyStableLinearEquation A →
      AsymptoticallyStableZeroSolution (fun t x ↦ A t *ᵥ x + r t x)) := by
  sorry

/-- Kong 3.5.2, LaSalle's invariance principle. -/
theorem kong_3_5_2_lasalle_invariance_stability
    {n : ℕ} {l : ℝ} {F : (Fin n → ℝ) → (Fin n → ℝ)} {V : (Fin n → ℝ) → ℝ}
    (hl : 0 < l) (hV : LyapunovFunctionOnBall l V F)
    (horbit : NoNontrivialOrbitInZeroDerivativeSet l V F) :
    AsymptoticallyStableZeroSolution (fun _ x ↦ F x) := by
  sorry

/-- Kong 4.5.3, the generalized Poincare-Bendixson theorem. -/
theorem kong_4_5_3_generalized_poincare_bendixson
    {F : (Fin 2 → ℝ) → (Fin 2 → ℝ)} {x : ℝ → (Fin 2 → ℝ)}
    {E : Set (Fin 2 → ℝ)}
    (hcompact : IsCompact E) (horbit : IsAutonomousTrajectory F x)
    (hfinite : {x ∈ E | F x = 0}.Finite) :
    let classify := fun limitSet : Set (Fin 2 → ℝ) ↦
      (∃ e, limitSet = {e} ∧ F e = 0) ∨ IsClosedOrbit F x ∨
        (∃ y, IsClosedOrbit F y ∧ limitSet = range y) ∨ GraphicForPlanarSystem F limitSet
    ((∀ t, 0 ≤ t → x t ∈ E) → classify (omegaLimitSet x)) ∧
      ((∀ t, t ≤ 0 → x t ∈ E) → classify (alphaLimitSet x)) := by
  sorry

/-- Kong 5.4.2, the Hopf-Friedrich dichotomy. -/
theorem kong_5_4_2_hopf_friedrich_dichotomy
    {F : (Fin 2 → ℝ) → ℝ → (Fin 2 → ℝ)} {β : ℝ}
    (hβ : 0 < β)
    (hF : ContDiff ℝ ⊤ (fun p : (Fin 2 → ℝ) × ℝ ↦ F p.1 p.2) ∧
      (∀ μ, F 0 μ = 0) ∧ Matrix.trace (linearizationMatrix F 0) = 0 ∧
        Matrix.det (linearizationMatrix F 0) = β ^ 2 ∧
          HasDerivAt (fun μ ↦ Matrix.trace (linearizationMatrix F μ)) 0 0) :
    let center :=
      (∃ ε : ℝ, 0 < ε ∧
        ∀ x : ℝ → (Fin 2 → ℝ), IsAutonomousTrajectory (fun y ↦ F y 0) x →
          ‖x 0‖ < ε → (∃ t, x t ≠ x 0) → IsClosedOrbit (fun y ↦ F y 0) x) ∧
      ∃ ε : ℝ, 0 < ε ∧ ∀ μ, 0 < |μ| → |μ| < ε →
        ¬∃ x : ℝ → (Fin 2 → ℝ), IsClosedOrbit (fun y ↦ F y μ) x ∧ ‖x 0‖ < ε
    let hopf := fun positiveSide ↦
      ∃ ε : ℝ, ∃ orbit : ℝ → ℝ → (Fin 2 → ℝ),
        ∃ period : ℝ → ℝ, 0 < ε ∧
        (∀ μ, 0 < |μ| → |μ| < ε → (if positiveSide then 0 < μ else μ < 0) →
          IsClosedOrbit (fun y ↦ F y μ) (orbit μ) ∧ 0 < period μ ∧
            (∀ t, orbit μ (t + period μ) = orbit μ t) ∧
            ∀ y, IsClosedOrbit (fun z ↦ F z μ) y → ‖y 0‖ < ε →
              range y = range (orbit μ)) ∧
        Tendsto (fun μ ↦ ‖orbit μ 0‖) (𝓝[≠] 0) (𝓝 0) ∧
        Tendsto period (𝓝[≠] 0) (𝓝 (2 * Real.pi / β))
    center ∨ hopf true ∨ hopf false := by
  sorry

/-- Kong 6.6.4, coupling of periodic, Dirichlet, and Neumann spectra. -/
theorem kong_6_6_4_periodic_sturm_liouville_coupling
    {p q w : ℝ → ℝ} {a b : ℝ} {lam μ ν : ℕ → ℝ}
    (hSL : PeriodicSturmLiouvilleData p q w a b) :
    (∀ n, lam n ≤ lam (n + 1)) ∧ Tendsto lam atTop atTop ∧
      ν 0 ≤ lam 0 ∧
      (∀ n, lam (2 * n) < μ (2 * n) ∧ lam (2 * n) < ν (2 * n + 1) ∧
        μ (2 * n) < lam (2 * n + 1) ∧ ν (2 * n + 1) < lam (2 * n + 1) ∧
        lam (2 * n + 1) ≤ μ (2 * n + 1) ∧ lam (2 * n + 1) ≤ ν (2 * n + 2) ∧
        μ (2 * n + 1) ≤ lam (2 * n + 2) ∧ ν (2 * n + 2) ≤ lam (2 * n + 2)) ∧
      (∀ eigVal, (∃ y, IsSturmLiouvilleEigenfunction p q w a b eigVal
        (periodicBoundary p a b) y) ↔ ∃ n, lam n = eigVal) ∧
      (∀ eigVal, (∃ y, IsSturmLiouvilleEigenfunction p q w a b eigVal
        (dirichletBoundary a b) y) ↔ ∃ n, μ n = eigVal) ∧
      (∀ eigVal, (∃ y, IsSturmLiouvilleEigenfunction p q w a b eigVal
        (neumannBoundary a b) y) ↔ ∃ n, ν n = eigVal) ∧
      (∀ y, IsSturmLiouvilleEigenfunction p q w a b (lam 0)
        (periodicBoundary p a b) y → {x ∈ Set.Icc a b | y x = 0} = ∅) ∧
      (∀ y₁ y₂, IsSturmLiouvilleEigenfunction p q w a b (lam 0)
        (periodicBoundary p a b) y₁ →
        IsSturmLiouvilleEigenfunction p q w a b (lam 0)
          (periodicBoundary p a b) y₂ → ∃ c : ℝ, y₂ = c • y₁) ∧
      (∀ n, (∃ i j, lam n = μ i ∧ lam n = ν j) ↔
        ∃ y₁ y₂, IsSturmLiouvilleEigenfunction p q w a b (lam n)
          (periodicBoundary p a b) y₁ ∧
          IsSturmLiouvilleEigenfunction p q w a b (lam n)
            (periodicBoundary p a b) y₂ ∧ ¬∃ c : ℝ, y₂ = c • y₁) ∧
      ∀ n, (∀ y, IsSturmLiouvilleEigenfunction p q w a b (lam (2 * n + 1))
        (periodicBoundary p a b) y →
          {x ∈ Set.Ico a b | y x = 0}.ncard = 2 * n + 2) ∧
        ∀ y, IsSturmLiouvilleEigenfunction p q w a b (lam (2 * n + 2))
          (periodicBoundary p a b) y →
            {x ∈ Set.Ico a b | y x = 0}.ncard = 2 * n + 2 := by
  sorry

end KongODE
end Dataset
