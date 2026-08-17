import Mathlib.Analysis.ODE.PicardLindelof
import Mathlib.LinearAlgebra.Matrix.Charpoly.Basic

/-!
# Shared definitions for the KongODE problems

Custom notions used by the statement files in `Dataset/KongODE/` that are
not already supplied by Mathlib. Each problem file that needs them imports
this module.
-/

open Filter MeasureTheory Set
open scoped Matrix Topology

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
  ∀ t ∈ I, HasDerivWithinAt x (F t (x t)) I t

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
    0 ≤ t₀ → IsTrajectoryOn (Set.Ici t₀) F x → ‖x t₀‖ < δ → ∀ t, t₀ ≤ t → ‖x t‖ < ε

/-- Uniform stability together with convergence of all sufficiently small solutions to zero. -/
def AsymptoticallyStableZeroSolution {n : ℕ}
    (F : ℝ → (Fin n → ℝ) → (Fin n → ℝ)) : Prop :=
  UniformlyStableZeroSolution F ∧ ∃ δ : ℝ, 0 < δ ∧ ∀ t₀ x,
    0 ≤ t₀ → IsTrajectoryOn (Set.Ici t₀) F x → ‖x t₀‖ < δ → Tendsto x atTop (𝓝 0)

/-- Instability, as the negation of uniform stability. For the periodic systems of Kong's
Chapter 3 — the only place this is used — stability and uniform stability coincide, so this
is also the negation of Lyapunov stability there. -/
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
  ContinuousOn p (Set.Ici 0) ∧ (∀ t ≥ 0, 0 ≤ p t) ∧
    IntegrableOn p (Set.Ici 0) ∧
    ∃ ρ : ℝ, 0 < ρ ∧
      ∀ t, 0 ≤ t → ∀ x, ‖x‖ < ρ → ‖r t x‖ ≤ p t * ‖x‖

/-- A positive-definite Lyapunov function with nonpositive orbital derivative on a ball. -/
def LyapunovFunctionOnBall {n : ℕ} (l : ℝ) (V : (Fin n → ℝ) → ℝ)
    (F : (Fin n → ℝ) → (Fin n → ℝ)) : Prop :=
  ContDiffOn ℝ 1 V (Metric.closedBall 0 l) ∧ V 0 = 0 ∧
    (∀ x ∈ Metric.closedBall (0 : (Fin n → ℝ)) l, x ≠ 0 → 0 < V x) ∧
    ∀ x ∈ Metric.closedBall (0 : (Fin n → ℝ)) l,
      fderivWithin ℝ V (Metric.closedBall 0 l) x (F x) ≤ 0

/-- No complete nonzero trajectory remains in the zero orbital-derivative set. -/
def NoNontrivialOrbitInZeroDerivativeSet {n : ℕ} (l : ℝ)
    (V : (Fin n → ℝ) → ℝ) (F : (Fin n → ℝ) → (Fin n → ℝ)) : Prop :=
  ∀ x : ℝ → (Fin n → ℝ), IsAutonomousTrajectory F x →
    (∀ t, x t ∈ Metric.closedBall (0 : (Fin n → ℝ)) l ∧
      fderivWithin ℝ V (Metric.closedBall 0 l) (x t) (F (x t)) = 0) →
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
    (boundary : (ℝ → ℝ) → (ℝ → ℝ) → Prop) (y : ℝ → ℝ) : Prop :=
  (∃ x ∈ Set.Icc a b, y x ≠ 0) ∧ ∃ y' : ℝ → ℝ, boundary y y' ∧
    (∀ x ∈ Set.Icc a b, HasDerivWithinAt y (y' x) (Set.Icc a b) x) ∧
    ∀ x ∈ Set.Icc a b,
      HasDerivWithinAt (fun t ↦ p t * y' t) ((q x - eigVal * w x) * y x)
        (Set.Icc a b) x

/-- Regular periodic Sturm-Liouville coefficient and boundary data. -/
def PeriodicSturmLiouvilleData (p q w : ℝ → ℝ) (a b : ℝ) : Prop :=
  a < b ∧ ContinuousOn p (Set.Icc a b) ∧ ContinuousOn q (Set.Icc a b) ∧
    ContinuousOn w (Set.Icc a b) ∧
    (∀ x ∈ Set.Icc a b, 0 < p x ∧ 0 < w x)

/-- Periodic, Dirichlet, and Neumann boundary conditions. -/
def PeriodicBoundary (p : ℝ → ℝ) (a b : ℝ) (y y' : ℝ → ℝ) : Prop :=
  y a = y b ∧ p a * y' a = p b * y' b

/-- Dirichlet boundary conditions at both endpoints. -/
def DirichletBoundary (a b : ℝ) (y _y' : ℝ → ℝ) : Prop := y a = 0 ∧ y b = 0

/-- Neumann boundary conditions at both endpoints. -/
def NeumannBoundary (a b : ℝ) (_y y' : ℝ → ℝ) : Prop := y' a = 0 ∧ y' b = 0

end KongODE
end Dataset
