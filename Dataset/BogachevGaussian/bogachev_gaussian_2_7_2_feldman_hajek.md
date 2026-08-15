# V. I. Bogachev, *Gaussian Measures*, Theorem 2.7.2 (the Hájek–Feldman dichotomy)

- **Source:** V. I. Bogachev, *Gaussian Measures*
- **Domain:** Measure theory
- **Lean declaration:** `Dataset.BogachevGaussian.bogachev_gaussian_2_7_2_feldman_hajek` ([bogachev_gaussian_2_7_2_feldman_hajek.lean](bogachev_gaussian_2_7_2_feldman_hajek.lean))
- **Criteria:** [bogachev_gaussian_2_7_2_feldman_hajek.criteria.md](bogachev_gaussian_2_7_2_feldman_hajek.criteria.md)
- **Context:** [bogachev_gaussian_2_7_2_feldman_hajek.context.md](bogachev_gaussian_2_7_2_feldman_hajek.context.md)

## Statement

**Theorem 2.7.2.** Any two Gaussian measures on one and the same locally convex space are either equivalent or mutually singular.

**Notation.** A Gaussian measure on a locally convex space $X$ is a Borel probability measure $\gamma$ all of whose one-dimensional projections $f_{\#}\gamma$, $f \in X^*$, are Gaussian measures on the real line. Write $a_\gamma(f) = \int_X f\,d\gamma$ and $R_\gamma(f)(f) = \int_X (f-a_\gamma(f))^2\,d\gamma$. **Definition 2.4.1.** The *Cameron–Martin space* of $\gamma$ is $H(\gamma) = \{h \in X : |h|_{H(\gamma)} < \infty\}$, where $$|h|_{H(\gamma)} = \sup\{f(h) : f \in X^*,\ R_\gamma(f)(f) \le 1\}.$$ For $h \in X$ we write $\gamma_h = \gamma(\,\cdot - h)$ for the shift of $\gamma$ by $h$; $\mu \sim \nu$ means that $\mu$ and $\nu$ are equivalent (mutually absolutely continuous) and $\mu \perp \nu$ that they are mutually singular.
