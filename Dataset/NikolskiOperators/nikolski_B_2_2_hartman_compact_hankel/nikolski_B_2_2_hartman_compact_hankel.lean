import Dataset.NikolskiOperators.Defs

/-!
# `nikolski_B_2_2_hartman_compact_hankel` — 2.2.5

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `nikolski_B_2_2_hartman_compact_hankel.md`.
Quality rubric: `nikolski_B_2_2_hartman_compact_hankel.criteria.md`.
-/

namespace Dataset
namespace NikolskiOperators

/--
Nikol'ski, *Operators, Functions, and Systems*, Volume 1, Part B, Section 2.2:
Hartman's compactness theorem in the Adamyan-Arov-Krein form: a bounded Hankel
operator is compact exactly when its symbol belongs to `H∞ + C`.
-/
theorem nikolski_B_2_2_hartman_compact_hankel
    {a : ℕ → ℂ} :
    CompactHankel a ↔ ∃ φ : {z : ℂ // ‖z‖ = 1} → ℂ,
      HasBoundedHankelSymbol a φ ∧ InHInfinityPlusContinuous φ := by
  sorry

end NikolskiOperators
end Dataset
