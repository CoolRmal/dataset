# Context: niven_zuckerman_10_15_mod_five_coefficients

**Statement:** [niven_zuckerman_10_15_mod_five_coefficients.md](niven_zuckerman_10_15_mod_five_coefficients.md) · **Criteria:** [niven_zuckerman_10_15_mod_five_coefficients.criteria.md](niven_zuckerman_10_15_mod_five_coefficients.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The coefficients of $x\phi(x)^4$ modulo 5

**Euler's product and partitions.** $\phi(x) = \prod_{n=1}^{\infty}(1-x^n)$ converges for $0 \le x < 1$,
and $1/\phi(x) = \sum_{n\ge0}p(n)x^n$ is the generating function of the partition function $p(n)$ — the
number of ways of writing $n$ as a sum of positive integers, order irrelevant, with $p(0)=1$. All the
identities in this chapter are identities of **real-valued functions on $[0,1)$**, not formal power series,
so convergence is part of what they assert.

**The function expanded is $x\,\phi(x)^4$** — a leading factor $x$ and the fourth power of Euler's
product. Both are part of the statement; $\phi(x)^4$ alone has different coefficients.

**Two conclusions about one sequence.** There are integers $b_m$ with $x\phi(x)^4 = \sum_{m\ge1}b_mx^m$,
**and** $5 \mid b_m$ whenever $5 \mid m$. The same sequence carries both, and one sequence works for every
$x \in [0,1)$.

**This is the key lemma** behind Ramanujan's congruence $p(5m+4)\equiv0\pmod5$.
