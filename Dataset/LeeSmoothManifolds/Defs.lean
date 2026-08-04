module

public import Mathlib.Geometry.Manifold.Algebra.LieGroup
public import Mathlib.Geometry.Manifold.ContMDiffMFDeriv
public import Mathlib.Geometry.Manifold.Immersion
public import Mathlib.Geometry.Manifold.SmoothApprox
public import Mathlib.Geometry.Manifold.Submersion
public import Mathlib.Geometry.Manifold.WhitneyEmbedding
public import Mathlib.MeasureTheory.Measure.Haar.NormedSpace

/-!
# Shared definitions for the LeeSmoothManifolds problems

Custom notions used by the statement files in `Dataset/LeeSmoothManifolds/` that are
not already supplied by Mathlib. Each problem file that needs them imports
this module.
-/

@[expose] public section

open Function MeasureTheory Set Topology
open scoped ContDiff Manifold Topology

namespace Dataset
namespace LeeSmoothManifolds

universe u v

/-- A smooth diffeomorphism between two Euclidean subsets. -/
structure SmoothDiffeomorphismOn {m n : ℕ} (U : Set ((Fin m → ℝ)))
    (V : Set ((Fin n → ℝ))) where
  toFun : (Fin m → ℝ) → (Fin n → ℝ)
  invFun : (Fin n → ℝ) → (Fin m → ℝ)
  mapsTo : MapsTo toFun U V
  invMapsTo : MapsTo invFun V U
  leftInvOn : Set.LeftInvOn invFun toFun U
  rightInvOn : Set.RightInvOn invFun toFun V
  smooth : ContDiffOn ℝ ∞ toFun U
  smooth_inv : ContDiffOn ℝ ∞ invFun V

/-- The rank of the Frechet derivative is constantly `k` on `U`. -/
def EuclideanConstantRank {m n : ℕ} (U : Set ((Fin m → ℝ)))
    (F : (Fin m → ℝ) → (Fin n → ℝ)) (k : ℕ) : Prop :=
  ∀ x ∈ U, Module.finrank ℝ (LinearMap.range (fderiv ℝ F x).toLinearMap) = k

/-- Constant rank of the manifold derivative. -/
def ConstantRank {m n : ℕ} {M : Type u} {N : Type v}
    [TopologicalSpace M] [ChartedSpace ((Fin m → ℝ)) M]
    [TopologicalSpace N] [ChartedSpace ((Fin n → ℝ)) N]
    (F : M → N) (k : ℕ) : Prop :=
  ∀ p : M,
    Module.finrank ℝ
      (LinearMap.range
        (mfderiv 𝓘(ℝ, (Fin m → ℝ)) 𝓘(ℝ, (Fin n → ℝ)) F p).toLinearMap) = k

/-- An embedded submanifold in local slice coordinates. -/
def EmbeddedSubmanifoldOfCodimension {m : ℕ} {M : Type u}
    [TopologicalSpace M] [ChartedSpace ((Fin m → ℝ)) M]
    (S : Set M) (codim : ℕ) : Prop :=
  ∀ p ∈ S,
    ∃ φ : OpenPartialHomeomorph M ((Fin m → ℝ)),
      φ ∈ IsManifold.maximalAtlas 𝓘(ℝ, (Fin m → ℝ)) ∞ M ∧ p ∈ φ.source ∧
      φ '' (S ∩ φ.source) =
        {x ∈ φ.target | ∀ i : Fin m, m - codim ≤ i.1 → x i = 0}

/-- A regular value: the map is a submersion at every point of its fiber. -/
def RegularValue {m n : ℕ} {M : Type u} {N : Type v}
    [TopologicalSpace M] [ChartedSpace ((Fin m → ℝ)) M]
    [TopologicalSpace N] [ChartedSpace ((Fin n → ℝ)) N]
    (F : M → N) (c : N) : Prop :=
  ∀ p, F p = c →
    Manifold.IsSubmersionAt 𝓘(ℝ, (Fin m → ℝ)) 𝓘(ℝ, (Fin n → ℝ)) ∞ F p

/-- A smooth free proper action, including the group-action laws. -/
def SmoothFreeProperAction {g m : ℕ} {G : Type u} {M : Type v}
    [Group G] [TopologicalSpace G] [ChartedSpace ((Fin g → ℝ)) G]
    [TopologicalSpace M] [ChartedSpace ((Fin m → ℝ)) M]
    (act : G → M → M) : Prop :=
  (∀ x, act 1 x = x) ∧ (∀ a b x, act (a * b) x = act a (act b x)) ∧
    ContMDiff (𝓘(ℝ, (Fin g → ℝ)).prod 𝓘(ℝ, (Fin m → ℝ)))
      𝓘(ℝ, (Fin m → ℝ)) ∞ (fun p : G × M ↦ act p.1 p.2) ∧
    (∀ a x, act a x = x → a = 1) ∧
    IsProperMap fun p : G × M ↦ (act p.1 p.2, p.2)

/-- A vector normal to every velocity of a curve in the submanifold. -/
def IsNormalVector {n : ℕ} (M : Set ((Fin n → ℝ)))
    (x v : (Fin n → ℝ)) : Prop :=
  x ∈ M ∧ ∀ γ : ℝ → (Fin n → ℝ), ∀ velocity : (Fin n → ℝ),
    γ 0 = x → (∀ᶠ t in 𝓝 0, γ t ∈ M) → HasDerivAt γ velocity 0 →
      ∑ i, v i * velocity i = 0

/-- The variable-radius normal disk bundle of an embedded (Fin submanifold → ℝ). -/
def NormalDiskBundle {n : ℕ} (M : Set ((Fin n → ℝ)))
    (radius : M → ℝ) : Set (M × (Fin n → ℝ)) :=
  {p | IsNormalVector M p.1 p.2 ∧ ‖p.2‖ < radius p.1}

end LeeSmoothManifolds
end Dataset
