# V. I. Bogachev, *Gaussian Measures*, Example 4.5.8 (concentration of a measurable seminorm)

- **Source:** V. I. Bogachev, *Gaussian Measures*
- **Domain:** Measure theory
- **Lean declaration:** `Dataset.BogachevGaussian.bogachev_gaussian_4_5_8_seminorm_concentration` ([bogachev_gaussian_4_5_8_seminorm_concentration.lean](bogachev_gaussian_4_5_8_seminorm_concentration.lean))
- **Criteria:** [bogachev_gaussian_4_5_8_seminorm_concentration.criteria.md](bogachev_gaussian_4_5_8_seminorm_concentration.criteria.md)
- **Context:** [bogachev_gaussian_4_5_8_seminorm_concentration.context.md](bogachev_gaussian_4_5_8_seminorm_concentration.context.md)

## Statement

**Example 4.5.8.** Let $f$ be a $\gamma$-measurable seminorm on $X$. Then it satisfies condition (4.5.4). Put

$$\chi(f) := \sup\{f(h) : |h|_{H(\gamma)} \le 1\}, \qquad \mathbb{E}f := \int f\,d\gamma.$$

Then one has

$$\gamma\{x : |f(x) - \mathbb{E}f| > t\} \le 2\exp\left(-\frac{2}{\pi^2\chi(f)^2}t^2\right).$$

**Notation.** A Gaussian measure on a locally convex space $X$ is a Borel probability measure $\gamma$ all of whose one-dimensional projections $f_{\#}\gamma$, $f \in X^*$, are Gaussian measures on the real line. Write $a_\gamma(f) = \int_X f\,d\gamma$ and $R_\gamma(f)(f) = \int_X (f-a_\gamma(f))^2\,d\gamma$. **Definition 2.4.1.** The *Cameron–Martin space* of $\gamma$ is $H(\gamma) = \{h \in X : |h|_{H(\gamma)} < \infty\}$, where $$|h|_{H(\gamma)} = \sup\{f(h) : f \in X^*,\ R_\gamma(f)(f) \le 1\}.$$ For $h \in X$ we write $\gamma_h = \gamma(\,\cdot - h)$ for the shift of $\gamma$ by $h$; $\mu \sim \nu$ means that $\mu$ and $\nu$ are equivalent (mutually absolutely continuous) and $\mu \perp \nu$ that they are mutually singular.
