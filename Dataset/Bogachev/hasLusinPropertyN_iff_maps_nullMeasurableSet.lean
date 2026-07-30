module

public import Dataset.Bogachev.Defs
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
# `hasLusinPropertyN_iff_maps_nullMeasurableSet` — 3.6.8

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `hasLusinPropertyN_iff_maps_nullMeasurableSet.md`.
Quality rubric: `hasLusinPropertyN_iff_maps_nullMeasurableSet.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory ProbabilityTheory Set Topology
open scoped BoundedContinuousFunction ENNReal MeasureTheory NNReal ProbabilityTheory Topology

namespace Dataset
namespace Bogachev

/-- **Theorem 3.6.9.**
Let `F : ℝⁿ → ℝⁿ` be Lebesgue measurable. Then
`MeasureTheory.HasLusinPropertyN F volume volume` holds if and only if `F`
sends every Lebesgue measurable set to a Lebesgue measurable set.
-/
theorem hasLusinPropertyN_iff_maps_nullMeasurableSet
    {n : ℕ} {F : (Fin n → ℝ) → (Fin n) → ℝ} (hF : NullMeasurable F volume) :
    HasLusinPropertyN F volume volume ↔
      ∀ A : Set (Fin n → ℝ),
        NullMeasurableSet A volume → NullMeasurableSet (F '' A) volume := by
  sorry

end Bogachev
end Dataset
