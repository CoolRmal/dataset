# L. Grafakos, *Classical Fourier Analysis*, Theorem 4.1.1 (uniform boundedness and $L^p$ convergence of summability methods on the torus)

- **Source:** L. Grafakos, *Classical Fourier Analysis*
- **Domain:** Fourier analysis
- **Lean declaration:** `Dataset.GrafakosFourier.grafakos_4_1_1_torus_summability_uniform_boundedness` ([grafakos_4_1_1_torus_summability_uniform_boundedness.lean](grafakos_4_1_1_torus_summability_uniform_boundedness.lean))
- **Criteria:** [grafakos_4_1_1_torus_summability_uniform_boundedness.criteria.md](grafakos_4_1_1_torus_summability_uniform_boundedness.criteria.md)

## Statement

**Theorem 4.1.1.** For $R > 0$ and $m \in \mathbb{Z}^n$, let $a(m, R)$ be complex numbers such that

1. for every $R > 0$ there is a $q_R$ such that $a(m, R) = 0$ if $|m| > q_R$;
2. there is an $M_0 < \infty$ such that $|a(m, R)| \le M_0$ for all $m \in \mathbb{Z}^n$ and all $R > 0$;
3. for each $m \in \mathbb{Z}^n$, the limit of $a(m, R)$ exists as $R \to \infty$ and $\lim_{R \to \infty} a(m, R) = a_m$.

Let $1 \le p < \infty$. For $f \in L^p(\mathbb{T}^n)$ and $x \in \mathbb{T}^n$ define
$$S_R(f)(x) = \sum_{m \in \mathbb{Z}^n} a(m, R)\, \widehat{f}(m)\, e^{2\pi i m \cdot x},$$
noting that the sum is well defined because of (1). Also, for $h \in C^\infty(\mathbb{T}^n)$ define
$$A(h)(x) = \sum_{m \in \mathbb{Z}^n} a_m\, \widehat{h}(m)\, e^{2\pi i m \cdot x}.$$
Then for all $f \in L^p(\mathbb{T}^n)$ the sequence $S_R(f)$ converges in $L^p$ as $R \to \infty$ if and only if there exists a constant $K < \infty$ such that
$$\sup_{R > 0} \|S_R\|_{L^p \to L^p} \le K.$$
Furthermore, if this holds, then for the same constant $K$ we have
$$\sup_{h \in C^\infty,\, h \ne 0} \frac{\|A(h)\|_{L^p}}{\|h\|_{L^p}} \le K,$$
and then $A$ extends to a bounded operator $\widetilde{A}$ from $L^p(\mathbb{T}^n)$ to itself; moreover, for every $f \in L^p(\mathbb{T}^n)$ we have that $S_R(f) \to \widetilde{A}(f)$ in $L^p$ as $R \to \infty$.
