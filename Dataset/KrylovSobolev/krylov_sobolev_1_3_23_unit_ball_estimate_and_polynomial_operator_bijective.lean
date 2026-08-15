module

public import Dataset.KrylovSobolev.Defs
public import Mathlib.Algebra.MvPolynomial.PDeriv
public import Mathlib.Analysis.InnerProductSpace.Laplacian
public import Mathlib.MeasureTheory.Measure.Haar.InnerProductSpace

/-!
# `krylov_sobolev_1_3_23_unit_ball_estimate_and_polynomial_operator_bijective`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement:
`krylov_sobolev_1_3_23_unit_ball_estimate_and_polynomial_operator_bijective.md`.
Quality rubric:
`krylov_sobolev_1_3_23_unit_ball_estimate_and_polynomial_operator_bijective.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology
open scoped ContDiff ENNReal Laplacian NNReal SchwartzMap Topology

namespace Dataset
namespace KrylovSobolev

/-- Krylov Exercise 1.3.23 (i)–(ii): for `u` twice continuously differentiable on the closed unit
ball and vanishing on the unit sphere, `‖u‖²_{L₂(B)} + ∑ᵢ ‖u_{xⁱ}‖²_{L₂(B)} ≤ 4‖Δu‖²_{L₂(B)}`;
consequently `p ↦ Δ[(1 - |x|²)p]` is a bijection of the polynomials of total degree `≤ n`. -/
theorem krylov_sobolev_1_3_23_unit_ball_estimate_and_polynomial_operator_bijective {d : ℕ}
    (hd : 1 ≤ d) :
    (∀ u : EuclideanSpace ℝ (Fin d) → ℝ, ContDiffOn ℝ 2 u (Metric.closedBall 0 1) →
        (∀ x ∈ Metric.sphere (0 : EuclideanSpace ℝ (Fin d)) 1, u x = 0) →
        eLpNorm u 2 (volume.restrict (Metric.ball 0 1)) ^ 2 +
            (∑ i, eLpNorm (partialDeriv i u) 2 (volume.restrict (Metric.ball 0 1)) ^ 2) ≤
          4 * eLpNorm (Δ u) 2 (volume.restrict (Metric.ball 0 1)) ^ 2) ∧
      ∀ n : ℕ, Set.BijOn
        (fun p : MvPolynomial (Fin d) ℝ ↦ ∑ i, MvPolynomial.pderiv i
          (MvPolynomial.pderiv i ((1 - (∑ j, MvPolynomial.X j ^ 2)) * p)))
        {p : MvPolynomial (Fin d) ℝ | p.totalDegree ≤ n}
        {p : MvPolynomial (Fin d) ℝ | p.totalDegree ≤ n} := by
  sorry

end KrylovSobolev
end Dataset
