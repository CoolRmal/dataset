# V. I. Bogachev, *Gaussian Measures*, Theorem 2.8.10 (Anderson's inequality)

- **Source:** V. I. Bogachev, *Gaussian Measures*
- **Domain:** Measure theory
- **Lean declaration:** `Dataset.BogachevGaussian.bogachev_gaussian_2_8_10_anderson_inequality` ([bogachev_gaussian_2_8_10_anderson_inequality.lean](bogachev_gaussian_2_8_10_anderson_inequality.lean))
- **Criteria:** [bogachev_gaussian_2_8_10_anderson_inequality.criteria.md](bogachev_gaussian_2_8_10_anderson_inequality.criteria.md)
- **Context:** [bogachev_gaussian_2_8_10_anderson_inequality.context.md](bogachev_gaussian_2_8_10_anderson_inequality.context.md)

## Statement

**Theorem 2.8.10.** Let $\gamma$ be a centered Gaussian measure on a locally convex space $X$ and let $A \in \mathcal{E}(X)_\gamma$ be an absolutely convex set. Then, for any $a \in X$ such that $A + a \in \mathcal{E}(X)_\gamma$, the following inequality holds true:

$$\gamma(A+a) \le \gamma(A).$$

More generally, if $A + ta \in \mathcal{E}(X)_\gamma$ for all $t \in [0,1]$, then

$$\gamma(A+a) \le \gamma(A+ta), \qquad \forall t \in [0,1].$$

**Notation.** A Gaussian measure on a locally convex space $X$ is a Borel probability measure $\gamma$ all of whose one-dimensional projections $f_{\#}\gamma$, $f \in X^*$, are Gaussian measures on the real line. Write $a_\gamma(f) = \int_X f\,d\gamma$ and $R_\gamma(f)(f) = \int_X (f-a_\gamma(f))^2\,d\gamma$. **Definition 2.4.1.** The *Cameron–Martin space* of $\gamma$ is $H(\gamma) = \{h \in X : |h|_{H(\gamma)} < \infty\}$, where $$|h|_{H(\gamma)} = \sup\{f(h) : f \in X^*,\ R_\gamma(f)(f) \le 1\}.$$ For $h \in X$ we write $\gamma_h = \gamma(\,\cdot - h)$ for the shift of $\gamma$ by $h$; $\mu \sim \nu$ means that $\mu$ and $\nu$ are equivalent (mutually absolutely continuous) and $\mu \perp \nu$ that they are mutually singular. A set $A$ is *absolutely convex* if it is convex and balanced, i.e. $\alpha A \subset A$ whenever $|\alpha| \le 1$.
