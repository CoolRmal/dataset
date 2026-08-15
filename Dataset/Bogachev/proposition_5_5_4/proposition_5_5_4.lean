import Dataset.Bogachev.Defs
import Mathlib.Analysis.Calculus.ContDiff.Basic
import Mathlib.Analysis.Convex.Function
import Mathlib.Analysis.Normed.Module.FiniteDimension
import Mathlib.MeasureTheory.Constructions.Polish.Basic
import Mathlib.MeasureTheory.Function.UniformIntegrable
import Mathlib.MeasureTheory.Integral.Prod
import Mathlib.MeasureTheory.Measure.NullMeasurable
import Mathlib.MeasureTheory.Measure.ProbabilityMeasure
import Mathlib.MeasureTheory.Measure.Regular
import Mathlib.MeasureTheory.Measure.Tight
import Mathlib.MeasureTheory.VectorMeasure.Basic
import Mathlib.MeasureTheory.VectorMeasure.Decomposition.Jordan

/-!
# `proposition_5_5_4` — 5.5.4

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `proposition_5_5_4.md`.
Quality rubric: `proposition_5_5_4.criteria.md`.
-/

open Filter MeasureTheory ProbabilityTheory Set Topology
open scoped BoundedContinuousFunction ENNReal MeasureTheory NNReal ProbabilityTheory Topology

namespace Dataset
namespace Bogachev

/-- **Proposition 5.5.4.**
Let `f` be a function on the real line and let `E` be a measurable set such
that at every point of `E` the function `f` is differentiable. Then

`λ (f(E)) ≤ ∫_E |f'(x)| dx`.

In particular, the function `f` on `E` has Lusin's property (N). If for all
`x ∈ E` we have `|f'(x)| ≤ L`, then `λ (f(E)) ≤ L * λ(E)`.
-/
theorem proposition_5_5_4
    (f : ℝ → ℝ) (E : Set ℝ) (hE : NullMeasurableSet E volume)
    (hf : ∀ x ∈ E, DifferentiableAt ℝ f x) :
    (volume (f '' E) ≤ ∫⁻ x in E, ENNReal.ofReal (abs (deriv f x)) ∂volume) ∧
      HasLusinPropertyNOn f E volume volume ∧
      ∀ L : ℝ,
        (∀ x ∈ E, abs (deriv f x) ≤ L) →
          volume (f '' E) ≤ ENNReal.ofReal L * volume E := by
  sorry

end Bogachev
end Dataset
