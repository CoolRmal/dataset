import Dataset.Bogachev.Defs

/-!
# `bogachev_9_12_37_simultaneous_transport` — 9.12.37

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `bogachev_9_12_37_simultaneous_transport.md`.
Quality rubric: `bogachev_9_12_37_simultaneous_transport.criteria.md`.
-/

open MeasureTheory

namespace Dataset
namespace Bogachev

/-- Bogachev 9.12.37, simultaneous transport of finitely many atomless measures. -/
theorem bogachev_9_12_37_simultaneous_transport
    {X : Type*} [MeasurableSpace X] [TopologicalSpace X] [T2Space X] [SouslinSpace X]
    [BorelSpace X] {n : ℕ} (μ : Fin n → Measure X) [∀ i, IsProbabilityMeasure (μ i)]
    (ν : Measure X) [IsProbabilityMeasure ν]
    (hμ : ∀ i, is_atomless_measure (μ i)) :
    ∃ T : X → X, ∀ i, MeasurePreserving T (μ i) ν := by
  sorry

end Bogachev
end Dataset
