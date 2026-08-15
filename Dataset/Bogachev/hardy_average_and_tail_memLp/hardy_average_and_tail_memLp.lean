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
# `hardy_average_and_tail_memLp` — 4.7.75

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `hardy_average_and_tail_memLp.md`.
Quality rubric: `hardy_average_and_tail_memLp.criteria.md`.
-/

open Filter MeasureTheory ProbabilityTheory Set Topology
open scoped BoundedContinuousFunction ENNReal MeasureTheory NNReal ProbabilityTheory Topology

namespace Dataset
namespace Bogachev

/-- **Exercise 4.7.75 (G. Hardy).**
Let `f ∈ L^p(0, +∞)`, where `1 < p < ∞`. Define, for `x > 0`,

`φ(x) = (1 / x) * ∫ t in 0..x, f t`

and

`ψ(x) = ∫ t in (x, +∞), f t / t`.

Then both `φ` and `ψ` belong to `L^p(0, +∞)`.
-/
theorem hardy_average_and_tail_memLp
    (f : ℝ → ℝ) (p : ℝ) (hp : 1 < p)
    (hf : MemLp f (ENNReal.ofReal p) (volume.restrict (Ioi (0 : ℝ)))) :
    MemLp
        (fun x : ℝ =>
          (1 / x) * (∫ t in (0 : ℝ)..x, f t ∂volume))
        (ENNReal.ofReal p) (volume.restrict (Ioi (0 : ℝ))) ∧
      MemLp
        (fun x : ℝ =>
          ∫ t in Ioi x, f t / t ∂volume)
        (ENNReal.ofReal p) (volume.restrict (Ioi (0 : ℝ))) := by
  sorry

end Bogachev
end Dataset
