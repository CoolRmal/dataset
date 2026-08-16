# Context: bogachev_gaussian_2_5_2_zero_one_law

**Statement:** [bogachev_gaussian_2_5_2_zero_one_law.md](bogachev_gaussian_2_5_2_zero_one_law.md) · **Criteria:** [bogachev_gaussian_2_5_2_zero_one_law.criteria.md](bogachev_gaussian_2_5_2_zero_one_law.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation

$|h|_{H(\gamma)} = \sup\{f(h) : f \in X^*,\ R_\gamma(f)(f) \le 1\}$ is the Cameron–Martin norm, **allowed to be $+\infty$**; the constraint is on the *variance* of $f$, so the mean is subtracted. $\gamma_h = \gamma(\cdot - h)$ is $\gamma$ shifted *by* $h$. $\sim$ is mutual absolute continuity, $\perp$ mutual singularity.

$\mathcal{E}(X)_\gamma$ is the $\gamma$-completion of the cylindrical $\sigma$-algebra. Invariance is of the **measure** of the translate, not of the set. In the function half the invariance is a.e. for each fixed $h$, and the conclusion picks the constant **before** the almost-everywhere quantifier.
