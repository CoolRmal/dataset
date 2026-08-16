import Mathlib.MeasureTheory.Function.UniformIntegrable
import Mathlib.MeasureTheory.Integral.Prod

/-!
# `bogachev_4_5_9_de_la_vallee_poussin` — 4.5.9

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `bogachev_4_5_9_de_la_vallee_poussin.md`.
Quality rubric: `bogachev_4_5_9_de_la_vallee_poussin.criteria.md`.
-/

open Filter MeasureTheory Set
open scoped ENNReal

namespace Dataset
namespace Bogachev

/--
Bogachev, *Measure Theory*, Volume I, Theorem 4.5.9:
"Let `μ` be a finite nonnegative measure. A family `F` of `μ`-integrable
functions is uniformly integrable iff there exists a nonnegative increasing
function `G` on `[0,∞)` such that `G(t)/t → ∞` and
`sup_{f∈F} ∫ G(|f|) dμ < ∞`. In such a case `G` can be chosen convex."
-/
theorem bogachev_4_5_9_de_la_vallee_poussin
    {Ω ι : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsFiniteMeasure μ]
    {F : ι → Ω → ℝ} (hF : ∀ i : ι, Integrable (F i) μ) :
    (UniformIntegrable F 1 μ ↔
      ∃ G : ℝ → ℝ, (∀ t ≥ 0, 0 ≤ G t) ∧ MonotoneOn G (Ici 0) ∧
        Tendsto (fun t ↦ G t / t) atTop atTop ∧
        ⨆ i : ι, ∫⁻ x, ENNReal.ofReal (G |F i x|) ∂μ < ∞) ∧
      (UniformIntegrable F 1 μ →
        ∃ G : ℝ → ℝ, (∀ t ≥ 0, 0 ≤ G t) ∧ MonotoneOn G (Ici 0) ∧
        Tendsto (fun t ↦ G t / t) atTop atTop ∧ ConvexOn ℝ (Ici 0) G ∧
          ⨆ i : ι, ∫⁻ x, ENNReal.ofReal (G |F i x|) ∂μ < ∞) := by
  sorry

end Bogachev
end Dataset
