import Mathlib.MeasureTheory.Function.ConvergenceInDistribution

/-!
# `kallenberg_23_2_tightness_and_relative_compactness`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kallenberg_23_2_tightness_and_relative_compactness.md`.
Quality rubric: `kallenberg_23_2_tightness_and_relative_compactness.criteria.md`.
-/

open MeasureTheory

namespace Dataset
namespace KallenbergProbability

/-- Kallenberg 23.2, Prohorov's tightness and relative-compactness theorem. -/
theorem kallenberg_23_2_tightness_and_relative_compactness
    {S : Type*} [MetricSpace S] [MeasurableSpace S] [BorelSpace S]
    (Ξ : Set (ProbabilityMeasure S)) :
    let tight := IsTightMeasureSet {((ν : ProbabilityMeasure S) : Measure S) | ν ∈ Ξ}
    let relativelyCompact := IsCompact (closure Ξ)
    (tight → relativelyCompact) ∧
      ((TopologicalSpace.SeparableSpace S ∧ CompleteSpace S) →
        (tight ↔ relativelyCompact)) := by
  sorry

end KallenbergProbability
end Dataset
