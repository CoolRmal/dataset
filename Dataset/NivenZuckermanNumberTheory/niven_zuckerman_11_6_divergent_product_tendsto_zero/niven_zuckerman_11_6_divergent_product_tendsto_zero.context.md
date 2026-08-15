# Context: niven_zuckerman_11_6_divergent_product_tendsto_zero

**Statement:** [niven_zuckerman_11_6_divergent_product_tendsto_zero.md](niven_zuckerman_11_6_divergent_product_tendsto_zero.md) · **Criteria:** [niven_zuckerman_11_6_divergent_product_tendsto_zero.criteria.md](niven_zuckerman_11_6_divergent_product_tendsto_zero.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Divergent series and vanishing products

**The hypotheses.** $0 < c_j < 1$ for every $j$, and $\sum_j c_j$ **diverges** — its partial sums tend to
$+\infty$. Both bounds on $c_j$ are used: positivity makes the factors $< 1$, and $c_j < 1$ keeps them
positive.

**The conclusion**, as printed, is: for every $\varepsilon > 0$ there is $N$ with
$\prod_{j=1}^{n}(1-c_j) < \varepsilon$ for **every** $n \ge N$. Since the factors lie in $(0,1)$ the
partial products are decreasing and positive, so this says exactly that they **tend to $0$**.

**The products are over $j$ up to $n$**, of the numbers $1 - c_j$.
