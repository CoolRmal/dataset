# Criteria: niven_zuckerman_11_mann_alpha_beta_theorem

**Statement:** [niven_zuckerman_11_mann_alpha_beta_theorem.md](niven_zuckerman_11_mann_alpha_beta_theorem.md) · **Lean:** [niven_zuckerman_11_mann_alpha_beta_theorem.lean](niven_zuckerman_11_mann_alpha_beta_theorem.lean)

## What the theorem says

Let $A$ and $B$ be sets of non-negative integers, each containing $0$, and let $A+B$ be the set of
all sums $a+b$ with $a \in A$ and $b \in B$. Measure each set by its Schnirelmann density, the
infimum over $n \ge 1$ of (number of members in $1,\dots,n$) divided by $n$. Writing $\alpha$,
$\beta$, $\gamma$ for the three densities, Mann's theorem says
$\gamma \ge \min(1, \alpha+\beta)$. So densities add when adding sets, except that the answer is
capped at $1$ — which it must be, since no density exceeds $1$.

Be careful: this chapter uses two different densities with similar names. Mann's theorem is about
the Schnirelmann density $d(A) = \inf_{n\ge1}A(n)/n$ of Definition 11.2, not the asymptotic density
$\delta(A) = \lim A(n)/n$ of Definition 11.1. Choosing the wrong one is the characteristic error in
this chapter.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $A$ and $B$ are arbitrary sets of non-negative integers. | ✅ `(A B : Set ℕ)`. |
| 2 | Both sets contain $0$. | ✅ `hA : (0 : ℕ) ∈ A` and `hB : (0 : ℕ) ∈ B`. |
| 3 | The density used for all three sets is the Schnirelmann one, the infimum of $A(n)/n$ over $n \ge 1$. | ✅ `schnirelmannDensity`, which mathlib defines as `⨅ n : {n // 0 < n}, #{a ∈ Ioc 0 n \| a ∈ A} / n`. |
| 4 | The sumset is $\{a + b : a \in A,\ b \in B\}$. | ✅ `{n : ℕ \| ∃ a ∈ A, ∃ b ∈ B, n = a + b}`. |
| 5 | The bound is the minimum of $1$ and $\alpha+\beta$, not $\alpha+\beta$ itself. | ✅ `min 1 (schnirelmannDensity A + schnirelmannDensity B) ≤ …`. |
| 6 | The inequality points the right way: the sumset density is the *larger* side. | ✅ The `min` is on the left of `≤`, so the sumset density is on the right. |
| 7 | Each set fed to `schnirelmannDensity` carries a way to decide membership, the sumset included. | ✅ Three `DecidablePred` instance arguments. ⚠️ Carrying them explicitly is noisy; `Classical.dec` would remove them, at the cost of hiding what is going on. |
| 8 | No extra hypotheses: no finiteness, no positivity of the densities, no requirement that either density be attained. | ✅ Only membership of $0$ is assumed. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Dropping the `min` and asserting $\alpha + \beta \le \gamma$. | This is the highest-value trap and it is false. Take $A = B = \mathbb{N}$: then $\alpha = \beta = 1$ and $\gamma = 1$, but $\alpha+\beta = 2$. Densities are capped at $1$. |
| 2 | Using asymptotic density in place of Schnirelmann density. | A different theorem, and not a true one as stated: the asymptotic density of a sumset need not even exist, so the three limits the statement would refer to may not be defined. |
| 3 | Omitting $0 \in A$ or $0 \in B$. | Makes the statement false. With $A = B = \{1,2,3,\dots\}$ we get $\alpha = \beta = 1$, so the bound claims $\gamma \ge 1$; but $A+B = \{2,3,4,\dots\}$ misses $1$, so at $n = 1$ the ratio is $0$ and $\gamma = 0$. |
| 4 | Reversing the inequality to $\gamma \le \min(1, \alpha+\beta)$. | False. Let $A$ be $\{0\}$ together with the even numbers and $B$ be $\{0\}$ together with the odd numbers. Then $\alpha = 0$ (nothing in $A$ lands on $1$) and $\beta = 1/2$, so the right side is $1/2$; but $A+B$ is everything, so $\gamma = 1$. |
| 5 | Defining the sumset with the $0$ contributions removed, e.g. requiring $a,b \ge 1$. | Then $A+B$ no longer contains $A$ and $B$, and the theorem fails for the same reason as row 3. |
| 6 | Stating only the special case $\alpha + \beta \ge 1 \Rightarrow A + B = \mathbb{N}$. | That case is already in mathlib as `add_eq_univ_of_one_le_schirelmannDensity_add_schnirelmannDensity`. The content of Mann's theorem is the remaining case $\alpha+\beta < 1$. |
| 7 | Stating Schnirelmann's weaker inequality $\gamma \ge \alpha + \beta - \alpha\beta$. | A genuinely weaker bound. Mann's theorem is the sharp $\alpha\beta$ statement the section is named after. |

## Notes on the ground truth

- The sumset is written out as `{n \| ∃ a ∈ A, ∃ b ∈ B, n = a + b}` so that the `DecidablePred`
  instance for it is explicit. With `open Pointwise` this is the same set as `A + B`, and a
  candidate using the pointwise notation is equally faithful and tidier.
- The value of `schnirelmannDensity` does not depend on which `DecidablePred` instance is supplied,
  so the three instance arguments are bookkeeping rather than mathematical content.
- `min 1 (α + β) ≤ γ` is mathlib's preferred orientation for $\gamma \ge \min(1, \alpha+\beta)$; the
  two are the same statement.
- Mathlib defines `schnirelmannDensity` exactly as Definition 11.2 does, so no custom definition is
  needed here. Mann's theorem itself is not in mathlib — the Schnirelmann file lists it as a to-do.
- The truncation at $1$ is not decoration: mathlib's `schnirelmannDensity_le_one` says every one of
  these densities is at most $1$, so an untruncated bound would be unprovable.
