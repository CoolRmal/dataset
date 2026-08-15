import Dataset.GrafakosFourier.Defs
import Mathlib.Analysis.Distribution.SchwartzSpace.Fourier
import Mathlib.Analysis.Fourier.AddCircle
import Mathlib.MeasureTheory.Function.LpSeminorm.Basic
import Mathlib.MeasureTheory.Integral.Bochner.Basic

/-!
# `grafakos_5_3_1_calderon_zygmund_decomposition`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `grafakos_5_3_1_calderon_zygmund_decomposition.md`.
Quality rubric: `grafakos_5_3_1_calderon_zygmund_decomposition.criteria.md`.
-/

open Filter Function MeasureTheory Metric Set
open scoped ENNReal FourierTransform SchwartzMap Topology

namespace Dataset
namespace GrafakosFourier

universe u v

/-- Grafakos 5.3.1, the Calderon-Zygmund decomposition. -/
theorem grafakos_5_3_1_calderon_zygmund_decomposition
    {n : ℕ} {f : EuclideanSpace ℝ (Fin n) → ℂ} {α : ℝ}
    (hf : MemLp f 1 volume) (hα : 0 < α) :
    ∃ g b : EuclideanSpace ℝ (Fin n) → ℂ,
      ∃ (J : Set ℕ) (Q : J → DyadicCube n)
        (bad : J → EuclideanSpace ℝ (Fin n) → ℂ),
        f = g + b ∧
          Tendsto (fun s : Finset J ↦ eLpNorm (b - ∑ j ∈ s, bad j) 1 volume) atTop (𝓝 0) ∧
          MemLp g 1 volume ∧ MemLp b 1 volume ∧ (∀ j, MemLp (bad j) 1 volume) ∧
          eLpNorm g 1 volume ≤ eLpNorm f 1 volume ∧
          eLpNorm g ∞ volume ≤ ENNReal.ofReal (2 ^ n * α) ∧
          (Pairwise fun i j ↦ Disjoint (Q i).carrier (Q j).carrier) ∧
          (∀ j, Function.support (bad j) ⊆ (Q j).carrier) ∧
          (∀ j, ∫ x, bad j x = 0) ∧
          (∀ j, eLpNorm (bad j) 1 volume ≤
            ENNReal.ofReal (2 ^ (n + 1) * α) * volume (Q j).carrier) ∧
          ∑' j : J, volume (Q j).carrier ≤ eLpNorm f 1 volume / ENNReal.ofReal α := by
  sorry

end GrafakosFourier
end Dataset
