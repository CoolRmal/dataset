module

public import Dataset.NivenZuckermanNumberTheory.Defs

/-!
# `niven_zuckerman_11_6_divergent_product_tendsto_zero`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `niven_zuckerman_11_6_divergent_product_tendsto_zero.md`.
Quality rubric: `niven_zuckerman_11_6_divergent_product_tendsto_zero.criteria.md`.
-/

@[expose] public section

open Filter
open scoped Topology

namespace Dataset
namespace NivenZuckermanNumberTheory

/-- Niven–Zuckerman 11.6: if `∑ cⱼ` diverges and `0 < cⱼ < 1`, then the partial products of
`1 - cⱼ` tend to `0`. -/
theorem niven_zuckerman_11_6_divergent_product_tendsto_zero (c : ℕ → ℝ)
    (hpos : ∀ j, 0 < c j) (hlt : ∀ j, c j < 1)
    (hdiv : Tendsto (fun n ↦ ∑ j ∈ Finset.range n, c j) atTop atTop) :
    Tendsto (fun n ↦ ∏ j ∈ Finset.range n, (1 - c j)) atTop (𝓝 0) := by
  sorry

end NivenZuckermanNumberTheory
end Dataset
