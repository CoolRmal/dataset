import Dataset.KallenbergProbability.Defs

/-!
# `kallenberg_4_23_moments_and_holder_continuity`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kallenberg_4_23_moments_and_holder_continuity.md`.
Quality rubric: `kallenberg_4_23_moments_and_holder_continuity.criteria.md`.
-/

open MeasureTheory Set

namespace Dataset
namespace KallenbergProbability

/-- Kallenberg 4.23, the Kolmogorov--Loeve--Chentsov continuity theorem. -/
theorem kallenberg_4_23_moments_and_holder_continuity
    {Ω S : Type*} [MeasurableSpace Ω] [MetricSpace S] [MeasurableSpace S]
    [BorelSpace S] [CompleteSpace S]
    {d : ℕ} (μ : Measure Ω) [IsProbabilityMeasure μ]
    (X : (Fin d → ℝ) → Ω → S) (hX : ∀ t, AEMeasurable (X t) μ)
    {a b : ℝ} (ha : 0 < a) (hb : 0 < b)
    (hmoment : ∃ C : ℝ, 0 ≤ C ∧ ∀ s t,
      ∫⁻ ω, ENNReal.ofReal ((dist (X s ω) (X t ω)) ^ a) ∂μ ≤
        ENNReal.ofReal (C * ‖s - t‖ ^ ((d : ℝ) + b))) :
    ∃ Y : (Fin d → ℝ) → Ω → S,
      (∀ t, X t =ᵐ[μ] Y t) ∧
        ∀ᵐ ω ∂μ, ∀ p : ℝ, ∀ hp : p ∈ Ioo 0 (b / a),
          IsLocallyHolder ⟨p, hp.1.le⟩ (fun t ↦ Y t ω) := by
  sorry

end KallenbergProbability
end Dataset
