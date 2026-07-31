# L. Grafakos, *Classical Fourier Analysis*, Theorem 1.3.4 (the Riesz–Thorin interpolation theorem)

- **Source:** L. Grafakos, *Classical Fourier Analysis*
- **Domain:** Fourier analysis
- **Lean declaration:** `Dataset.GrafakosFourier.grafakos_1_3_4_riesz_thorin_interpolation` ([grafakos_1_3_4_riesz_thorin_interpolation.lean](grafakos_1_3_4_riesz_thorin_interpolation.lean))
- **Criteria:** [grafakos_1_3_4_riesz_thorin_interpolation.criteria.md](grafakos_1_3_4_riesz_thorin_interpolation.criteria.md)

## Statement

**Theorem 1.3.4.** Let $(X,\mu)$ and $(Y,\nu)$ be two $\sigma$-finite measure spaces. Let $T$ be a linear operator defined on the set of all finitely simple functions on $X$ and taking values in the set of measurable functions on $Y$. Let $1 \le p_0, p_1, q_0, q_1 \le \infty$ and assume that
$$\|T(f)\|_{L^{q_0}} \le M_0 \|f\|_{L^{p_0}} \quad \text{and} \quad \|T(f)\|_{L^{q_1}} \le M_1 \|f\|_{L^{p_1}}$$
for all finitely simple functions $f$ on $X$. Then for all $0 < \theta < 1$ we have
$$\|T(f)\|_{L^q} \le M_0^{1-\theta} M_1^{\theta} \|f\|_{L^p}$$
for all finitely simple functions $f$ on $X$, where
$$\frac{1}{p} = \frac{1-\theta}{p_0} + \frac{\theta}{p_1} \quad \text{and} \quad \frac{1}{q} = \frac{1-\theta}{q_0} + \frac{\theta}{q_1}.$$
Consequently, when $p < \infty$, by density, $T$ has a unique bounded extension from $L^p(X,\mu)$ to $L^q(Y,\nu)$ when $p$ and $q$ are as above.
