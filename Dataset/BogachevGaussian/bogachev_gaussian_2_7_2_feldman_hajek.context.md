# Context: bogachev_gaussian_2_7_2_feldman_hajek

**Statement:** [bogachev_gaussian_2_7_2_feldman_hajek.md](bogachev_gaussian_2_7_2_feldman_hajek.md) · **Criteria:** [bogachev_gaussian_2_7_2_feldman_hajek.criteria.md](bogachev_gaussian_2_7_2_feldman_hajek.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The Hájek–Feldman dichotomy

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

**What the theorem asserts.** For *any* two Gaussian measures on the same locally convex space, the
two possibilities — equivalence and mutual singularity — are exhaustive. There is no intermediate
case: it can never happen that $\mu \ll \nu$ without $\nu \ll \mu$, and it can never happen that the
measures are neither equivalent nor mutually singular. That exhaustiveness is the whole content.

**No further hypotheses.** The measures need not be centred, need not share a covariance, need not be
non-degenerate, and the space need not be separable or finite-dimensional. Each such addition narrows
the theorem; assuming a common covariance in particular reduces it to the Cameron–Martin criterion of
Theorem 2.4.5.

**Where the interest lies.** In finite dimensions the dichotomy is elementary. The theorem is about
infinite-dimensional spaces, where for instance two Wiener measures with different variance parameters
are mutually singular.
