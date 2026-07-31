module

public import Mathlib.Analysis.Calculus.ContDiff.Basic
public import Mathlib.Analysis.Convex.Function
public import Mathlib.Analysis.Normed.Module.FiniteDimension
public import Mathlib.MeasureTheory.Constructions.Polish.Basic
public import Mathlib.MeasureTheory.Function.UniformIntegrable
public import Mathlib.MeasureTheory.Integral.Prod
public import Mathlib.MeasureTheory.Measure.NullMeasurable
public import Mathlib.MeasureTheory.Measure.ProbabilityMeasure
public import Mathlib.MeasureTheory.Measure.Regular
public import Mathlib.MeasureTheory.Measure.Tight
public import Mathlib.MeasureTheory.VectorMeasure.Basic
public import Mathlib.MeasureTheory.VectorMeasure.Decomposition.Jordan

/-!
# `bogachev_4_5_9_de_la_vallee_poussin` — 4.5.9

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `bogachev_4_5_9_de_la_vallee_poussin.md`.
Quality rubric: `bogachev_4_5_9_de_la_vallee_poussin.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory ProbabilityTheory Set Topology
open scoped BoundedContinuousFunction ENNReal MeasureTheory NNReal ProbabilityTheory Topology

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
    let superlinear := fun G : ℝ → ℝ ↦
      (∀ t : ℝ, 0 ≤ t → 0 ≤ G t) ∧ MonotoneOn G (Ici (0 : ℝ)) ∧
        Tendsto (fun t : ℝ ↦ G t / t) atTop atTop
    (UniformIntegrable F 1 μ ↔
      ∃ G : ℝ → ℝ, superlinear G ∧
        ∃ C : ℝ≥0, ∀ i : ι, ∫⁻ x, ENNReal.ofReal (G |F i x|) ∂μ ≤ C) ∧
      (UniformIntegrable F 1 μ →
        ∃ G : ℝ → ℝ, superlinear G ∧ ConvexOn ℝ (Ici (0 : ℝ)) G ∧
          ∃ C : ℝ≥0, ∀ i : ι, ∫⁻ x, ENNReal.ofReal (G |F i x|) ∂μ ≤ C) := by
  sorry

end Bogachev
end Dataset
