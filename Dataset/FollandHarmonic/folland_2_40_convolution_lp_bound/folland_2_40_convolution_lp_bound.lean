import Dataset.FollandHarmonic.Defs
import Mathlib.MeasureTheory.Group.ModularCharacter

/-!
# `folland_2_40_convolution_lp_bound`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `folland_2_40_convolution_lp_bound.md`.
Quality rubric: `folland_2_40_convolution_lp_bound.criteria.md`.
-/

open Filter MeasureTheory Set Topology
open scoped ENNReal NNReal Topology

namespace Dataset
namespace FollandHarmonic

/-- Folland 2.40: convolution with an `𝓛¹` function is bounded on `𝓛ᵖ`; the two-sided bound needs
unimodularity, and without it the right convolution still lands in `𝓛ᵖ` for compactly supported
`𝓛¹` functions. -/
theorem folland_2_40_convolution_lp_bound {G : Type*} [Group G]
    [TopologicalSpace G] [IsTopologicalGroup G]
    [LocallyCompactSpace G] [MeasurableSpace G] [BorelSpace G]
    (μ : Measure G) [μ.IsHaarMeasure]
    (p : ℝ≥0∞) (hp : 1 ≤ p) (f g : G → ℂ) (hf : Integrable f μ) (hg : MemLp g p μ) :
    ((∀ᵐ x ∂μ, Integrable (fun y ↦ f y * g (y⁻¹ * x)) μ) ∧ MemLp (groupConv μ f g) p μ ∧
        eLpNorm (groupConv μ f g) p μ ≤ eLpNorm f 1 μ * eLpNorm g p μ) ∧
      ((∀ y : G, Measure.modularCharacterFun y = 1) →
        MemLp (groupConv μ g f) p μ ∧
          eLpNorm (groupConv μ g f) p μ ≤ eLpNorm f 1 μ * eLpNorm g p μ) ∧
      (HasCompactSupport f → MemLp (groupConv μ g f) p μ) := by
  sorry

end FollandHarmonic
end Dataset
