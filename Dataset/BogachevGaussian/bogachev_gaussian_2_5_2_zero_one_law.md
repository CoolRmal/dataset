# V. I. Bogachev, *Gaussian Measures*, Theorem 2.5.2 (the Gaussian zero–one law)

- **Source:** V. I. Bogachev, *Gaussian Measures*
- **Domain:** Measure theory
- **Lean declaration:** `Dataset.BogachevGaussian.bogachev_gaussian_2_5_2_zero_one_law` ([bogachev_gaussian_2_5_2_zero_one_law.lean](bogachev_gaussian_2_5_2_zero_one_law.lean))
- **Criteria:** [bogachev_gaussian_2_5_2_zero_one_law.criteria.md](bogachev_gaussian_2_5_2_zero_one_law.criteria.md)
- **Context:** [bogachev_gaussian_2_5_2_zero_one_law.context.md](bogachev_gaussian_2_5_2_zero_one_law.context.md)

## Statement

**Theorem 2.5.2.** Let $\gamma$ be a Gaussian measure on a locally convex space $X$ such that $R_\gamma(X^*) \subset X$. Suppose that a set $A \in \mathcal{E}(X)_\gamma$ satisfies the condition

$$\gamma(A + h) = \gamma(A), \qquad \forall h \in R_\gamma(X^*).$$

Then either $\gamma(A) = 1$ or $\gamma(A) = 0$. In addition, if $f$ is a $\gamma$-measurable function such that for every $h \in R_\gamma(X^*)$ one has

$$f(x+h) = f(x) \quad \gamma\text{-a.e.},$$

then $f$ coincides a.e. with a constant.

**Notation.** A Gaussian measure on a locally convex space $X$ is a Borel probability measure $\gamma$ all of whose one-dimensional projections $f_{\#}\gamma$, $f \in X^*$, are Gaussian measures on the real line. Write $a_\gamma(f) = \int_X f\,d\gamma$ and $R_\gamma(f)(f) = \int_X (f-a_\gamma(f))^2\,d\gamma$. **Definition 2.4.1.** The *Cameron–Martin space* of $\gamma$ is $H(\gamma) = \{h \in X : |h|_{H(\gamma)} < \infty\}$, where $$|h|_{H(\gamma)} = \sup\{f(h) : f \in X^*,\ R_\gamma(f)(f) \le 1\}.$$ For $h \in X$ we write $\gamma_h = \gamma(\,\cdot - h)$ for the shift of $\gamma$ by $h$; $\mu \sim \nu$ means that $\mu$ and $\nu$ are equivalent (mutually absolutely continuous) and $\mu \perp \nu$ that they are mutually singular. Under the hypothesis $R_\gamma(X^*) \subset X$ one has $H(\gamma) = R_\gamma(X^*)$, so the shifts in the statement are exactly the shifts by Cameron–Martin vectors.
