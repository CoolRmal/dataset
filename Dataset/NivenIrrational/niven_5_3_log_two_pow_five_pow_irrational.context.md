# Context: niven_5_3_log_two_pow_five_pow_irrational

**Statement:** [niven_5_3_log_two_pow_five_pow_irrational.md](niven_5_3_log_two_pow_five_pow_irrational.md) · **Criteria:** [niven_5_3_log_two_pow_five_pow_irrational.criteria.md](niven_5_3_log_two_pow_five_pow_irrational.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Base-10 logarithms of $2^c5^d$

**All logarithms in this section are to base $10$**: $\log y = k$ means $10^k = y$. A formalization using
the natural logarithm states a different (and, for these arguments, differently-behaved) claim.

**$c$ and $d$ are non-negative integers**, $0$ included, and they are **different**. Difference is
essential: for $c = d$ one gets $\log 10^c = c$, which is rational.

**The argument is $2^c \cdot 5^d$** as a real number, and the conclusion is that its base-$10$ logarithm is
irrational.

**The proof rests on unique factorization**, which is why the primes $2$ and $5$ — the prime factors of the
base — are the interesting ones.
