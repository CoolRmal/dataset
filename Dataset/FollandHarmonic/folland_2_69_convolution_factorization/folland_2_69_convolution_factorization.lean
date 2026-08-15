module

public import Dataset.FollandHarmonic.Defs


/-!
# `folland_2_69_convolution_factorization`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `folland_2_69_convolution_factorization.md`.
Quality rubric: `folland_2_69_convolution_factorization.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory Set Topology
open scoped ENNReal NNReal Topology

namespace Dataset
namespace FollandHarmonic

/-- Folland 2.69: every `𝓛ᵖ` function on a locally compact group factors as a convolution of an
`𝓛¹` function with an `𝓛ᵖ` function. -/
theorem folland_2_69_convolution_factorization {G : Type*} [Group G]
    [TopologicalSpace G] [IsTopologicalGroup G]
    [LocallyCompactSpace G] [MeasurableSpace G] [BorelSpace G]
    (μ : Measure G) [μ.IsHaarMeasure]
    (p : ℝ≥0∞) (hp : 1 ≤ p) (hp' : p ≠ ∞) (f : G → ℂ) (hf : MemLp f p μ) :
    ∃ g h : G → ℂ, Integrable g μ ∧ MemLp h p μ ∧ ∀ᵐ x ∂μ, groupConv μ g h x = f x := by
  sorry

end FollandHarmonic
end Dataset
