# L. Grafakos, *Classical Fourier Analysis*, Theorem 5.6.6 (the Fefferman–Stein vector-valued maximal inequalities)

- **Source:** L. Grafakos, *Classical Fourier Analysis*
- **Domain:** Fourier analysis
- **Lean declaration:** `Dataset.GrafakosFourier.grafakos_5_6_6_vector_valued_maximal` ([grafakos_5_6_6_vector_valued_maximal.lean](grafakos_5_6_6_vector_valued_maximal.lean))
- **Criteria:** [grafakos_5_6_6_vector_valued_maximal.criteria.md](grafakos_5_6_6_vector_valued_maximal.criteria.md)
- **Context:** [grafakos_5_6_6_vector_valued_maximal.context.md](grafakos_5_6_6_vector_valued_maximal.context.md)

## Statement

**Theorem 5.6.6.** For $1 < p, r < \infty$ the Hardy–Littlewood maximal function $M$ satisfies the vector-valued inequalities
$$\left\| \left( \sum_j |M(f_j)|^r \right)^{1/r} \right\|_{1,\infty} \le C_n \left( 1 + (r-1)^{-1} \right) \left\| \left( \sum_j |f_j|^r \right)^{1/r} \right\|_{1}$$
and
$$\left\| \left( \sum_j |M(f_j)|^r \right)^{1/r} \right\|_{p} \le C_n\, c(p,r) \left\| \left( \sum_j |f_j|^r \right)^{1/r} \right\|_{p}.$$
