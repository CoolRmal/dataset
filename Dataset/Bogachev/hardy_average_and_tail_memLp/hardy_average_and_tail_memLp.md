# Bogachev, *Measure Theory*, Exercise 4.7.75 (G. Hardy)

- **Source:** V. I. Bogachev, *Measure Theory*, Volume I
- **Domain:** Analysis
- **Lean declaration:** `Dataset.Bogachev.hardy_average_and_tail_memLp` ([hardy_average_and_tail_memLp.lean](hardy_average_and_tail_memLp.lean))
- **Criteria:** [hardy_average_and_tail_memLp.criteria.md](hardy_average_and_tail_memLp.criteria.md)
- **Context:** [hardy_average_and_tail_memLp.context.md](hardy_average_and_tail_memLp.context.md)

## Statement

**4.7.75. (G. Hardy)** Let $f \in L^p(0, +\infty)$, where $p > 1$. Show that the functions

$$\varphi(x) = \frac{1}{x} \int_0^x f(t) \, dt \quad \text{and} \quad \psi(x) = \int_x^{+\infty} \frac{f(t)}{t} \, dt$$

belong to $L^p(0, +\infty)$ as well.
