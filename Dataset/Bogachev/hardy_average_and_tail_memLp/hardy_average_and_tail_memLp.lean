import Mathlib.MeasureTheory.Integral.Prod

/-!
# `hardy_average_and_tail_memLp` — 4.7.75

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `hardy_average_and_tail_memLp.md`.
Quality rubric: `hardy_average_and_tail_memLp.criteria.md`.
-/

open MeasureTheory Set

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
