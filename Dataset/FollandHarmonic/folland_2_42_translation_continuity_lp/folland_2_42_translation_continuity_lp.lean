import Dataset.FollandHarmonic.Defs

/-!
# `folland_2_42_translation_continuity_lp`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `folland_2_42_translation_continuity_lp.md`.
Quality rubric: `folland_2_42_translation_continuity_lp.criteria.md`.
-/

open Filter MeasureTheory
open scoped ENNReal Topology

namespace Dataset
namespace FollandHarmonic

/-- Folland 2.42: translation is continuous at the identity in the `𝓛ᵖ` norm for `p < ∞`. -/
theorem folland_2_42_translation_continuity_lp {G : Type*} [Group G]
    [TopologicalSpace G] [IsTopologicalGroup G]
    [LocallyCompactSpace G] [MeasurableSpace G] [BorelSpace G]
    (μ : Measure G) [μ.IsHaarMeasure]
    (p : ℝ≥0∞) (hp : 1 ≤ p) (hp' : p ≠ ∞) (f : G → ℂ) (hf : MemLp f p μ) :
    Tendsto (fun y ↦ eLpNorm (leftTranslate y f - f) p μ) (𝓝 1) (𝓝 0) ∧
      Tendsto (fun y ↦ eLpNorm (rightTranslate y f - f) p μ) (𝓝 1) (𝓝 0) := by
  sorry

end FollandHarmonic
end Dataset
