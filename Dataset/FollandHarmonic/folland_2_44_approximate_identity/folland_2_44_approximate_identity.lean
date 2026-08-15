module

public import Dataset.FollandHarmonic.Defs


/-!
# `folland_2_44_approximate_identity`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `folland_2_44_approximate_identity.md`.
Quality rubric: `folland_2_44_approximate_identity.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory Set Topology
open scoped ENNReal NNReal Topology

namespace Dataset
namespace FollandHarmonic

/-- Folland 2.44: convolution against a nonnegative compactly supported bump of unit mass and
shrinking support converges to the identity on `𝓛ᵖ`, on the right as well once the bump is
symmetric. -/
theorem folland_2_44_approximate_identity {G : Type*} [Group G]
    [TopologicalSpace G] [IsTopologicalGroup G]
    [LocallyCompactSpace G] [MeasurableSpace G] [BorelSpace G]
    (μ : Measure G) [μ.IsHaarMeasure]
    (p : ℝ≥0∞) (hp : 1 ≤ p) (hp' : p ≠ ∞) (f : G → ℂ) (hf : MemLp f p μ)
    (ε : ℝ≥0∞) (hε : 0 < ε) :
    ∃ U ∈ 𝓝 (1 : G), ∀ ψ : G → ℝ, HasCompactSupport ψ → tsupport ψ ⊆ U → (∀ x, 0 ≤ ψ x) →
      Integrable ψ μ → ∫ x, ψ x ∂μ = 1 →
      eLpNorm (groupConv μ (fun x ↦ (ψ x : ℂ)) f - f) p μ < ε ∧
        ((∀ x, ψ x⁻¹ = ψ x) → eLpNorm (groupConv μ f (fun x ↦ (ψ x : ℂ)) - f) p μ < ε) := by
  sorry

end FollandHarmonic
end Dataset
