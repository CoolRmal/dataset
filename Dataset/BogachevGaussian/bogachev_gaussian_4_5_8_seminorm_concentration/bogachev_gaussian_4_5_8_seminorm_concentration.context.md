# Context: bogachev_gaussian_4_5_8_seminorm_concentration

**Statement:** [bogachev_gaussian_4_5_8_seminorm_concentration.md](bogachev_gaussian_4_5_8_seminorm_concentration.md) · **Criteria:** [bogachev_gaussian_4_5_8_seminorm_concentration.criteria.md](bogachev_gaussian_4_5_8_seminorm_concentration.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Measurable seminorms, $\chi(f)$ and $\mathbb{E}f$

**"Gaussian measure" on a locally convex space $X$** means a Borel probability measure $\gamma$ such
that the law $f_{\#}\gamma$ of every continuous linear functional $f \in X^*$ is a Gaussian measure on
the real line. Degenerate cases are included: a Dirac mass is Gaussian with variance $0$, so
$\gamma$ need not have a density, and $X$ may be finite-dimensional. **Centered** means every such
$f_{\#}\gamma$ has mean $0$, equivalently the mean vector $\int_X x \, d\gamma(x)$ vanishes; a Gaussian
measure always has moments of all orders (Fernique's theorem), so this integral exists.

**$a_\gamma$ and $R_\gamma$.** $a_\gamma(f) = \int_X f \, d\gamma$ is the mean of the functional $f$, and
$R_\gamma(f)(f) = \int_X (f - a_\gamma(f))^2 \, d\gamma$ is its **variance** — the mean is subtracted.
$R_\gamma$ is the covariance operator, viewed as a map $X^* \to (X^*)'$.

**The Cameron–Martin norm and space.** For $h \in X$,
$$|h|_{H(\gamma)} = \sup\{f(h) : f \in X^*,\ R_\gamma(f)(f) \le 1\},$$
the supremum of the values $f(h)$ over functionals of variance at most $1$. This supremum is
**genuinely allowed to be $+\infty$** — in infinite dimensions it is infinite for all but a
"measure-zero worth" of $h$, and the infinite case is half of the content of the results that use it.
The Cameron–Martin space is $H(\gamma) = \{h : |h|_{H(\gamma)} < \infty\}$; it is a dense subspace of
the topological support of $\gamma$, but it is itself $\gamma$-null in infinite dimensions.

**$\gamma_h$, $\sim$ and $\perp$.** $\gamma_h = \gamma(\,\cdot - h)$ is $\gamma$ shifted *by* $h$: the
measure assigning to a set $A$ the value $\gamma(A - h)$, i.e. the image of $\gamma$ under
$x \mapsto x + h$. The sign matters for a non-centered $\gamma$. $\mu \sim \nu$ means the two measures
are *equivalent*: each is absolutely continuous with respect to the other (two-sided, not one-sided).
$\mu \perp \nu$ means they are *mutually singular*: the space splits into a set carrying all of $\mu$
and a complement carrying all of $\nu$.

**A $\gamma$-measurable seminorm** is a function $f \colon X \to [0,\infty)$ that is subadditive and
absolutely homogeneous ($f(\alpha x) = |\alpha| f(x)$) and measurable with respect to the
$\gamma$-completion. It is *not* assumed continuous — the archetype is a norm on a subspace of full
measure, e.g. the supremum norm on the Wiener space.

**$\chi(f)$ is a gauge against the Cameron–Martin unit ball**, not a norm of $f$:
$$\chi(f) = \sup\{f(h) : |h|_{H(\gamma)} \le 1\}.$$
It may be $+\infty$, in which case the stated bound is vacuous, so it belongs in $[0,\infty]$. It is
this quantity, and not $\mathbb{E}f$ or any norm of $f$ on $X$, that controls the Gaussian tail.

**$\mathbb{E}f = \int f \, d\gamma$** is the mean of the seminorm. Fernique's theorem guarantees that a
$\gamma$-measurable seminorm is integrable — indeed exponentially integrable — so this is a genuine
finite number.

**The conclusion.** A two-sided deviation bound: the $\gamma$-measure of $\{x : |f(x) - \mathbb{E}f| > t\}$
is at most $2\exp\bigl(-2t^2/(\pi^2\chi(f)^2)\bigr)$. The constants $2$, $2$ and $\pi^2$ are as printed.
The event is the *strict* inequality $> t$, and $t \ge 0$.

**"Condition (4.5.4)"** is the hypothesis of the general concentration theorem the example instantiates;
the assertion quoted here is the resulting bound, and the reference is context, not an extra clause.
