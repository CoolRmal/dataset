import Dataset.EngelkingGeneralTopology.Defs

/-!
# `engelking_8_4_13_smirnov_proximity_compactification` — 8.4.13

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `engelking_8_4_13_smirnov_proximity_compactification.md`.
Quality rubric: `engelking_8_4_13_smirnov_proximity_compactification.criteria.md`.
-/

namespace Dataset
namespace EngelkingGeneralTopology

universe u v w

/-- Engelking 8.4.13, Smirnov's compactification-proximity correspondence. -/
theorem engelking_8_4_13_smirnov_proximity_compactification
    {X : Type u} [TopologicalSpace X] [T35Space X] :
    (∀ (K : Type v) (tK : TopologicalSpace K) (e : X → K),
      @IsCompactification X K _ tK e →
        ∃ p : Proximity X, @IsAssignedProximity X K _ tK e p) ∧
    (∀ p : Proximity X, ∃ (K : Type v) (_ : TopologicalSpace K) (e : X → K),
      IsCompactification e ∧ IsAssignedProximity e p) ∧
    ∀ (K L : Type v) (_ : TopologicalSpace K) (_ : TopologicalSpace L)
      (e : X → K) (f : X → L) (p : Proximity X),
        IsCompactification e → IsCompactification f →
        IsAssignedProximity e p → IsAssignedProximity f p →
        EquivalentCompactifications e f := by
  sorry

end EngelkingGeneralTopology
end Dataset
