import Mathlib.Analysis.InnerProductSpace.Adjoint
import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.MeasureTheory.Group.ModularCharacter
import Mathlib.Topology.Algebra.PontryaginDual

/-!
# Shared definitions for the FollandHarmonic problems

Custom notions used by the statement files in `Dataset/FollandHarmonic/` that are
not already supplied by Mathlib. The modular function is Mathlib's
`MeasureTheory.Measure.modularCharacterFun` and the dual group is
`PontryaginDual`; what is added here is Folland's translation operators, the
convolution of two functions on a locally compact group, closedness of a family
of functions in `𝓛ᵖ`, and uniform almost periodicity.
-/

open MeasureTheory
open scoped ENNReal

namespace Dataset
namespace FollandHarmonic

variable {G : Type*} [Group G] [TopologicalSpace G] [MeasurableSpace G]

/-- `G` is **unimodular**: its modular function is identically `1`, i.e. a left Haar measure is
also right invariant. -/
def IsUnimodular (G : Type*) [TopologicalSpace G] [Group G] [IsTopologicalGroup G]
    [LocallyCompactSpace G] : Prop :=
  ∀ y : G, Measure.modularCharacterFun y = 1

/-- Folland's **strong equivalence** of two Radon measures (Proposition 2.23): there is a
*continuous, strictly positive* density `f` with `∫ φ dν = ∫ φ f dμ` for every compactly
supported continuous `φ`. This is stronger than mutual absolute continuity. -/
def StronglyEquivalent {X : Type*} [TopologicalSpace X] [MeasurableSpace X]
    (μ ν : Measure X) : Prop :=
  ∃ f : X → ℝ, Continuous f ∧ (∀ x, 0 < f x) ∧
    ∀ φ : X → ℝ, Continuous φ → HasCompactSupport φ →
      ∫ x, φ x ∂ν = ∫ x, φ x * f x ∂μ

/-- Folland's left translation `L_y f (x) = f (y⁻¹ x)`. -/
def leftTranslate (y : G) (f : G → ℂ) : G → ℂ := fun x ↦ f (y⁻¹ * x)

/-- Folland's right translation `R_y f (x) = f (x y)`. -/
def rightTranslate (y : G) (f : G → ℂ) : G → ℂ := fun x ↦ f (x * y)

/-- Convolution on a locally compact group: `(f * g)(x) = ∫ f y · g (y⁻¹ x) dμ y`. -/
noncomputable def groupConv (μ : Measure G) (f g : G → ℂ) : G → ℂ :=
  fun x ↦ ∫ y, f y * g (y⁻¹ * x) ∂μ

/-- A unitary representation of a topological group `G` on a complex Hilbert space `H`:
a homomorphism into the unitary operators that is continuous in the strong topology. -/
structure UnitaryRepresentation (G H : Type*) [Group G] [TopologicalSpace G]
    [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H] where
  toFun : G → H →L[ℂ] H
  map_one : toFun 1 = ContinuousLinearMap.id ℂ H
  map_mul : ∀ x y, toFun (x * y) = (toFun x).comp (toFun y)
  mem_unitary : ∀ x, toFun x ∈ unitary (H →L[ℂ] H)
  strongly_continuous : ∀ v : H, Continuous fun x ↦ toFun x v

/-- A unitary representation is **irreducible** when the only closed invariant subspaces are the
trivial ones. -/
def UnitaryRepresentation.Irreducible {G H : Type*} [Group G] [TopologicalSpace G]
    [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
    (π : UnitaryRepresentation G H) : Prop :=
  ∀ K : Submodule ℂ H, IsClosed (K : Set H) →
    (∀ x : G, ∀ v ∈ K, π.toFun x v ∈ K) → K = ⊥ ∨ K = ⊤

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

end FollandHarmonic
end Dataset
