# L. Grafakos, *Classical Fourier Analysis*, Theorem 3.2.8 (Poisson summation formula)

- **Source:** L. Grafakos, *Classical Fourier Analysis*
- **Domain:** Fourier analysis
- **Lean declaration:** `Dataset.GrafakosFourier.grafakos_3_2_8_poisson_summation` ([grafakos_3_2_8_poisson_summation.lean](grafakos_3_2_8_poisson_summation.lean))
- **Criteria:** [grafakos_3_2_8_poisson_summation.criteria.md](grafakos_3_2_8_poisson_summation.criteria.md)
- **Context:** [grafakos_3_2_8_poisson_summation.context.md](grafakos_3_2_8_poisson_summation.context.md)

## Statement

**Theorem 3.2.8.** (Poisson summation formula) Let $f$ be a continuous function on $\mathbb{R}^n$ which satisfies
$$|f(x)| \le C(1 + |x|)^{-n-\delta}$$
for some $C, \delta > 0$ and whose Fourier transform $\widehat{f}$ restricted on $\mathbb{Z}^n$ satisfies $\sum_{m \in \mathbb{Z}^n} |\widehat{f}(m)| < \infty$. Then for all $x \in \mathbb{R}^n$,
$$\sum_{m \in \mathbb{Z}^n} \widehat{f}(m)\, e^{2\pi i m \cdot x} = \sum_{k \in \mathbb{Z}^n} f(x + k),$$
and in particular
$$\sum_{m \in \mathbb{Z}^n} \widehat{f}(m) = \sum_{k \in \mathbb{Z}^n} f(k).$$
