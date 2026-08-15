import Dataset.KrylovSobolev.Defs

/-!
# `krylov_sobolev_12_2_13_real_strongly_elliptic_order_even`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_sobolev_12_2_13_real_strongly_elliptic_order_even.md`.
Quality rubric: `krylov_sobolev_12_2_13_real_strongly_elliptic_order_even.criteria.md`.
-/

open Filter Function MeasureTheory Set Topology
open scoped ContDiff ENNReal Laplacian NNReal SchwartzMap Topology

namespace Dataset
namespace KrylovSobolev

/-- Krylov Exercise 12.2.13: if the coefficients `a^α` of an `m`th order strongly elliptic
operator `L = ∑_{|α| ≤ m} a^α D^α` are all real and `d ≥ 2`, then `m` is even. -/
theorem krylov_sobolev_12_2_13_real_strongly_elliptic_order_even {d m : ℕ} (hd : 2 ≤ d)
    (hm : 1 ≤ m) (P : MvPolynomial (Fin d) ℂ) (hP : IsStronglyElliptic m P)
    (hreal : ∀ α : Fin d →₀ ℕ, (P.coeff α).im = 0) : Even m := by
  sorry

end KrylovSobolev
end Dataset
