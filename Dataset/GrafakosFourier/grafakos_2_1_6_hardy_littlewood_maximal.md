# L. Grafakos, *Classical Fourier Analysis*, Theorem 2.1.6 (the Hardy–Littlewood maximal theorem)

- **Source:** L. Grafakos, *Classical Fourier Analysis*
- **Domain:** Fourier analysis
- **Lean declaration:** `Dataset.GrafakosFourier.grafakos_2_1_6_hardy_littlewood_maximal` ([grafakos_2_1_6_hardy_littlewood_maximal.lean](grafakos_2_1_6_hardy_littlewood_maximal.lean))
- **Criteria:** [grafakos_2_1_6_hardy_littlewood_maximal.criteria.md](grafakos_2_1_6_hardy_littlewood_maximal.criteria.md)

## Statement

**Theorem 2.1.6.** The uncentered and centered Hardy–Littlewood maximal operators $M$ and $M^c$ map $L^1(\mathbb{R}^n)$ to $L^{1,\infty}(\mathbb{R}^n)$ with constant at most $3^n$ and also $L^p(\mathbb{R}^n)$ to $L^p(\mathbb{R}^n)$ for $1 < p < \infty$ with constant at most $3^{n/p} p (p-1)^{-1}$. For any $f \in L^1(\mathbb{R}^n)$ we also have
$$\left|\{M(f) > \alpha\}\right| \le \frac{3^n}{\alpha} \int_{\{M(f) > \alpha\}} |f(y)| \, dy.$$
