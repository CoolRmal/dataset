import Dataset.KrylovHolder.Defs

/-!
# `krylov_8_7_3_shifted_heat_holder_solvability`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_8_7_3_shifted_heat_holder_solvability.md`.
Quality rubric: `krylov_8_7_3_shifted_heat_holder_solvability.criteria.md`.
-/

open Set

namespace Dataset
namespace KrylovHolder

/-- Krylov 8.7.3, whole-space solvability for the shifted heat equation. -/
theorem krylov_8_7_3_shifted_heat_holder_solvability
    {d : ℕ} {δ : ℝ} (hδ : 0 < δ ∧ δ < 1) :
    ∀ f : (ℝ × EuclideanSpace ℝ (Fin d)) → ℝ, ParabolicHolderOn δ univ f →
      ∃! u : (ℝ × EuclideanSpace ℝ (Fin d)) → ℝ,
        ParabolicHolderOn (2 + δ) univ u ∧ ShiftedHeatEquation u f := by
  sorry

end KrylovHolder
end Dataset
