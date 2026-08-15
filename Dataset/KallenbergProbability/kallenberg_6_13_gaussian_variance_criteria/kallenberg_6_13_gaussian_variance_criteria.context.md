# Context: kallenberg_6_13_gaussian_variance_criteria

**Statement:** [kallenberg_6_13_gaussian_variance_criteria.md](kallenberg_6_13_gaussian_variance_criteria.md) · **Criteria:** [kallenberg_6_13_gaussian_variance_criteria.criteria.md](kallenberg_6_13_gaussian_variance_criteria.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Triangular arrays and the Lindeberg condition

**Triangular array.** For each $n$ a finite row $\xi_{n1},\dots,\xi_{nk_n}$ of random variables, with the
row length allowed to depend on $n$. The variables **within a row** are mutually independent; nothing is
assumed across rows.

**Standing hypotheses**, above the equivalence: every $\xi_{nj}$ has mean $0$ and finite variance, and
$\sum_j \operatorname{Var}(\xi_{nj}) \to 1$. These belong to the setup, not to either side.

**Condition (i) is a conjunction**: the row sums converge in distribution to $N(0,1)$ **and**
$\sup_j \operatorname{Var}(\xi_{nj}) \to 0$ (the array is asymptotically negligible). Without the second
half the equivalence is false.

**Condition (ii), the Lindeberg condition**:
$\sum_j \mathbb{E}\bigl(\xi_{nj}^2 ; |\xi_{nj}| > \varepsilon\bigr) \to 0$ for every $\varepsilon > 0$.
The notation $\mathbb{E}(Y; A)$ means $\mathbb{E}[Y \mathbf{1}_A]$ — the expectation of $Y$ restricted to
the event $A$, not a conditional expectation. The threshold event is the **strict** inequality
$|\xi_{nj}| > \varepsilon$, and the $\varepsilon$-quantifier is outside the limit.
