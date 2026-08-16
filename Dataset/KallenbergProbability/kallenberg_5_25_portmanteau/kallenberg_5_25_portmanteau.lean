import Mathlib.MeasureTheory.Function.ConvergenceInDistribution

/-!
# `kallenberg_5_25_portmanteau`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kallenberg_5_25_portmanteau.md`.
Quality rubric: `kallenberg_5_25_portmanteau.criteria.md`.
-/

open Filter MeasureTheory
open scoped Topology

namespace Dataset
namespace KallenbergProbability

/-- Kallenberg 5.25, the portmanteau theorem. -/
theorem kallenberg_5_25_portmanteau
    {Ω Ω' S : Type*} [MeasurableSpace Ω] [MeasurableSpace Ω']
    [MetricSpace S] [MeasurableSpace S] [BorelSpace S]
    (μ : Measure Ω) (μ' : Measure Ω') [IsProbabilityMeasure μ]
    [IsProbabilityMeasure μ'] (ξn : ℕ → Ω → S) (ξ : Ω' → S)
    (hξn : ∀ n, AEMeasurable (ξn n) μ) (hξ : AEMeasurable ξ μ') :
    let lawsConverge := TendstoInDistribution ξn atTop ξ (fun _ ↦ μ) μ'
    let openLowerBound := ∀ G : Set S, IsOpen G →
      μ' (ξ ⁻¹' G) ≤ liminf (fun n ↦ μ (ξn n ⁻¹' G)) atTop
    let closedUpperBound := ∀ F : Set S, IsClosed F →
      limsup (fun n ↦ μ (ξn n ⁻¹' F)) atTop ≤ μ' (ξ ⁻¹' F)
    let continuitySets := ∀ B : Set S, MeasurableSet B → μ' (ξ ⁻¹' frontier B) = 0 →
      Tendsto (fun n ↦ μ (ξn n ⁻¹' B)) atTop (𝓝 (μ' (ξ ⁻¹' B)))
    List.TFAE [lawsConverge, openLowerBound, closedUpperBound, continuitySets] := by
  sorry

end KallenbergProbability
end Dataset
