# Criteria: niven_zuckerman_11_mann_alpha_beta_theorem

**Statement:** [niven_zuckerman_11_mann_alpha_beta_theorem.md](niven_zuckerman_11_mann_alpha_beta_theorem.md) · **Lean:** [niven_zuckerman_11_mann_alpha_beta_theorem.lean](niven_zuckerman_11_mann_alpha_beta_theorem.lean)

Mann's theorem is about **Schnirelmann** density, and that is essential: the analogous statement for asymptotic density is false. This book uses **two** densities with confusingly similar notation: the asymptotic density $\delta(A) = \lim A(n)/n$ of Definition 11.1 and the Schnirelmann density $d(A) = \inf_{n\ge1}A(n)/n$ of Definition 11.2, which satisfy $d(A) \le \delta(A)$. Picking the wrong one is the characteristic error in this chapter. The bound is $\min(1, \alpha+\beta)$ — the truncation at `1` is not cosmetic, since densities cannot exceed `1`.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Semantic closeness / which density | Schnirelmann density throughout. Mathlib provides `schnirelmannDensity`, so this is also the cheap direction. | ✅ `schnirelmannDensity` for all three. ❗ Predicted error: asymptotic density, for which the theorem fails. |
| 2 | Conclusion completeness | The bound is `min 1 (α + β) ≤ γ`. Writing `α + β ≤ γ` is false whenever `α + β > 1`. | ✅ `min 1 (…) ≤ …`, with the smaller side on the left per mathlib convention. ❗ Highest-value trap. |
| 3 | Hypothesis completeness | Both sets must contain `0`; Definition 11.3 assumes it, and without it the sumset is not the intended one. | ✅ `hA : 0 ∈ A`, `hB : 0 ∈ B`. ❗ Predicted error: omitting them. |
| 4 | Faithful encoding | $A+B = \{a+b : a \in A,\ b \in B\}$, which for sets of naturals is mathlib's pointwise `A + B`; spelled out here to keep the `DecidablePred` instance explicit. | ⚠️ `{n \| ∃ a ∈ A, ∃ b ∈ B, n = a + b}` is definitionally the pointwise sum; using `open Pointwise` and `A + B` would be tidier. |
| 5 | Mathlib conventions | `schnirelmannDensity` needs a `DecidablePred` instance for each set, including the sumset. | ⚠️ Three instance arguments are carried; `Classical.dec` would remove them at the cost of transparency. |
