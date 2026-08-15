import Dataset.GrafakosFourier.Defs
import Mathlib.Analysis.Distribution.SchwartzSpace.Fourier
import Mathlib.Analysis.Fourier.AddCircle
import Mathlib.MeasureTheory.Function.LpSeminorm.Basic
import Mathlib.MeasureTheory.Integral.Bochner.Basic

/-!
# `grafakos_4_3_15_carleson_hunt_line`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `grafakos_4_3_15_carleson_hunt_line.md`.
Quality rubric: `grafakos_4_3_15_carleson_hunt_line.criteria.md`.
-/

open Filter Function MeasureTheory Metric Set
open scoped ENNReal FourierTransform SchwartzMap Topology

namespace Dataset
namespace GrafakosFourier

universe u v

/-- Grafakos 4.3.15, the Carleson-Hunt maximal estimate on the line. -/
theorem grafakos_4_3_15_carleson_hunt_line {p : ℝ} (hp : 1 < p) :
    ∃ C : ℝ≥0∞, C < ∞ ∧ ∀ f : 𝓢(ℝ, ℂ),
      ENNReal.rpow (∫⁻ x, ENNReal.rpow (carlesonHuntMaximal f x) p) (1 / p) ≤
        C * eLpNorm (f : ℝ → ℂ) (ENNReal.ofReal p) volume := by
  sorry

end GrafakosFourier
end Dataset
