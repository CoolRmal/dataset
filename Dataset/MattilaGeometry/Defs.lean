module

public import Mathlib.Analysis.InnerProductSpace.Projection.Submodule
public import Mathlib.MeasureTheory.Measure.Hausdorff
public import Mathlib.MeasureTheory.Measure.Decomposition.Lebesgue
public import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
public import Mathlib.MeasureTheory.Measure.Regular
public import Mathlib.MeasureTheory.Measure.Support
public import Mathlib.Topology.MetricSpace.HausdorffDimension
public import Mathlib.Tactic.TFAE

/-!
# Shared definitions for the MattilaGeometry problems

Custom notions used by the statement files in `Dataset/MattilaGeometry/` that are
not already supplied by Mathlib. Each problem file that needs them imports
this module.
-/

@[expose] public section

open Filter Function MeasureTheory Metric Set Topology
open scoped ENNReal MeasureTheory NNReal Topology

namespace Dataset
namespace MattilaGeometry

universe u

/-- Upper `s`-density of a set with respect to Hausdorff measure. -/
noncomputable def upperHausdorffDensity {n : ℕ} (s : ℝ)
    (A : Set (EuclideanSpace ℝ (Fin n))) (x : EuclideanSpace ℝ (Fin n)) : ℝ≥0∞ :=
  limsup (fun r : ℝ ↦ μH[s] (A ∩ closedBall x r) /
    ENNReal.ofReal ((2 * r) ^ s)) (𝓝[>] 0)

/-- The `s`-dimensional Hausdorff content, with no diameter restriction on covers. -/
noncomputable def hausdorffContent {X : Type u} [PseudoMetricSpace X]
    (s : ℝ) (A : Set X) : ℝ≥0∞ :=
  ⨅ U : ℕ → Set X, ⨅ (_ : A ⊆ ⋃ i, U i),
    ∑' i, Metric.ediam (U i) ^ s

/-- The Riesz `s`-energy of a measure. -/
noncomputable def rieszEnergy {n : ℕ} (s : ℝ)
    (μ : Measure (EuclideanSpace ℝ (Fin n))) : ℝ≥0∞ :=
  ∫⁻ x, (∫⁻ y, (ENNReal.ofReal (dist x y))⁻¹ ^ s ∂μ) ∂μ

/-- The upper integral of a nonnegative function, defined through measurable majorants. -/
noncomputable def upperIntegral {X : Type u} [MeasurableSpace X]
    (μ : Measure X) (f : X → ℝ≥0∞) : ℝ≥0∞ :=
  ⨅ g : X → ℝ≥0∞, ⨅ (_ : Measurable g), ⨅ (_ : f ≤ g), ∫⁻ x, g x ∂μ

/-- The Grassmannian of `m`-dimensional linear subspaces. -/
def Grassmannian (n m : ℕ) :=
  {V : Submodule ℝ (EuclideanSpace ℝ (Fin n)) // Module.finrank ℝ V = m}

/-- The canonical Grassmannian topology, induced by orthogonal projection operators. -/
noncomputable instance grassmannianTopologicalSpace (n m : ℕ) :
    TopologicalSpace (Grassmannian n m) :=
  TopologicalSpace.induced (fun V : Grassmannian n m ↦ V.1.starProjection) inferInstance

/-- The Borel measurable space of the canonical Grassmannian topology. -/
noncomputable instance grassmannianMeasurableSpace (n m : ℕ) :
    MeasurableSpace (Grassmannian n m) := borel (Grassmannian n m)

instance grassmannianBorelSpace (n m : ℕ) : BorelSpace (Grassmannian n m) := ⟨rfl⟩

/-- The natural action of a linear automorphism on a Grassmannian. -/
def grassmannianAction {n m : ℕ}
    (Q : EuclideanSpace ℝ (Fin n) ≃ₗ[ℝ] EuclideanSpace ℝ (Fin n))
    (V : Grassmannian n m) : Grassmannian n m :=
  ⟨V.1.map Q.toLinearMap, (Q.finrank_map_eq V.1).trans V.2⟩

/-- The invariant probability measure on the Grassmannian used by Mattila. -/
def IsInvariantGrassmannianMeasure {n m : ℕ} [MeasurableSpace (Grassmannian n m)]
    (γ : Measure (Grassmannian n m)) : Prop :=
  IsProbabilityMeasure γ ∧
    ∀ Q : EuclideanSpace ℝ (Fin n) ≃ₗ[ℝ] EuclideanSpace ℝ (Fin n),
      (∀ x, ‖Q x‖ = ‖x‖) → AEMeasurable (grassmannianAction (m := m) Q) γ ∧
        Measure.map (grassmannianAction (m := m) Q) γ = γ

/-- Countable rectifiability up to an `m`-dimensional Hausdorff-null set. -/
def RectifiableSet (n m : ℕ) (E : Set (EuclideanSpace ℝ (Fin n))) : Prop :=
  ∃ f : ℕ → EuclideanSpace ℝ (Fin m) → EuclideanSpace ℝ (Fin n),
    (∀ j, ∃ K : NNReal, LipschitzWith K (f j)) ∧
      μH[(m : ℝ)] (E \ ⋃ j, range (f j)) = 0

/-- Mattila's linear approximation conditions (15.8) and (15.9). -/
def LinearlyApproximableSet (n m : ℕ) (E : Set (EuclideanSpace ℝ (Fin n))) : Prop :=
  ∀ᵐ a ∂μH[(m : ℝ)].restrict E, ∀ η : ℝ, 0 < η →
    ∃ V : Grassmannian n m, ∃ r₀ c : ℝ, 0 < r₀ ∧ 0 < c ∧
      ∀ r : ℝ, 0 < r → r < r₀ →
        (∀ x, x - a ∈ V.1 → x ∈ closedBall a r →
          ENNReal.ofReal (c * r ^ m) ≤ μH[(m : ℝ)] (E ∩ closedBall x (η * r))) ∧
        μH[(m : ℝ)] (E ∩ closedBall a r ∩
          {x | η * r ≤ infDist (x - a) (V.1 : Set (EuclideanSpace ℝ (Fin n)))}) <
            ENNReal.ofReal (η * r ^ m)

/-- An approximate tangent plane, formulated by vanishing conical complement density. -/
def IsApproximateTangentPlane {n m : ℕ} (E : Set (EuclideanSpace ℝ (Fin n)))
    (a : EuclideanSpace ℝ (Fin n)) (V : Grassmannian n m) : Prop :=
  0 < upperHausdorffDensity (m : ℝ) E a ∧
    ∀ s : ℝ, 0 < s → s < 1 →
      Tendsto (fun r : ℝ ↦
        μH[(m : ℝ)] (E ∩ closedBall a r ∩
          {x | s * dist x a ≤ infDist (x - a)
            (V.1 : Set (EuclideanSpace ℝ (Fin n)))}) /
            ENNReal.ofReal (r ^ (m : ℝ))) (𝓝[>] 0) (𝓝 0)

/-- A set meeting every `m`-rectifiable set in an `m`-dimensional null set. -/
def PurelyUnrectifiableSet (n m : ℕ) (A : Set (EuclideanSpace ℝ (Fin n))) : Prop :=
  ∀ E : Set (EuclideanSpace ℝ (Fin n)), RectifiableSet n m E →
    μH[(m : ℝ)] (A ∩ E) = 0

end MattilaGeometry
end Dataset
