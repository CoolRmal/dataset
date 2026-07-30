module

public import Dataset.KrylovHolder.Defs
public import Mathlib.Analysis.Calculus.ContDiff.Basic
public import Mathlib.Analysis.Calculus.IteratedDeriv.Defs
public import Mathlib.MeasureTheory.Integral.Bochner.Basic
public import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
public import Mathlib.MeasureTheory.Measure.Hausdorff

/-!
# `krylov_8_7_3_shifted_heat_holder_solvability`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_8_7_3_shifted_heat_holder_solvability.md`.
Quality rubric: `krylov_8_7_3_shifted_heat_holder_solvability.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology
open scoped ENNReal Topology

namespace Dataset
namespace KrylovHolder

/-- Krylov 8.7.3, whole-space solvability for the shifted heat equation. -/
theorem krylov_8_7_3_shifted_heat_holder_solvability
    {d : ℕ} {δ : ℝ} (hδ : 0 < δ ∧ δ < 1) :
    ∀ f : (ℝ × (Fin d → ℝ)) → ℝ, ParabolicHolderOn δ univ f →
      ∃! u : (ℝ × (Fin d → ℝ)) → ℝ,
        ParabolicHolderOn (2 + δ) univ u ∧ ShiftedHeatEquation u f := by
  sorry

end KrylovHolder
end Dataset
