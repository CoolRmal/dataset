module

public import Mathlib.Analysis.Calculus.ContDiff.Basic
public import Mathlib.Analysis.Convex.Function
public import Mathlib.Analysis.Normed.Module.FiniteDimension
public import Mathlib.MeasureTheory.Constructions.Polish.Basic
public import Mathlib.MeasureTheory.Function.UniformIntegrable
public import Mathlib.MeasureTheory.Integral.Prod
public import Mathlib.MeasureTheory.Measure.NullMeasurable
public import Mathlib.MeasureTheory.Measure.ProbabilityMeasure
public import Mathlib.MeasureTheory.Measure.Regular
public import Mathlib.MeasureTheory.Measure.Tight
public import Mathlib.MeasureTheory.VectorMeasure.Basic
public import Mathlib.MeasureTheory.VectorMeasure.Decomposition.Jordan

/-!
# `hardy_average_and_tail_memLp` — 4.7.75

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `hardy_average_and_tail_memLp.md`.
Quality rubric: `hardy_average_and_tail_memLp.criteria.md`.
-/

@[expose] public section

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
