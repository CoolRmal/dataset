module

public import Dataset.NivenZuckermanNumberTheory.Defs

/-!
# `niven_zuckerman_11_3_moebius_zeta_product`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `niven_zuckerman_11_3_moebius_zeta_product.md`.
Quality rubric: `niven_zuckerman_11_3_moebius_zeta_product.criteria.md`.
-/

@[expose] public section

open Filter
open scoped Topology

namespace Dataset
namespace NivenZuckermanNumberTheory

/-- Niven–Zuckerman 11.3: the Dirichlet series of the Möbius function at `2` is the reciprocal
of `∑ 1/n²`. -/
theorem niven_zuckerman_11_3_moebius_zeta_product :
    (∑' n : ℕ, if n = 0 then 0 else (ArithmeticFunction.moebius n : ℝ) / (n : ℝ) ^ 2) *
      (∑' n : ℕ, if n = 0 then 0 else 1 / (n : ℝ) ^ 2) = 1 := by
  sorry

end NivenZuckermanNumberTheory
end Dataset
