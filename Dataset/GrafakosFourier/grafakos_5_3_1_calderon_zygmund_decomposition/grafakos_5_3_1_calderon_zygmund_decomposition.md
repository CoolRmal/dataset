# L. Grafakos, *Classical Fourier Analysis*, Theorem 5.3.1 (the Calderón–Zygmund decomposition)

- **Source:** L. Grafakos, *Classical Fourier Analysis*
- **Domain:** Fourier analysis
- **Lean declaration:** `Dataset.GrafakosFourier.grafakos_5_3_1_calderon_zygmund_decomposition` ([grafakos_5_3_1_calderon_zygmund_decomposition.lean](grafakos_5_3_1_calderon_zygmund_decomposition.lean))
- **Criteria:** [grafakos_5_3_1_calderon_zygmund_decomposition.criteria.md](grafakos_5_3_1_calderon_zygmund_decomposition.criteria.md)
- **Context:** [grafakos_5_3_1_calderon_zygmund_decomposition.context.md](grafakos_5_3_1_calderon_zygmund_decomposition.context.md)

## Statement

**Theorem 5.3.1.** Let $f \in L^1(\mathbb{R}^n)$ and $\alpha > 0$. Then there exist functions $g$ and $b$ on $\mathbb{R}^n$ such that

1. $f = g + b$;
2. $\|g\|_{L^1} \le \|f\|_{L^1}$ and $\|g\|_{L^\infty} \le 2^n \alpha$;
3. $b = \sum_j b_j$ where each $b_j$ is supported in a dyadic cube $Q_j$, the cubes are disjoint, $\displaystyle \int_{Q_j} b_j(x)\,dx = 0$, $\|b_j\|_{L^1} \le 2^{n+1}\alpha |Q_j|$, and $\displaystyle \sum_j |Q_j| \le \alpha^{-1}\|f\|_{L^1}$.
