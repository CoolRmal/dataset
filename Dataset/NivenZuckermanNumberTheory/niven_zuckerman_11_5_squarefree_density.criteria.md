# Criteria: niven_zuckerman_11_5_squarefree_density

**Statement:** [niven_zuckerman_11_5_squarefree_density.md](niven_zuckerman_11_5_squarefree_density.md) · **Lean:** [niven_zuckerman_11_5_squarefree_density.lean](niven_zuckerman_11_5_squarefree_density.lean)

The density asserted is the **natural** (asymptotic) density, a genuine limit of $A(n)/n$ — not the Schnirelmann density, which for the square-free integers is $0$ since $4 \notin A$. This book uses **two** densities with confusingly similar notation: the asymptotic density $\delta(A) = \lim A(n)/n$ of Definition 11.1 and the Schnirelmann density $d(A) = \inf_{n\ge1}A(n)/n$ of Definition 11.2, which satisfy $d(A) \le \delta(A)$. Picking the wrong one is the characteristic error in this chapter.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Semantic closeness / which density | Natural density, i.e. a limit. Schnirelmann density of the square-free set is `0` (because `4` is missing), so using mathlib's `schnirelmannDensity` gives a *false* statement. | ✅ `HasNaturalDensity {n \| Squarefree n} (6 / π²)`. ❗ Highest-value trap: reaching for `schnirelmannDensity` because it is the one mathlib provides. |
| 2 | Faithful encoding | `HasNaturalDensity A d` is `Tendsto (fun n ↦ A(n)/n) atTop (𝓝 d)` with `A(n)` counting the elements of `A` in `[1, n]`; phrasing the density as a `limsup` or as a bare value would introduce a junk default. | ✅ Stated as a `Tendsto`, so existence of the limit is part of the claim. ❗ Predicted error: `naturalDensity A = 6/π²` with a junk-valued `naturalDensity`. |
| 3 | Faithful encoding | "Square-free" is mathlib's `Squarefree n` — divisible by no square `> 1`. Note `Squarefree 0` is false and `Squarefree 1` is true, matching the book. | ✅ mathlib's predicate reused. |
| 4 | Junk values | `countingFunction` is a `Nat.card` of a set that is finite for each `n`; the ratio is a real division by `n`, junk at `n = 0` but irrelevant under `atTop`. | ⚠️ Safe under the filter. |
