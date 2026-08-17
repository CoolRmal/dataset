import Dataset.FollandHarmonic.Defs

/-!
# `folland_2_44_approximate_identity`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `folland_2_44_approximate_identity.md`.
Quality rubric: `folland_2_44_approximate_identity.criteria.md`.
-/

open Filter MeasureTheory
open scoped ENNReal Topology

namespace Dataset
namespace FollandHarmonic

/-- Folland 2.44. Let `𝓤` be a neighbourhood base at `1` and let `ψ U` be, for each `U ∈ 𝓤`, a
nonnegative compactly supported function of unit mass with support inside `U`. Then
`‖ψ U ⋆ f - f‖_p → 0` as `U → {1}`, for `1 ≤ p < ∞` and `f ∈ L^p`, or for `p = ∞` and `f` left
uniformly continuous; and, once each `ψ U` is symmetric, likewise for `f ⋆ ψ U`, with right
uniform continuity in the `p = ∞` case. -/
theorem folland_2_44_approximate_identity {G : Type*} [Group G]
    [TopologicalSpace G] [IsTopologicalGroup G]
    [LocallyCompactSpace G] [MeasurableSpace G] [BorelSpace G]
    (μ : Measure G) [μ.IsHaarMeasure]
    (𝓤 : Set (Set G)) (hbase : (𝓝 (1 : G)).HasBasis (· ∈ 𝓤) id)
    (ψ : Set G → G → ℝ)
    (hsupp : ∀ U ∈ 𝓤, HasCompactSupport (ψ U) ∧ tsupport (ψ U) ⊆ U)
    (hnonneg : ∀ U ∈ 𝓤, ∀ x, 0 ≤ ψ U x)
    (hmass : ∀ U ∈ 𝓤, Integrable (ψ U) μ ∧ ∫ x, ψ U x ∂μ = 1)
    (p : ℝ≥0∞) (hp : 1 ≤ p) (f : G → ℂ) :
    letI F := (𝓝 (1 : G)).smallSets ⊓ Filter.principal 𝓤
    letI left := fun U ↦ eLpNorm (groupConv μ (fun x ↦ (ψ U x : ℂ)) f - f) p μ
    letI right := fun U ↦ eLpNorm (groupConv μ f (fun x ↦ (ψ U x : ℂ)) - f) p μ
    ((p ≠ ∞ → MemLp f p μ → Tendsto left F (𝓝 0)) ∧
        (p = ∞ → IsLeftUniformlyContinuous f → Tendsto left F (𝓝 0))) ∧
      ((∀ U ∈ 𝓤, ∀ x, ψ U x⁻¹ = ψ U x) →
        ((p ≠ ∞ → MemLp f p μ → Tendsto right F (𝓝 0)) ∧
          (p = ∞ → IsRightUniformlyContinuous f → Tendsto right F (𝓝 0)))) := by
  sorry

end FollandHarmonic
end Dataset
