# Criteria: niven_zuckerman_11_6_divergent_product_tendsto_zero

**Statement:** [niven_zuckerman_11_6_divergent_product_tendsto_zero.md](niven_zuckerman_11_6_divergent_product_tendsto_zero.md) · **Lean:** [niven_zuckerman_11_6_divergent_product_tendsto_zero.lean](niven_zuckerman_11_6_divergent_product_tendsto_zero.lean)

The hypothesis is that $\sum c_j$ **diverges**; with a convergent series the conclusion is false (the product converges to a positive limit). The book states the conclusion in $\varepsilon$–$N$ form, which for a decreasing sequence of positive partial products is exactly convergence to `0`.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Hypothesis completeness | Divergence of $\sum c_j$ is the whole hypothesis; $0 < c_j < 1$ keeps every factor in `(0,1)`. | ✅ `hdiv`, `hpos`, `hlt`. ❗ Highest-value trap: dropping `hdiv`, which makes the statement false for `c j = 2⁻ʲ⁺¹`. |
| 2 | Faithful encoding | "$\sum c_j$ diverges" for a positive series is `Tendsto (partial sums) atTop atTop`, not `¬ Summable`, though the two agree here. | ✅ `Tendsto … atTop atTop`. ⚠️ `¬ Summable c` would be equivalent for nonnegative `c`. |
| 3 | Conclusion completeness | The $\varepsilon$–$N$ form is convergence of the partial products to `0`. | ✅ `Tendsto (fun n ↦ ∏ j ∈ range n, (1 - c j)) atTop (𝓝 0)`. |
| 4 | Mathlib conventions | Products over `Finset.range n` index `j = 0, …, n-1`; the book indexes from `1`. The shift is immaterial since the hypothesis is symmetric in the indexing. | ⚠️ Harmless reindexing. |
