module

public import Dataset.KrylovSobolev.Defs
public import Mathlib.Analysis.Calculus.ContDiff.Basic
public import Mathlib.MeasureTheory.Measure.Haar.OfBasis
public import Mathlib.Topology.Algebra.Support

/-!
# `krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate.md`.
Quality rubric: `krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology
open scoped ContDiff ENNReal Laplacian NNReal SchwartzMap Topology

namespace Dataset
namespace KrylovSobolev

/-- Krylov Exercise 1.4.8: in dimension `d = 2`, for measurable symmetric coefficients `a^{ij}`
obeying `μ|ξ|² ≤ a^{ij}ξ^iξ^j ≤ ν|ξ|²` and `Lu = a^{ij}u_{x^ix^j} - λ(a^{11} + a^{22})u` with
`λ > 0`, every `u ∈ C_0^2` satisfies the a priori estimate (6) with constant `ν²/μ⁴`. -/
theorem krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate {μ ν lam : ℝ} (hμ : 0 < μ)
    (hν : 0 < ν) (hlam : 0 < lam) (a : Fin 2 → Fin 2 → EuclideanSpace ℝ (Fin 2) → ℝ)
    (ha : ∀ i j, Measurable (a i j)) (hsymm : ∀ i j x, a i j x = a j i x)
    (hlb : ∀ (x : EuclideanSpace ℝ (Fin 2)) (ξ : Fin 2 → ℝ),
      μ * (∑ i, ξ i ^ 2) ≤ ∑ i, ∑ j, a i j x * ξ i * ξ j)
    (hub : ∀ (x : EuclideanSpace ℝ (Fin 2)) (ξ : Fin 2 → ℝ),
      (∑ i, ∑ j, a i j x * ξ i * ξ j) ≤ ν * (∑ i, ξ i ^ 2))
    (u : EuclideanSpace ℝ (Fin 2) → ℝ) (hu : ContDiff ℝ 2 u) (hu0 : HasCompactSupport u) :
    ENNReal.ofReal (lam ^ 2) * eLpNorm u 2 volume ^ 2 +
        ENNReal.ofReal (2 * lam) * (∑ j, eLpNorm (partialDeriv j u) 2 volume ^ 2) +
        (∑ j, ∑ k, eLpNorm (partialDeriv k (partialDeriv j u)) 2 volume ^ 2) ≤
      ENNReal.ofReal (ν ^ 2 / μ ^ 4) *
        eLpNorm (fun x ↦ (∑ i, ∑ j, a i j x * partialDeriv j (partialDeriv i u) x) -
          lam * (a 0 0 x + a 1 1 x) * u x) 2 volume ^ 2 := by
  sorry

end KrylovSobolev
end Dataset
