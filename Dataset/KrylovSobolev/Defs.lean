module

public import Mathlib.Analysis.Calculus.ContDiff.Basic
public import Mathlib.Analysis.Distribution.TestFunction
public import Mathlib.Analysis.InnerProductSpace.Laplacian
public import Mathlib.Analysis.Distribution.SchwartzSpace.Fourier
public import Mathlib.Analysis.InnerProductSpace.PiL2
public import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
public import Mathlib.MeasureTheory.Function.LocallyIntegrable
public import Mathlib.MeasureTheory.Function.LpSeminorm.Basic
public import Mathlib.MeasureTheory.Integral.Average
public import Mathlib.MeasureTheory.Integral.Bochner.Basic
public import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
public import Mathlib.MeasureTheory.Measure.Lebesgue.EqHaar

/-!
# Shared definitions for the KrylovSobolev problems

Custom notions used by the statement files in `Dataset/KrylovSobolev/` that are
not already supplied by Mathlib. Each problem file that needs them imports
this module.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology TopologicalSpace
open scoped ContDiff Distributions ENNReal FourierTransform Laplacian Topology

namespace Dataset
namespace KrylovSobolev

/-! ### Classical derivatives and multi-indices -/

/-- Repeated coordinate differentiation along a list of coordinate axes. -/
noncomputable def directionalDerivativeList {d : ℕ} :
    List (Fin d) → (EuclideanSpace ℝ (Fin d) → ℝ) → EuclideanSpace ℝ (Fin d) → ℝ
  | [], u => u
  | i :: indices, u => fun x ↦
      fderiv ℝ (directionalDerivativeList indices u) x (EuclideanSpace.single i 1)

/-- A deterministic list containing coordinate `i` exactly `α i` times. -/
noncomputable def multiIndexDirections {d : ℕ} (α : Fin d → ℕ) : List (Fin d) :=
  Finset.univ.toList.flatMap fun i ↦ List.replicate (α i) i

/-- The classical mixed derivative `D^α u` selected by a multi-index. -/
noncomputable def multiDerivative {d : ℕ} (α : Fin d → ℕ)
    (u : EuclideanSpace ℝ (Fin d) → ℝ) : EuclideanSpace ℝ (Fin d) → ℝ :=
  directionalDerivativeList (multiIndexDirections α) u

/-- The multi-indices of order at most `k`. -/
def multiIndicesLE (d k : ℕ) : Finset (Fin d → ℕ) :=
  (Fintype.piFinset fun _ : Fin d ↦ Finset.range (k + 1)).filter fun α ↦ ∑ i, α i ≤ k

/-- The Hessian matrix `u_{xx} = (u_{x^ix^j})`. -/
noncomputable def hessian {d : ℕ} (u : EuclideanSpace ℝ (Fin d) → ℝ)
    (x : EuclideanSpace ℝ (Fin d)) : Matrix (Fin d) (Fin d) ℝ :=
  Matrix.of fun i j ↦ directionalDerivativeList [i, j] u x

/-- The half space `ℝ^d_+ = {x : x¹ > 0}`, as an open subset of `ℝ^d`. -/
def upperHalfSpace (d : ℕ) [NeZero d] : Opens (EuclideanSpace ℝ (Fin d)) where
  carrier := {x | 0 < x 0}
  is_open' := isOpen_lt continuous_const (by fun_prop)

/-- The open half space `{x : x¹ > 0}` as a plain set, for use where no openness is needed. -/
def upperHalfSpaceSet (d : ℕ) : Set (EuclideanSpace ℝ (Fin d)) := {x | ∀ h : 0 < d, 0 < x ⟨0, h⟩}

/-- The boundary hyperplane `{y : y¹ = 0}` of the half space. -/
def boundaryHyperplane (d : ℕ) : Set (EuclideanSpace ℝ (Fin d)) := {y | ∀ h : 0 < d, y ⟨0, h⟩ = 0}

/-! ### Sobolev spaces -/

/-- Krylov's Definition 1.3.4: `h` is the `D^α` generalized (Sobolev) derivative of `v`
on `Ω`, that is `∫_Ω φ h dx = (-1)^{|α|} ∫_Ω v D^α φ dx` for all `φ ∈ C_0^∞(Ω)`. -/
def IsSobolevDerivOn {d : ℕ} (Ω : Opens (EuclideanSpace ℝ (Fin d))) (α : Fin d → ℕ)
    (v h : EuclideanSpace ℝ (Fin d) → ℝ) : Prop :=
  LocallyIntegrableOn v Ω ∧ LocallyIntegrableOn h Ω ∧
    ∀ φ : 𝓓(Ω, ℝ), ∫ x in (Ω : Set (EuclideanSpace ℝ (Fin d))), φ x * h x =
      (-1 : ℝ) ^ (∑ i, α i) *
        ∫ x in (Ω : Set (EuclideanSpace ℝ (Fin d))), v x * multiDerivative α (⇑φ) x

/-- `D` assigns to every multi-index of order at most `k` a generalized derivative of `u` on `Ω`.
Generalized derivatives are unique up to a null set, so any two such families agree a.e. -/
def IsSobolevFamilyOn {d : ℕ} (k : ℕ) (Ω : Opens (EuclideanSpace ℝ (Fin d)))
    (u : EuclideanSpace ℝ (Fin d) → ℝ) (D : (Fin d → ℕ) → EuclideanSpace ℝ (Fin d) → ℝ) : Prop :=
  ∀ α ∈ multiIndicesLE d k, IsSobolevDerivOn Ω α u (D α)

/-- Membership in Krylov's Sobolev space `W_p^k(Ω)`, in the generalized-derivative form of
Exercise 1.8.8: `u ∈ 𝓛_p(Ω)` and all `D^α u` with `|α| ≤ k` exist and lie in `𝓛_p(Ω)`. -/
def MemSobolevOn {d : ℕ} (p : ℝ≥0∞) (k : ℕ) (Ω : Opens (EuclideanSpace ℝ (Fin d)))
    (u : EuclideanSpace ℝ (Fin d) → ℝ) : Prop :=
  MemLp u p (volume.restrict Ω) ∧
    ∃ D, IsSobolevFamilyOn k Ω u D ∧ ∀ α ∈ multiIndicesLE d k,
      MemLp (D α) p (volume.restrict Ω)

/-- Krylov's Definition 1.3.7: the norm `‖u‖_{W_p^k(Ω)} = ∑_{|α| ≤ k} ‖D^α u‖_{𝓛_p(Ω)}`,
computed from a family of representatives of the generalized derivatives. -/
noncomputable def sobolevNorm {d : ℕ} (p : ℝ≥0∞) (k : ℕ)
    (Ω : Opens (EuclideanSpace ℝ (Fin d)))
    (D : (Fin d → ℕ) → EuclideanSpace ℝ (Fin d) → ℝ) : ℝ≥0∞ :=
  ∑ α ∈ multiIndicesLE d k,
    eLpNorm (D α) p (volume.restrict Ω)

/-- `|u_x|`, the Euclidean length of the generalized gradient read off a derivative family. -/
noncomputable def gradNorm {d : ℕ} (D : (Fin d → ℕ) → EuclideanSpace ℝ (Fin d) → ℝ)
    (x : EuclideanSpace ℝ (Fin d)) : ℝ :=
  √(∑ i, D (Pi.single i 1) x ^ 2)

/-- `|u_{xx}|`, the Euclidean length of the generalized Hessian read off a derivative family. -/
noncomputable def hessNorm {d : ℕ} (D : (Fin d → ℕ) → EuclideanSpace ℝ (Fin d) → ℝ)
    (x : EuclideanSpace ℝ (Fin d)) : ℝ :=
  √(∑ i, ∑ j, D (Pi.single i 1 + Pi.single j 1) x ^ 2)

/-! ### Domains -/

/-- The interior diameter `ρ(Ω)`: the largest diameter of an open ball contained in `Ω`. -/
noncomputable def interiorDiameter {d : ℕ} (Ω : Opens (EuclideanSpace ℝ (Fin d))) : ℝ :=
  2 * sSup {r : ℝ | ∃ x, Metric.ball x r ⊆ (Ω : Set (EuclideanSpace ℝ (Fin d)))}

/-- Krylov's condition (10.1.1): a bounded convex domain whose diameter is at most `κ`
times its interior diameter. -/
structure IsConvexDomainWith {d : ℕ} (κ : ℝ) (Ω : Opens (EuclideanSpace ℝ (Fin d))) : Prop where
  nonempty : (Ω : Set (EuclideanSpace ℝ (Fin d))).Nonempty
  convex : Convex ℝ (Ω : Set (EuclideanSpace ℝ (Fin d)))
  isBounded : Bornology.IsBounded (Ω : Set (EuclideanSpace ℝ (Fin d)))
  diam_le : Metric.diam (Ω : Set (EuclideanSpace ℝ (Fin d))) ≤ κ * interiorDiameter Ω

/-- `sup_{y ∈ Ω} ⨍_{Ω ∩ B₁(y)} |u(z)| dz`, the right-hand side of Krylov's estimate
(10.2.3), as an extended real so that an unbounded family does not collapse to a junk
value. -/
noncomputable def unitBallAverageSup {d : ℕ} (Ω : Set (EuclideanSpace ℝ (Fin d)))
    (u : EuclideanSpace ℝ (Fin d) → ℝ) : ℝ≥0∞ :=
  ⨆ y : Ω, ENNReal.ofReal
    (⨍ z in Ω ∩ Metric.ball (y : EuclideanSpace ℝ (Fin d)) 1, |u z|)

/-- The `C^k(G)` norm `∑_{|β| ≤ k} sup_G |D^β u|` of a scalar function. -/
noncomputable def ckNormOn {d : ℕ} (k : ℕ) (G : Set (EuclideanSpace ℝ (Fin d)))
    (u : EuclideanSpace ℝ (Fin d) → ℝ) : ℝ≥0∞ :=
  ∑ β ∈ multiIndicesLE d k, ⨆ x : G, ENNReal.ofReal |multiDerivative β u x|

/-- The `C^k(G)` norm of a map, summed over the coordinates of the target. -/
noncomputable def ckNormMapOn {d : ℕ} (k : ℕ) (G : Set (EuclideanSpace ℝ (Fin d)))
    (ψ : EuclideanSpace ℝ (Fin d) → EuclideanSpace ℝ (Fin d)) : ℝ≥0∞ :=
  ∑ i, ckNormOn k G fun x ↦ ψ x i

/-- Krylov's Definition 8.3.1: a bounded domain of class `C^k`, i.e. one whose boundary can be
flattened near each of its points by a `C^k` diffeomorphism whose `C^k` norm, and that of its
inverse, are bounded by a constant `K₀` uniform in the point. -/
structure IsCkDomain {d : ℕ} (k : ℕ) (Ω : Opens (EuclideanSpace ℝ (Fin d))) : Prop where
  nonempty : (Ω : Set (EuclideanSpace ℝ (Fin d))).Nonempty
  isBounded : Bornology.IsBounded (Ω : Set (EuclideanSpace ℝ (Fin d)))
  /-- Near every boundary point some `C^k` diffeomorphism flattens the boundary, with uniform
  bounds `K₀` on the `C^k` norms and a uniform radius `ρ₀`. -/
  exists_flattening : ∃ K₀ ρ₀ : ℝ, 0 < K₀ ∧ 0 < ρ₀ ∧
    ∀ z ∈ frontier (Ω : Set (EuclideanSpace ℝ (Fin d))),
      ∃ (D : Opens (EuclideanSpace ℝ (Fin d)))
        (ψ ψinv : EuclideanSpace ℝ (Fin d) → EuclideanSpace ℝ (Fin d)),
        BijOn ψ (Metric.ball z ρ₀) D ∧ InvOn ψinv ψ (Metric.ball z ρ₀) D ∧ ψ z = 0 ∧
          ψ '' (Metric.ball z ρ₀ ∩ (Ω : Set (EuclideanSpace ℝ (Fin d)))) ⊆
            (upperHalfSpaceSet d) ∧
          ψ '' (Metric.ball z ρ₀ ∩ frontier (Ω : Set (EuclideanSpace ℝ (Fin d)))) =
            (D : Set (EuclideanSpace ℝ (Fin d))) ∩ boundaryHyperplane d ∧
          ContDiffOn ℝ k ψ (Metric.closedBall z ρ₀) ∧
          ContDiffOn ℝ k ψinv (closure (D : Set (EuclideanSpace ℝ (Fin d)))) ∧
          ckNormMapOn k (Metric.closedBall z ρ₀) ψ +
            ckNormMapOn k (closure (D : Set (EuclideanSpace ℝ (Fin d)))) ψinv ≤ ENNReal.ofReal K₀

/-! ### Second-order elliptic operators -/

/-- Krylov's Definition 1.4.1 together with the boundedness half of Assumption 1.6.1: the
coefficient data of a second-order elliptic operator `L = a^{ij}D_{ij} + b^iD_i + c` with symmetric
measurable coefficients bounded by `K` and constant of ellipticity `κ`. -/
structure EllipticCoefficients (d : ℕ) (κ K : ℝ) where
  /-- The leading coefficients `a^{ij}`. -/
  a : EuclideanSpace ℝ (Fin d) → Matrix (Fin d) (Fin d) ℝ
  /-- The first-order coefficients `b^i`. -/
  b : EuclideanSpace ℝ (Fin d) → EuclideanSpace ℝ (Fin d)
  /-- The zeroth-order coefficient `c`. -/
  c : EuclideanSpace ℝ (Fin d) → ℝ
  measurable_a : ∀ i j, Measurable fun x ↦ a x i j
  measurable_b : ∀ i, Measurable fun x ↦ b x i
  measurable_c : Measurable c
  isSymm : ∀ x, (a x).IsSymm
  ellipticityConstant_pos : 0 < κ
  le_quadraticForm : ∀ (x ξ : EuclideanSpace ℝ (Fin d)),
    κ * ‖ξ‖ ^ 2 ≤ ∑ i, ∑ j, a x i j * ξ i * ξ j
  quadraticForm_le : ∀ (x ξ : EuclideanSpace ℝ (Fin d)),
    ∑ i, ∑ j, a x i j * ξ i * ξ j ≤ κ⁻¹ * ‖ξ‖ ^ 2
  abs_a_le : ∀ x i j, |a x i j| ≤ K
  abs_b_le : ∀ x i, |b x i| ≤ K
  abs_c_le : ∀ x, |c x| ≤ K

/-- The action `Lu = a^{ij}D_{ij}u + b^iD_iu + cu` of the operator described by `L`. -/
noncomputable def EllipticCoefficients.op {d : ℕ} {κ K : ℝ} (L : EllipticCoefficients d κ K)
    (u : EuclideanSpace ℝ (Fin d) → ℝ) (x : EuclideanSpace ℝ (Fin d)) : ℝ :=
  (∑ i, ∑ j, L.a x i j * directionalDerivativeList [i, j] u x) +
    (∑ i, L.b x i * directionalDerivativeList [i] u x) + L.c x * u x

/-! ### Filtrations of partitions, maximal and sharp functions -/

/-- Krylov's Definitions 3.1.1 and 3.1.4: a filtration of partitions of a measure space,
presented through the map `x ↦ C_n(x)` sending a point to the element of the `n`-th
partition containing it. Condition (i) of Definition 3.1.1 is recorded through
`tendsto_measure_atBot` and the differentiation property of the dense class `denseClass`;
conditions (ii) and (iii) are `cell_subset` and `measure_cell_le`. -/
structure FiltrationOfPartitions (X : Type*) [MeasurableSpace X] (μ : Measure X) where
  /-- `cell n x` is the element `C_n(x)` of the `n`-th partition containing `x`. -/
  cell : ℤ → X → Set X
  countable_partition : ∀ n, (range (cell n)).Countable
  measurableSet_cell : ∀ n x, MeasurableSet (cell n x)
  measure_cell_ne_top : ∀ n x, μ (cell n x) ≠ (∞ : ℝ≥0∞)
  mem_cell : ∀ n x, x ∈ cell n x
  cell_congr : ∀ n x y, y ∈ cell n x → cell n y = cell n x
  cell_subset : ∀ n x, cell n x ⊆ cell (n - 1) x
  /-- The regularity constant `N₀` of condition (iii). -/
  regularityConstant : ℝ≥0∞
  measure_cell_le : ∀ n x, μ (cell (n - 1) x) ≤ regularityConstant * μ (cell n x)
  tendsto_measure_atBot : Tendsto (fun n : ℤ ↦ ⨅ x, μ (cell n x)) atBot (𝓝 (∞ : ℝ≥0∞))
  /-- The dense subset `𝕃 ⊆ 𝓛₁(Ω)` of condition (i). -/
  denseClass : Set (X → ℝ)
  denseClass_dense : ∀ f : X → ℝ, MemLp f 1 μ → ∀ ε : ℝ≥0∞, 0 < ε →
    ∃ g ∈ denseClass, MemLp g 1 μ ∧ eLpNorm (f - g) 1 μ < ε
  denseClass_differentiation : ∀ g ∈ denseClass, ∀ᵐ x ∂μ,
    Tendsto (fun n : ℤ ↦ ⨍ y in cell n x, g y ∂μ) atTop (𝓝 (g x))

/-- The sharp function `f^#(x) = sup_n ⨍_{C_n(x)} |f(y) - f_{|n}(y)| μ(dy)`. -/
noncomputable def sharpFunction {X : Type*} [MeasurableSpace X] {μ : Measure X}
    (F : FiltrationOfPartitions X μ) (f : X → ℝ) (x : X) : ℝ≥0∞ :=
  ⨆ n : ℤ, ENNReal.ofReal (⨍ y in F.cell n x, |f y - ⨍ z in F.cell n y, f z ∂μ| ∂μ)

/-! ### Bessel potentials -/

/-- `v = (1-Δ)^{-γ/2}φ`: Krylov's Definition 12.9.1 says that `(1-Δ)^{-γ/2}` is the
pseudo-differential operator with symbol `(1+|ξ|²)^{-γ/2}`. Mathlib's Fourier transform
`𝓕 f ξ = ∫ e^{-2πi⟪x,ξ⟫} f x dx` turns `1-Δ` into multiplication by `1+4π²|ξ|²`, so that
is the symbol appearing here. -/
def IsBesselPotential {d : ℕ} (γ : ℝ)
    (φ v : EuclideanSpace ℝ (Fin d) → ℂ) : Prop :=
  ∀ ξ : EuclideanSpace ℝ (Fin d),
    𝓕 v ξ = ((1 + 4 * Real.pi ^ 2 * ‖ξ‖ ^ 2) ^ (-γ / 2) : ℝ) * 𝓕 φ ξ

end KrylovSobolev
end Dataset
