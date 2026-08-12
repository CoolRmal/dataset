module

public import Mathlib.Analysis.Normed.Algebra.Spectrum
public import Mathlib.Analysis.RCLike.Basic
public import Mathlib.MeasureTheory.Function.LpSeminorm.Basic
public import Mathlib.MeasureTheory.Integral.Bochner.Basic
public import Mathlib.MeasureTheory.Measure.Haar.Basic
public import Mathlib.MeasureTheory.Measure.Haar.InnerProductSpace
public import Mathlib.MeasureTheory.Measure.Lebesgue.EqHaar
public import Mathlib.Analysis.InnerProductSpace.PiL2
public import Mathlib.Topology.Algebra.PontryaginDual

/-!
# Shared definitions for the FollandHarmonic problems

Custom notions used by the statement files in `Dataset/FollandHarmonic/` that are
not already supplied by Mathlib. Each problem file that needs them imports
this module.
-/

@[expose] public section

open Filter MeasureTheory Set Topology
open scoped ENNReal NNReal Topology

namespace Dataset
namespace FollandHarmonic

section Group

variable {G : Type*} [Group G] [TopologicalSpace G] [MeasurableSpace G]

/-- Folland's left translation `L_y f (x) = f (y⁻¹ x)`. -/
def leftTranslate (y : G) (f : G → ℂ) : G → ℂ := fun x ↦ f (y⁻¹ * x)

/-- Folland's right translation `R_y f (x) = f (x y)`. -/
def rightTranslate (y : G) (f : G → ℂ) : G → ℂ := fun x ↦ f (x * y)

/-- Convolution on a locally compact group: `(f * g)(x) = ∫ f y · g (y⁻¹ x) dμ y`. -/
noncomputable def groupConv (μ : Measure G) (f g : G → ℂ) : G → ℂ :=
  fun x ↦ ∫ y, f y * g (y⁻¹ * x) ∂μ

/-- The `𝓛_p(μ)` distance used to say that a family of functions is closed in `𝓛_p`. -/
def IsLpClosed (p : ℝ≥0∞) (μ : Measure G) (I : Set (G → ℂ)) : Prop :=
  ∀ f : G → ℂ, MemLp f p μ →
    (∀ ε : ℝ≥0∞, 0 < ε → ∃ g ∈ I, MemLp g p μ ∧ eLpNorm (f - g) p μ < ε) → f ∈ I

/-- `f` is uniformly almost periodic: its right translates are totally bounded for the uniform
norm, i.e. finitely many of them approximate all the others uniformly on `G`. -/
def IsUniformlyAlmostPeriodic (f : G → ℂ) : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ s : Finset G, ∀ y : G, ∃ z ∈ s, ∀ x : G,
    ‖rightTranslate y f x - rightTranslate z f x‖ < ε

end Group

section Abelian

variable {G : Type*} [CommGroup G] [TopologicalSpace G] [MeasurableSpace G]

/-- The Fourier transform on a locally compact abelian group,
`f̂ ξ = ∫ f x · conj (ξ x) dμ x`, with characters valued in the unit circle. -/
noncomputable def dualFourier (μ : Measure G) (f : G → ℂ) (ξ : PontryaginDual G) : ℂ :=
  ∫ x, f x * (starRingEnd ℂ) ((ξ x : ℂ)) ∂μ

/-- The annihilator `H⊥ = {ξ : ξ|_H ≡ 1}` of a subgroup, as a subgroup of the dual. -/
def annihilator (G : Type*) [CommGroup G] [TopologicalSpace G] (H : Subgroup G) :
    Subgroup (PontryaginDual G) where
  carrier := {ξ | ∀ y ∈ H, ξ y = 1}
  one_mem' _ _ := rfl
  mul_mem' := fun {a b} hξ hη y hy => by
    rw [show (a * b) y = a y * b y from ContinuousMonoidHom.mul_apply a b y, hξ y hy, hη y hy,
      one_mul]
  inv_mem' := fun {a} hξ y hy => by
    rw [show a⁻¹ y = (a y)⁻¹ from rfl, hξ y hy, inv_one]

/-- The cospectrum (hull) `ν(I) = {ξ : f̂ ξ = 0 for all f ∈ I}` of a family of functions. -/
noncomputable def hull (μ : Measure G) (I : Set (G → ℂ)) : Set (PontryaginDual G) :=
  {ξ | ∀ f ∈ I, dualFourier μ f ξ = 0}

/-- The kernel `ι(E) = {f : f̂ vanishes on E}` of a set of characters. -/
noncomputable def kernel (μ : Measure G) (E : Set (PontryaginDual G)) : Set (G → ℂ) :=
  {f | Integrable f μ ∧ ∀ ξ ∈ E, dualFourier μ f ξ = 0}

end Abelian

end FollandHarmonic
end Dataset
