import Dataset.FollandHarmonic.Defs

/-!
# `folland_2_69_convolution_factorization`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `folland_2_69_convolution_factorization.md`.
Quality rubric: `folland_2_69_convolution_factorization.criteria.md`.
-/

open MeasureTheory
open scoped ENNReal

namespace Dataset
namespace FollandHarmonic

/-- Folland 2.69: every `𝓛ᵖ` function on a locally compact group factors as a convolution of an
`𝓛¹` function with an `𝓛ᵖ` function. -/
theorem folland_2_69_convolution_factorization {G : Type*} [Group G]
    [TopologicalSpace G] [IsTopologicalGroup G]
    [LocallyCompactSpace G] [MeasurableSpace G] [BorelSpace G]
    (μ : Measure G) [μ.IsHaarMeasure]
    (p : ℝ≥0∞) (hp : 1 ≤ p) (hp' : p ≠ ∞) :
    -- L¹ * Lᵖ = Lᵖ : both inclusions
    (∀ f : G → ℂ, MemLp f p μ →
        ∃ g h : G → ℂ, Integrable g μ ∧ MemLp h p μ ∧ ∀ᵐ x ∂μ, groupConv μ g h x = f x) ∧
      (∀ g h : G → ℂ, Integrable g μ → MemLp h p μ → MemLp (groupConv μ g h) p μ) ∧
    -- L¹ * L^∞ = L¹ * C_lu = C_lu
    (∀ f : G → ℂ, IsLeftUniformlyContinuous f →
        ∃ g h : G → ℂ, Integrable g μ ∧ MemLp h ∞ μ ∧ ∀ x, groupConv μ g h x = f x) ∧
      (∀ g h : G → ℂ, Integrable g μ → MemLp h ∞ μ →
        IsLeftUniformlyContinuous (groupConv μ g h)) ∧
      (∀ f : G → ℂ, IsLeftUniformlyContinuous f →
        ∃ g h : G → ℂ, Integrable g μ ∧ IsLeftUniformlyContinuous h ∧
          ∀ x, groupConv μ g h x = f x) ∧
    -- L^∞ * L¹ = C_ru * L¹ = C_ru
    (∀ f : G → ℂ, IsRightUniformlyContinuous f →
        ∃ g h : G → ℂ, MemLp g ∞ μ ∧ Integrable h μ ∧ Integrable (fun y ↦ h y⁻¹) μ ∧
          ∀ x, groupConv μ g h x = f x) ∧
      (∀ g h : G → ℂ, MemLp g ∞ μ → Integrable h μ → Integrable (fun y ↦ h y⁻¹) μ →
        IsRightUniformlyContinuous (groupConv μ g h)) ∧
      (∀ f : G → ℂ, IsRightUniformlyContinuous f →
        ∃ g h : G → ℂ, IsRightUniformlyContinuous g ∧ Integrable h μ ∧
          Integrable (fun y ↦ h y⁻¹) μ ∧ ∀ x, groupConv μ g h x = f x) := by
  sorry

end FollandHarmonic
end Dataset
