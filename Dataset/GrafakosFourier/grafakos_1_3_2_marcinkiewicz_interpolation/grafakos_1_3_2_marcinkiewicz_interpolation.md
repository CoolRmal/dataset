# L. Grafakos, *Classical Fourier Analysis*, Theorem 1.3.2 (the Marcinkiewicz interpolation theorem)

- **Source:** L. Grafakos, *Classical Fourier Analysis*
- **Domain:** Fourier analysis
- **Lean declaration:** `Dataset.GrafakosFourier.grafakos_1_3_2_marcinkiewicz_interpolation` ([grafakos_1_3_2_marcinkiewicz_interpolation.lean](grafakos_1_3_2_marcinkiewicz_interpolation.lean))
- **Criteria:** [grafakos_1_3_2_marcinkiewicz_interpolation.criteria.md](grafakos_1_3_2_marcinkiewicz_interpolation.criteria.md)
- **Context:** [grafakos_1_3_2_marcinkiewicz_interpolation.context.md](grafakos_1_3_2_marcinkiewicz_interpolation.context.md)

## Statement

**Theorem 1.3.2.** Let $(X,\mu)$ be a $\sigma$-finite measure space, let $(Y,\nu)$ be another measure space, and let $0 < p_0 < p_1 \le \infty$. Let $T$ be a sublinear operator defined on
$$L^{p_0}(X) + L^{p_1}(X) = \{f_0 + f_1 : f_j \in L^{p_j}(X),\ j = 0, 1\}$$
and taking values in the space of measurable functions on $Y$. Assume that there exist $A_0, A_1 < \infty$ such that
$$\|T(f)\|_{L^{p_0,\infty}(Y)} \le A_0 \|f\|_{L^{p_0}(X)} \quad \text{for all } f \in L^{p_0}(X),$$
and
$$\|T(f)\|_{L^{p_1,\infty}(Y)} \le A_1 \|f\|_{L^{p_1}(X)} \quad \text{for all } f \in L^{p_1}(X).$$
Then for all $p_0 < p < p_1$ and for all $f$ in $L^p(X)$ we have the estimate
$$\|T(f)\|_{L^p(Y)} \le A \|f\|_{L^p(X)},$$
where
$$A = 2\left[\frac{p}{p - p_0} + \frac{p}{p_1 - p}\right]^{1/p} A_0^{\frac{p_0}{p}\frac{p_1 - p}{p_1 - p_0}} A_1^{\frac{p_1}{p}\frac{p - p_0}{p_1 - p_0}}.$$
