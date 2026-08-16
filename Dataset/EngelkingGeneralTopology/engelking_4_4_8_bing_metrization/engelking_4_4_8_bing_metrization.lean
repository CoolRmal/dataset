import Dataset.EngelkingGeneralTopology.Defs

/-!
# `engelking_4_4_8_bing_metrization` — 4.4.8

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `engelking_4_4_8_bing_metrization.md`.
Quality rubric: `engelking_4_4_8_bing_metrization.criteria.md`.
-/

open TopologicalSpace

namespace Dataset
namespace EngelkingGeneralTopology

universe u v w

/-- Engelking 4.4.8, the Bing metrization theorem. -/
theorem engelking_4_4_8_bing_metrization
    {X : Type u} [TopologicalSpace X] [T1Space X] :
    MetrizableSpace X ↔ RegularSpace X ∧ HasSigmaDiscreteBase X := by
  sorry

end EngelkingGeneralTopology
end Dataset
