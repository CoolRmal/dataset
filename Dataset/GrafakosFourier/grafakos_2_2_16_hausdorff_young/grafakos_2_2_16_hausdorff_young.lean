import Dataset.GrafakosFourier.Defs
import Mathlib.Analysis.Distribution.SchwartzSpace.Fourier
import Mathlib.Analysis.Fourier.AddCircle
import Mathlib.MeasureTheory.Function.LpSeminorm.Basic
import Mathlib.MeasureTheory.Integral.Bochner.Basic

/-!
# `grafakos_2_2_16_hausdorff_young`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `grafakos_2_2_16_hausdorff_young.md`.
Quality rubric: `grafakos_2_2_16_hausdorff_young.criteria.md`.
-/

open Filter Function MeasureTheory Metric Set
open scoped ENNReal FourierTransform SchwartzMap Topology

namespace Dataset
namespace GrafakosFourier

universe u v

/-- Grafakos 2.2.16, the Hausdorff-Young inequality. -/
theorem grafakos_2_2_16_hausdorff_young
    {n : ℕ} {p : ℝ} {f : EuclideanSpace ℝ (Fin n) → ℂ}
    (hp : 1 ≤ p ∧ p ≤ 2) (hf : MemLp f (ENNReal.ofReal p) volume) :
    let conjugateExponent : ℝ≥0∞ := if p = 1 then ∞ else ENNReal.ofReal (p / (p - 1))
    ∃ F : EuclideanSpace ℝ (Fin n) → ℂ,
      IsLpFourierTransform (ENNReal.ofReal p) conjugateExponent f F ∧
      MemLp F conjugateExponent volume ∧
        eLpNorm F conjugateExponent volume ≤ eLpNorm f (ENNReal.ofReal p) volume := by
  sorry

end GrafakosFourier
end Dataset
