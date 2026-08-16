import Mathlib.MeasureTheory.Function.LpSeminorm.Basic
import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.MeasureTheory.Measure.Haar.Basic

/-!
# Shared definitions for the FollandHarmonic problems

Custom notions used by the statement files in `Dataset/FollandHarmonic/` that are
not already supplied by Mathlib. The modular function is Mathlib's
`MeasureTheory.Measure.modularCharacterFun` and the dual group is
`PontryaginDual`; what is added here is Folland's translation operators, the
convolution of two functions on a locally compact group, closedness of a family
of functions in `𝓛ᵖ`, and uniform almost periodicity.
-/

open Filter MeasureTheory Set Topology
open scoped ENNReal NNReal Topology

namespace Dataset
namespace FollandHarmonic

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

/-- `C_lu(G)`: the bounded, **left** uniformly continuous functions —
`‖L_y f - f‖_∞ → 0` as `y → 1`. -/
def IsLeftUniformlyContinuous (f : G → ℂ) : Prop :=
  (∃ C : ℝ, ∀ x, ‖f x‖ ≤ C) ∧
    ∀ ε : ℝ, 0 < ε → ∃ U ∈ nhds (1 : G), ∀ y ∈ U, ∀ x, ‖leftTranslate y f x - f x‖ < ε

/-- `C_ru(G)`: the bounded, **right** uniformly continuous functions —
`‖R_y f - f‖_∞ → 0` as `y → 1`. -/
def IsRightUniformlyContinuous (f : G → ℂ) : Prop :=
  (∃ C : ℝ, ∀ x, ‖f x‖ ≤ C) ∧
    ∀ ε : ℝ, 0 < ε → ∃ U ∈ nhds (1 : G), ∀ y ∈ U, ∀ x, ‖rightTranslate y f x - f x‖ < ε

/-- `f` is uniformly almost periodic: its right translates are totally bounded for the uniform
norm, i.e. finitely many of them approximate all the others uniformly on `G`. -/
def IsUniformlyAlmostPeriodic (f : G → ℂ) : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ s : Finset G, ∀ y : G, ∃ z ∈ s, ∀ x : G,
    ‖rightTranslate y f x - rightTranslate z f x‖ < ε

end FollandHarmonic
end Dataset
