# V. I. Bogachev, *Gaussian Measures*, Theorem 2.4.5 (the Cameron–Martin dichotomy)

- **Source:** V. I. Bogachev, *Gaussian Measures*
- **Domain:** Measure theory
- **Lean declaration:** `Dataset.BogachevGaussian.bogachev_gaussian_2_4_5_cameron_martin_dichotomy` ([bogachev_gaussian_2_4_5_cameron_martin_dichotomy.lean](bogachev_gaussian_2_4_5_cameron_martin_dichotomy.lean))
- **Criteria:** [bogachev_gaussian_2_4_5_cameron_martin_dichotomy.criteria.md](bogachev_gaussian_2_4_5_cameron_martin_dichotomy.criteria.md)

## Statement

**Theorem 2.4.5.** Let $\gamma$ be a Gaussian measure on a locally convex space $X$.

(i) Let $h \in X$ be a vector such that

$$|h|_{H(\gamma)} = \sup\{f(h) : f \in X^*,\ R_\gamma(f)(f) \le 1\} = \infty;$$

then the measures $\gamma_h$ and $\gamma$ are mutually singular;

(ii) if $|h|_{H(\gamma)} < \infty$, then the measures $\gamma$ and $\gamma_h$ are equivalent.

In particular,

$$H(\gamma) = \{h \in X : \gamma_h \sim \gamma\} = \{h \in X : |h|_{H(\gamma)} < \infty\} = X \cap R_\gamma(X^*). \tag{2.4.3}$$

**Notation.** A Gaussian measure on a locally convex space $X$ is a Borel probability measure $\gamma$ all of whose one-dimensional projections $f_{\#}\gamma$, $f \in X^*$, are Gaussian measures on the real line. Write $a_\gamma(f) = \int_X f\,d\gamma$ and $R_\gamma(f)(f) = \int_X (f-a_\gamma(f))^2\,d\gamma$. **Definition 2.4.1.** The *Cameron–Martin space* of $\gamma$ is $H(\gamma) = \{h \in X : |h|_{H(\gamma)} < \infty\}$, where $$|h|_{H(\gamma)} = \sup\{f(h) : f \in X^*,\ R_\gamma(f)(f) \le 1\}.$$ For $h \in X$ we write $\gamma_h = \gamma(\,\cdot - h)$ for the shift of $\gamma$ by $h$; $\mu \sim \nu$ means that $\mu$ and $\nu$ are equivalent (mutually absolutely continuous) and $\mu \perp \nu$ that they are mutually singular.
