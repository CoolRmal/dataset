# Context: bogachev_gaussian_2_4_5_cameron_martin_dichotomy

**Statement:** [bogachev_gaussian_2_4_5_cameron_martin_dichotomy.md](bogachev_gaussian_2_4_5_cameron_martin_dichotomy.md) · **Criteria:** [bogachev_gaussian_2_4_5_cameron_martin_dichotomy.criteria.md](bogachev_gaussian_2_4_5_cameron_martin_dichotomy.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation

$|h|_{H(\gamma)} = \sup\{f(h) : f \in X^*,\ R_\gamma(f)(f) \le 1\}$ is the Cameron–Martin norm, **allowed to be $+\infty$**; the constraint is on the *variance* of $f$, so the mean is subtracted. $\gamma_h = \gamma(\cdot - h)$ is $\gamma$ shifted *by* $h$. $\sim$ is mutual absolute continuity, $\perp$ mutual singularity.

$R_\gamma$ is the covariance operator, $R_\gamma(f)(g)=\int(f-a_\gamma(f))(g-a_\gamma(g))\,d\gamma$, so $X \cap R_\gamma(X^*)$ is the set of $h \in X$ representing $R_\gamma(f)$ for some $f$.
