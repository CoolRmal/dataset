# Context: niven_zuckerman_10_16_ramanujan_congruence

**Statement:** [niven_zuckerman_10_16_ramanujan_congruence.md](niven_zuckerman_10_16_ramanujan_congruence.md) · **Criteria:** [niven_zuckerman_10_16_ramanujan_congruence.criteria.md](niven_zuckerman_10_16_ramanujan_congruence.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Ramanujan's congruence

**Euler's product and partitions.** $\phi(x) = \prod_{n=1}^{\infty}(1-x^n)$ converges for $0 \le x < 1$,
and $1/\phi(x) = \sum_{n\ge0}p(n)x^n$ is the generating function of the partition function $p(n)$ — the
number of ways of writing $n$ as a sum of positive integers, order irrelevant, with $p(0)=1$. All the
identities in this chapter are identities of **real-valued functions on $[0,1)$**, not formal power series,
so convergence is part of what they assert.

**$p(n)$ is the partition function**: the number of ways of writing $n$ as an unordered sum of positive
integers, with $p(0)=1$. Repeats among the parts are allowed; only the multiset matters.

**The claim** is $p(5m+4)\equiv0\pmod5$ for **every** natural number $m$, with no side condition —
including $m = 0$, which gives $p(4) = 5$.

**Divisibility by $5$** is the conclusion; nothing is claimed about $p(n)$ for $n$ in the other residue
classes.
