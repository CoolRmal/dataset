# Context: grafakos_3_2_8_poisson_summation

**Statement:** [grafakos_3_2_8_poisson_summation.md](grafakos_3_2_8_poisson_summation.md) · **Criteria:** [grafakos_3_2_8_poisson_summation.criteria.md](grafakos_3_2_8_poisson_summation.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation

Grafakos normalises $\widehat f(\xi)=\int f(x)e^{-2\pi i x\cdot\xi}dx$, with the $2\pi$ in the exponent and no prefactor; every constant below depends on that choice.

The two hypotheses are independent: the decay bound, and absolute summability of $\widehat f$ on $\mathbb{Z}^n$. The character carries the **opposite** sign to the transform, and the identity holds at every $x$.
