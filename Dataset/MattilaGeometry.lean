import Mathlib.Analysis.InnerProductSpace.Projection.Submodule
import Mathlib.MeasureTheory.Measure.Hausdorff
import Mathlib.MeasureTheory.Measure.Decomposition.Lebesgue
import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
import Mathlib.MeasureTheory.Measure.Regular
import Mathlib.MeasureTheory.Measure.Support
import Mathlib.Topology.MetricSpace.HausdorffDimension
import Mathlib.Tactic.TFAE

/-!
# Hard geometric-measure-theory statements from Mattila

Ten statement-only formalizations selected from Pertti Mattila,
*Geometry of Sets and Measures in EuclideanSpace ℝ (Fin Spaces)*.
-/

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
    ∑' i, ENNReal.ofReal (diam (U i)) ^ s

/-- The Riesz `s`-energy of a measure. -/
noncomputable def rieszEnergy {n : ℕ} (s : ℝ)
    (μ : Measure (EuclideanSpace ℝ (Fin n))) : ℝ≥0∞ :=
  ∫⁻ x, (∫⁻ y, ENNReal.ofReal (dist x y)⁻¹ ^ s ∂μ) ∂μ

/-- The Grassmannian of `m`-dimensional linear subspaces. -/
def Grassmannian (n m : ℕ) :=
  {V : Submodule ℝ (EuclideanSpace ℝ (Fin n)) // Module.finrank ℝ V = m}

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

/-- Mattila 8.19, finite-measure compact subsets approximate Hausdorff measure. -/
theorem mattila_8_19_compact_subsets_of_finite_hausdorff_measure
    {X : Type u} [MetricSpace X] [CompactSpace X] [MeasurableSpace X] [BorelSpace X]
    {s : ℝ} (hs : 0 < s) :
    μH[s] (Set.univ : Set X) =
      ⨆ C : Set X, ⨆ (_ : IsCompact C), ⨆ (_ : μH[s] C < ∞), μH[s] C := by
  sorry

/-- Mattila 12.14, Falconer's lower bounds for distance sets. -/
theorem mattila_12_14_falconer_distance_set
    {n : ℕ} {A : Set (EuclideanSpace ℝ (Fin n))} (hA : MeasurableSet A) :
    let D := {r : ℝ | ∃ x ∈ A, ∃ y ∈ A, r = dist x y}
    ((((n : ℝ≥0∞) + 1) / 2 < dimH A → 0 < volume D) ∧
      (((n : ℝ≥0∞) - 1) / 2 < dimH A ∧ dimH A < ((n : ℝ≥0∞) + 1) / 2 →
        dimH A - ((n : ℝ≥0∞) - 1) / 2 < dimH D)) := by
  sorry

/-- Mattila 6.2, upper Hausdorff-density estimates. -/
theorem mattila_6_2_hausdorff_density_estimates
    {n : ℕ} {s : ℝ} {A : Set (EuclideanSpace ℝ (Fin n))} (hA : μH[s] A < ∞) :
    (∀ᵐ x ∂μH[s], x ∈ A →
      ENNReal.ofReal (2 ^ (-s)) ≤ upperHausdorffDensity s A x ∧
        upperHausdorffDensity s A x ≤ 1) ∧
      (MeasurableSet A → ∀ᵐ x ∂μH[s], x ∉ A → upperHausdorffDensity s A x = 0) := by
  sorry

/-- Mattila 7.7, the Hausdorff bound for Lipschitz level sets. -/
theorem mattila_7_7_lipschitz_level_sets
    {n m : ℕ} :
    ∃ c : ℝ≥0∞, c < ∞ ∧ ∀ (s : ℝ) (A : Set (EuclideanSpace ℝ (Fin n)))
      (f : EuclideanSpace ℝ (Fin n) → EuclideanSpace ℝ (Fin m)) (K : NNReal),
        (m : ℝ) < s ∧ s < n → LipschitzOnWith K f A →
          (∫⁻ y, μH[s - m] (A ∩ f ⁻¹' {y}) ∂volume) ≤
            c * (K : ℝ≥0∞) ^ (m : ℝ) * μH[s] A := by
  sorry

/-- Mattila 8.8, Frostman's lemma. -/
theorem mattila_8_8_frostman_lemma
    {n : ℕ} :
    ∃ c : ℝ≥0∞, 0 < c ∧ c < ∞ ∧
      ∀ (s : ℝ) (B : Set (EuclideanSpace ℝ (Fin n))),
        0 < s → MeasurableSet B →
          (0 < μH[s] B ↔ ∃ μ : Measure (EuclideanSpace ℝ (Fin n)),
            IsFiniteMeasureOnCompacts μ ∧ Measure.InnerRegular μ ∧ μ ≠ 0 ∧
              μ Bᶜ = 0 ∧
              ∀ x : EuclideanSpace ℝ (Fin n), ∀ r : ℝ, 0 < r →
                μ (closedBall x r) < ENNReal.ofReal (r ^ s)) ∧
          ∃ μ : Measure (EuclideanSpace ℝ (Fin n)),
            IsFiniteMeasureOnCompacts μ ∧ Measure.InnerRegular μ ∧ μ ≠ 0 ∧
              μ Bᶜ = 0 ∧
              (∀ x : EuclideanSpace ℝ (Fin n), ∀ r : ℝ, 0 < r →
                μ (closedBall x r) < ENNReal.ofReal (r ^ s)) ∧
              c * hausdorffContent s B ≤ μ B := by
  sorry

/-- Mattila 9.7, the projection-energy theorem. -/
theorem mattila_9_7_projection_energy
    {n m : ℕ} [MeasurableSpace (Grassmannian n m)]
    {μ : Measure (EuclideanSpace ℝ (Fin n))} (γ : Measure (Grassmannian n m))
    (hγ : IsInvariantGrassmannianMeasure γ)
    (hμ : IsFiniteMeasureOnCompacts μ ∧ Measure.InnerRegular μ ∧ IsCompact μ.support ∧
      rieszEnergy (m : ℝ) μ < ∞) :
    (∀ᵐ V ∂γ,
      Measure.map (fun x ↦ V.1.orthogonalProjectionOnto x) μ ≪ μH[(m : ℝ)]) ∧
      ∃ (density : ∀ V : Grassmannian n m, V.1 → ℝ≥0∞) (c : ℝ≥0∞), c < ∞ ∧
        (∀ᵐ V ∂γ, Measure.map (fun x ↦ V.1.orthogonalProjectionOnto x) μ =
          μH[(m : ℝ)].withDensity (density V)) ∧
        ∫⁻ V, ∫⁻ x, density V x ^ (2 : ℝ) ∂μH[(m : ℝ)] ∂γ ≤
          c * rieszEnergy (m : ℝ) μ := by
  sorry

/-- Mattila 10.10, the plane-section theorem. -/
theorem mattila_10_10_plane_sections
    {n m : ℕ} {t : ℝ} {A : Set (EuclideanSpace ℝ (Fin n))}
    [MeasurableSpace (Grassmannian n (n - m))]
    (γ : Measure (Grassmannian n (n - m)))
    (hγ : IsInvariantGrassmannianMeasure γ)
    (hmt : (m : ℝ) < t ∧ t < n) (hA : MeasurableSet A)
    (hAfinite : μH[t] A < ∞) (hApos : 0 < μH[t] A) :
    let slice := fun (W : Grassmannian n (n - m)) (a : W.1ᗮ) ↦
      A ∩ {x | x - (a : EuclideanSpace ℝ (Fin n)) ∈ W.1}
    (∀ W : Grassmannian n (n - m),
      ∀ᵐ a ∂(μH[(m : ℝ)] : Measure W.1ᗮ),
        (μH[t - m] : Measure (EuclideanSpace ℝ (Fin n))) (slice W a) < ∞) ∧
      ∀ᵐ W : Grassmannian n (n - m) ∂γ,
        0 < μH[(m : ℝ)] {a : W.1ᗮ |
          dimH (slice W a) = ENNReal.ofReal (t - m)} := by
  sorry

/-- Mattila 14.10, Marstrand's density theorem. -/
theorem mattila_14_10_marstrand_density_integer
    {n : ℕ} {s : ℝ} {μ : Measure (EuclideanSpace ℝ (Fin n))}
    (hs : 0 < s) (hμ : IsFiniteMeasureOnCompacts μ ∧ Measure.InnerRegular μ)
    (hdensity : ∃ E : Set (EuclideanSpace ℝ (Fin n)), 0 < μ E ∧ ∀ x ∈ E,
      ∃ θ : ℝ≥0∞, 0 < θ ∧ θ < ∞ ∧
        Tendsto (fun r : ℝ ↦ μ (closedBall x r) / ENNReal.ofReal ((2 * r) ^ s))
          (𝓝[>] 0) (𝓝 θ)) :
    ∃ m : ℕ, s = m := by
  sorry

/-- Mattila 15.19, rectifiability via linear approximation and tangent planes. -/
theorem mattila_15_19_rectifiability_tangent_planes
    {n m : ℕ} {E : Set (EuclideanSpace ℝ (Fin n))}
    (hEmeas : MeasurableSet E) (hEfinite : μH[(m : ℝ)] E < ∞) :
    List.TFAE [RectifiableSet n m E, LinearlyApproximableSet n m E,
      ∀ᵐ a ∂μH[(m : ℝ)].restrict E,
        ∃! V : Grassmannian n m, IsApproximateTangentPlane (m := m) E a V,
      ∀ᵐ a ∂μH[(m : ℝ)].restrict E,
        ∃ V : Grassmannian n m, IsApproximateTangentPlane (m := m) E a V] := by
  sorry

/-- Mattila 18.1, the Besicovitch--Federer projection theorem. -/
theorem mattila_18_1_besicovitch_federer_projection
    {n m : ℕ} (hm : 0 < m) (hmn : m < n) [MeasurableSpace (Grassmannian n m)]
    (γ : Measure (Grassmannian n m)) (hγ : IsInvariantGrassmannianMeasure γ)
    {A : Set (EuclideanSpace ℝ (Fin n))} (hA : MeasurableSet A) (hAfin : μH[(m : ℝ)] A < ∞) :
    (RectifiableSet n m A ↔ ∀ B : Set (EuclideanSpace ℝ (Fin n)),
      MeasurableSet B → B ⊆ A → 0 < μH[(m : ℝ)] B →
        ∀ᵐ V ∂γ, 0 < μH[(m : ℝ)] ((fun x ↦ V.1.orthogonalProjectionOnto x) '' B)) ∧
      (PurelyUnrectifiableSet n m A ↔
        ∀ᵐ V ∂γ, μH[(m : ℝ)] ((fun x ↦ V.1.orthogonalProjectionOnto x) '' A) = 0) := by
  sorry

end MattilaGeometry
end Dataset
