import Mathlib.Analysis.Calculus.IteratedDeriv.Defs
import Mathlib.Analysis.InnerProductSpace.Harmonic.Basic
import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
import Mathlib.MeasureTheory.Measure.Hausdorff

/-!
# Shared definitions for the KrylovHolder problems

Custom notions used by the statement files in `Dataset/KrylovHolder/` that are
not already supplied by Mathlib. Each problem file that needs them imports
this module.
-/

open Laplacian MeasureTheory Set
open scoped ContDiff ENNReal Topology

namespace Dataset
namespace KrylovHolder

variable {F : Type*} [NormedAddCommGroup F] [NormedSpace ℝ F]

/-- Repeated coordinate directional differentiation along a list of coordinate axes. -/
noncomputable def directionalDerivativeList {d : ℕ} :
    List (Fin d) → (EuclideanSpace ℝ (Fin d) → F) → EuclideanSpace ℝ (Fin d) → F
  | [], u => u
  | i :: indices, u => fun x ↦
      fderiv ℝ (directionalDerivativeList indices u) x (EuclideanSpace.single i 1)

/-- A deterministic list containing coordinate `i` exactly `α i` times. -/
noncomputable def multiIndexDirections {d : ℕ} (α : (Fin d → ℕ)) : List (Fin d) :=
  Finset.univ.toList.flatMap fun i ↦ List.replicate (α i) i

/-- The classical mixed derivative selected by a multi-index. -/
noncomputable def multiDerivative {d : ℕ} (α : (Fin d → ℕ))
    (u : EuclideanSpace ℝ (Fin d) → F) : EuclideanSpace ℝ (Fin d) → F :=
  directionalDerivativeList (multiIndexDirections α) u

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

/-- One-dimensional `C^r` Holder regularity on a time set. -/
def HolderOnReal (r : ℝ) (I : Set ℝ) (u : ℝ → ℝ) : Prop :=
  ∃ (k : ℕ) (δ : ℝ) (hδ : 0 ≤ δ), r = k + δ ∧ δ < 1 ∧ ContDiffOn ℝ k u I ∧
    ∃ C : NNReal, HolderOnWith C (⟨δ, hδ⟩ : NNReal) (iteratedDeriv k u) I

/-- An anisotropic parabolic Holder condition with time exponent `r/2`: slice-wise membership
in the right one-variable classes, together with **one constant, uniform over `Q`**, bounding
every pure derivative of parabolic weight at most `k` (`r = k + δ'`) and the anisotropic Holder
quotients of the top-order data. At `r = δ < 1` this is `C^{δ/2, δ}` (the quotient falls on `u`
itself); at `r = 2 + δ` it is Krylov's `C^{1+δ/2, 2+δ}`: `u`, `D_x u`, `D²_x u`, `u_t` bounded,
the top-order data `D²_x u`, `u_t` anisotropically `(δ, δ/2)`-Holder, and `D_x u` Holder of
exponent `(1+δ)/2` in time. The exponents apply to the top order, never to `u` itself when
`r > 1` — applying `r` directly to `u` would force local constancy. -/
def ParabolicHolderOn {d : ℕ} (r : ℝ) (Q : Set (ℝ × EuclideanSpace ℝ (Fin d)))
  (u : (ℝ × EuclideanSpace ℝ (Fin d)) → ℝ) : Prop :=
  (∀ t, HolderOn r {x | (t, x) ∈ Q} fun x ↦ u (t, x)) ∧
    (∀ x, HolderOnReal (r / 2) {t | (t, x) ∈ Q} fun t ↦ u (t, x)) ∧
    ∃ (k : ℕ) (δ' : ℝ), r = k + δ' ∧ 0 ≤ δ' ∧ δ' < 1 ∧
      ∃ C : ℝ,
        (∀ α : Fin d → ℕ, ∑ i, α i ≤ k → ∀ p ∈ Q,
          |multiDerivative α (fun x ↦ u (p.1, x)) p.2| ≤ C) ∧
        (∀ j : ℕ, 2 * j ≤ k → ∀ p ∈ Q,
          |iteratedDeriv j (fun s ↦ u (s, p.2)) p.1| ≤ C) ∧
        (∀ α : Fin d → ℕ, ∑ i, α i = k → ∀ p ∈ Q, ∀ q ∈ Q,
          |multiDerivative α (fun x ↦ u (p.1, x)) p.2 -
              multiDerivative α (fun x ↦ u (q.1, x)) q.2| ≤
            C * (‖p.2 - q.2‖ ^ δ' + |p.1 - q.1| ^ (δ' / 2))) ∧
        (∀ j : ℕ, 2 * j = k → ∀ p ∈ Q, ∀ q ∈ Q,
          |iteratedDeriv j (fun s ↦ u (s, p.2)) p.1 -
              iteratedDeriv j (fun s ↦ u (s, q.2)) q.1| ≤
            C * (‖p.2 - q.2‖ ^ δ' + |p.1 - q.1| ^ (δ' / 2))) ∧
        ∀ α : Fin d → ℕ, ∑ i, α i + 1 = k → ∀ p ∈ Q, ∀ q ∈ Q, p.2 = q.2 →
          |multiDerivative α (fun x ↦ u (p.1, x)) p.2 -
              multiDerivative α (fun x ↦ u (q.1, x)) q.2| ≤
            C * |p.1 - q.1| ^ ((1 + δ') / 2)

/-- A unit normal which points from the domain into its complement. -/
def IsOutwardUnitNormal {d : ℕ} (Ω : Set (EuclideanSpace ℝ (Fin d)))
    (normal : EuclideanSpace ℝ (Fin d) → EuclideanSpace ℝ (Fin d)) : Prop :=
  ∀ y ∈ frontier Ω, ‖normal y‖ = 1 ∧
    (∀ γ : ℝ → EuclideanSpace ℝ (Fin d), ∀ velocity,
      γ 0 = y → (∀ᶠ t in 𝓝 0, γ t ∈ frontier Ω) → HasDerivAt γ velocity 0 →
        inner ℝ (normal y) velocity = 0) ∧
    ∃ ε : ℝ, 0 < ε ∧ y - ε • normal y ∈ Ω ∧ y + ε • normal y ∉ closure Ω

/-- Krylov's Chapter-2 standing notion of a **regular** bounded domain: bounded, nonempty,
and regular enough that Green's second identity holds for all `C²(Ω̄)` functions, relative to
the given boundary measure and outward unit normal. -/
def GreensIdentityDomain {d : ℕ} (Ω : Set (EuclideanSpace ℝ (Fin d)))
    (boundaryMeasure : Measure (EuclideanSpace ℝ (Fin d)))
    (normal : EuclideanSpace ℝ (Fin d) → EuclideanSpace ℝ (Fin d)) : Prop :=
  IsOpen Ω ∧ Bornology.IsBounded Ω ∧ Ω.Nonempty ∧
    ∀ v w : EuclideanSpace ℝ (Fin d) → ℝ, ContDiffOn ℝ 2 v (closure Ω) →
      ContDiffOn ℝ 2 w (closure Ω) →
        ∫ x in Ω, (v x * Δ w x - w x * Δ v x) =
          ∫ y, (v y * fderivWithin ℝ w (closure Ω) y (normal y) -
            w y * fderivWithin ℝ v (closure Ω) y (normal y)) ∂boundaryMeasure

/-- A kernel is a fundamental solution when it represents the Dirac distribution. -/
def IsLaplaceFundamentalSolution {d : ℕ}
    (K : EuclideanSpace ℝ (Fin d) → EuclideanSpace ℝ (Fin d) → ℝ) : Prop :=
  ∀ x, ∀ φ : EuclideanSpace ℝ (Fin d) → ℝ,
    ContDiff ℝ ∞ φ → HasCompactSupport φ →
      Integrable (fun y ↦ K x y * Δ φ y) →
        ∫ y, K x y * Δ φ y = φ x

/-- The multi-indices on `Fin d` of total order at most `m`, as a finite set. -/
noncomputable def multiIndicesLE (d m : ℕ) : Finset (Fin d → ℕ) :=
  ((Finset.univ : Finset (Fin d → Fin (m + 1))).image fun α i ↦ (α i : ℕ)).filter
    fun α ↦ ∑ i, α i ≤ m

/-- Krylov's seminorm `[u]_{k;Ω}` (3.1.1): the supremum over `Ω` of the `k`-th order
classical derivatives. -/
noncomputable def supSeminorm {d : ℕ} (k : ℕ) (Ω : Set (EuclideanSpace ℝ (Fin d)))
    (u : EuclideanSpace ℝ (Fin d) → F) : ℝ≥0∞ :=
  ⨆ α : {α : Fin d → ℕ // ∑ i, α i = k}, ⨆ x : Ω,
    ENNReal.ofReal ‖multiDerivative α.1 u x‖

/-- Krylov's Hölder seminorm `[u]_{k+δ;Ω}` (3.1.4): the `δ`-Hölder constants of the `k`-th
order derivatives over `Ω`. -/
noncomputable def holderSeminorm {d : ℕ} (k : ℕ) (δ : ℝ)
    (Ω : Set (EuclideanSpace ℝ (Fin d))) (u : EuclideanSpace ℝ (Fin d) → F) : ℝ≥0∞ :=
  ⨆ α : {α : Fin d → ℕ // ∑ i, α i = k}, ⨆ x : Ω, ⨆ y : Ω,
    ⨆ _ : (x : EuclideanSpace ℝ (Fin d)) ≠ y,
      ENNReal.ofReal (‖multiDerivative α.1 u x - multiDerivative α.1 u y‖ /
        ‖(x : EuclideanSpace ℝ (Fin d)) - y‖ ^ δ)

/-- Krylov's norm `|u|_{k+δ;Ω}` (3.1.2): the derivative suprema through order `k` plus the
top-order Hölder seminorm. -/
noncomputable def krylovHolderNorm {d : ℕ} (k : ℕ) (δ : ℝ)
    (Ω : Set (EuclideanSpace ℝ (Fin d))) (u : EuclideanSpace ℝ (Fin d) → F) : ℝ≥0∞ :=
  ∑ j ∈ Finset.range (k + 1), supSeminorm j Ω u + holderSeminorm k δ Ω u

/-- Membership in Krylov's space `C^{k+δ}(Ω)` (Definition 3.1.1) for functions with values in
a normed space: continuous derivatives through order `k` on `Ω` and finite norm
`|u|_{k+δ;Ω}`. -/
def MemHolderSpace {d : ℕ} (k : ℕ) (δ : ℝ) (Ω : Set (EuclideanSpace ℝ (Fin d)))
    (u : EuclideanSpace ℝ (Fin d) → F) : Prop :=
  ContDiffOn ℝ k u Ω ∧ krylovHolderNorm k δ Ω u < ⊤

/-- Krylov's local space `C^{k+δ}_{loc}(Ω)`: membership in `C^{k+δ}(Ω')` for every bounded
open `Ω'` whose closure lies in `Ω`. -/
def MemHolderSpaceLoc {d : ℕ} (k : ℕ) (δ : ℝ) (Ω : Set (EuclideanSpace ℝ (Fin d)))
    (u : EuclideanSpace ℝ (Fin d) → F) : Prop :=
  ∀ Ω' : Set (EuclideanSpace ℝ (Fin d)), IsOpen Ω' → Bornology.IsBounded Ω' →
    closure Ω' ⊆ Ω → MemHolderSpace k δ Ω' u

/-- `Σ_{|α| ≤ m} a^α(x) λ^{m−|α|} D^α u(x)`: Krylov's operator family `L_λ` attached to the
`m`th-order operator `L = Σ_{|α| ≤ m} a^α D^α`; at `λ = 1` it is `L` itself. -/
noncomputable def lambdaScaledOperator {d : ℕ} (m : ℕ)
    (a : (Fin d → ℕ) → EuclideanSpace ℝ (Fin d) → ℂ) (lam : ℝ)
    (u : EuclideanSpace ℝ (Fin d) → ℂ) (x : EuclideanSpace ℝ (Fin d)) : ℂ :=
  ∑ α ∈ multiIndicesLE d m, a α x * (lam : ℂ) ^ (m - ∑ i, α i) * multiDerivative α u x

/-- The characteristic polynomial `p(ξ) = Σ_{|α| ≤ m} a^α(x) i^{|α|} ξ^α` of the operator
`L = Σ_{|α| ≤ m} a^α D^α` at the point `x`. -/
noncomputable def characteristicPolynomial {d : ℕ} (m : ℕ)
    (a : (Fin d → ℕ) → EuclideanSpace ℝ (Fin d) → ℂ) (x : EuclideanSpace ℝ (Fin d))
    (ξ : EuclideanSpace ℝ (Fin d)) : ℂ :=
  ∑ α ∈ multiIndicesLE d m, a α x * Complex.I ^ (∑ i, α i) * ∏ i, (ξ i : ℂ) ^ α i

/-- Ellipticity in the sense of Krylov's Definition 1.1.1 for the constant-coefficient
operator `L = Σ_{|α| ≤ m} a^α D^α` with complex coefficients: the principal part
`Σ_{|α| = m} a^α ξ^α` does not vanish for `ξ ≠ 0`, and the characteristic polynomial
`Σ_{|α| ≤ m} a^α i^{|α|} ξ^α` does not vanish for any `ξ ∈ ℝ^d`. -/
def IsElliptic {d : ℕ} (m : ℕ) (a : (Fin d → ℕ) → ℂ) : Prop :=
  (∀ ξ : EuclideanSpace ℝ (Fin d), ξ ≠ 0 →
      ∑ α ∈ multiIndicesLE d m with ∑ i, α i = m, a α * ∏ i, (ξ i : ℂ) ^ α i ≠ 0) ∧
    ∀ ξ : EuclideanSpace ℝ (Fin d), characteristicPolynomial m (fun α _ ↦ a α) 0 ξ ≠ 0

/-- Uniform ellipticity in the sense of Krylov's Chapter 4: the characteristic polynomial is
bounded below by `κ(1 + |ξ|^m)`, uniformly in `x`. -/
def UniformlyElliptic {d : ℕ} (m : ℕ) (κ : ℝ)
    (a : (Fin d → ℕ) → EuclideanSpace ℝ (Fin d) → ℂ) : Prop :=
  0 < κ ∧ ∀ x ξ : EuclideanSpace ℝ (Fin d),
    κ * (1 + ‖ξ‖ ^ m) ≤ ‖characteristicPolynomial m a x ξ‖

/-- `Σ_{ij} a^{ij}(x) D_i D_j u + Σ_i b^i(x) D_i u + c(x) u`: a second-order operator given
by its coefficients. -/
noncomputable def secondOrderOperator {d : ℕ}
    (a : EuclideanSpace ℝ (Fin d) → Fin d → Fin d → ℝ)
    (b : EuclideanSpace ℝ (Fin d) → Fin d → ℝ) (c : EuclideanSpace ℝ (Fin d) → ℝ)
    (u : EuclideanSpace ℝ (Fin d) → ℝ) (x : EuclideanSpace ℝ (Fin d)) : ℝ :=
  ∑ i, ∑ j, a x i j * directionalDerivativeList [i, j] u x +
    ∑ i, b x i * directionalDerivativeList [i] u x + c x * u x

/-- Krylov's Definition 6.1.6: a bounded domain of class `C^{n+δ}`, via boundary-straightening
maps with uniformly controlled Hölder norms. Up to relabelling the coordinates, each boundary
piece is flattened into the hyperplane `{y_j = 0}` with the domain mapped to its positive
side. -/
def IsDomainOfClass {d : ℕ} (n : ℕ) (δ : ℝ) (Ω : Set (EuclideanSpace ℝ (Fin d))) : Prop :=
  IsOpen Ω ∧ Bornology.IsBounded Ω ∧ Ω.Nonempty ∧
    ∃ K₀ ρ₀ : ℝ, 0 < K₀ ∧ 0 < ρ₀ ∧ ∀ x₀ ∈ frontier Ω,
      ∃ (ψ φ : EuclideanSpace ℝ (Fin d) → EuclideanSpace ℝ (Fin d))
        (D : Set (EuclideanSpace ℝ (Fin d))) (j : Fin d),
        IsOpen D ∧ Set.BijOn ψ (Metric.ball x₀ ρ₀) D ∧ ψ x₀ = 0 ∧
        (∀ x ∈ Metric.ball x₀ ρ₀, φ (ψ x) = x) ∧ (∀ y ∈ D, ψ (φ y) = y) ∧
        ψ '' (Metric.ball x₀ ρ₀ ∩ Ω) ⊆ {y | 0 < y j} ∧
        ψ '' (Metric.ball x₀ ρ₀ ∩ frontier Ω) = D ∩ {y | y j = 0} ∧
        (∀ s ≤ n, supSeminorm s (Metric.ball x₀ ρ₀) ψ ≤ ENNReal.ofReal K₀ ∧
          supSeminorm s D φ ≤ ENNReal.ofReal K₀) ∧
        holderSeminorm n δ (Metric.ball x₀ ρ₀) ψ ≤ ENNReal.ofReal K₀ ∧
        holderSeminorm n δ D φ ≤ ENNReal.ofReal K₀ ∧
        ∀ y₁ ∈ D, ∀ y₂ ∈ D, ‖φ y₁ - φ y₂‖ ≤ K₀ * ‖y₁ - y₂‖

/-- Extended supremum norm on a set. -/
noncomputable def functionSupNorm {X : Type*} (Ω : Set X) (u : X → ℝ) : ℝ≥0∞ :=
  ⨆ x : Ω, ENNReal.ofReal |u x|

/-- The shifted heat equation `Δu-u_t-u=f`. -/
def ShiftedHeatEquation {d : ℕ} (u f : (ℝ × EuclideanSpace ℝ (Fin d)) → ℝ) : Prop :=
  ∀ t x, Δ (fun y ↦ u (t, y)) x - deriv (fun s ↦ u (s, x)) t - u (t, x) =
    f (t, x)

/-- The spatial second-order operator `Σ_{ij} a^{ij}(t,x) D_i D_j + Σ_i b^i(t,x) D_i + c(t,x)`
applied to a space-time function at `p = (t, x)`. -/
noncomputable def parabolicSecondOrderOperator {d : ℕ}
    (a : (ℝ × EuclideanSpace ℝ (Fin d)) → Fin d → Fin d → ℝ)
    (b : (ℝ × EuclideanSpace ℝ (Fin d)) → Fin d → ℝ)
    (c : (ℝ × EuclideanSpace ℝ (Fin d)) → ℝ)
    (u : (ℝ × EuclideanSpace ℝ (Fin d)) → ℝ) (p : ℝ × EuclideanSpace ℝ (Fin d)) : ℝ :=
  ∑ i, ∑ j, a p i j * directionalDerivativeList [i, j] (fun y ↦ u (p.1, y)) p.2 +
    ∑ i, b p i * directionalDerivativeList [i] (fun y ↦ u (p.1, y)) p.2 + c p * u p

end KrylovHolder
end Dataset
