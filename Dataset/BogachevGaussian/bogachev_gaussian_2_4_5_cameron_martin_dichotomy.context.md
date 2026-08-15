# Context: bogachev_gaussian_2_4_5_cameron_martin_dichotomy

**Statement:** [bogachev_gaussian_2_4_5_cameron_martin_dichotomy.md](bogachev_gaussian_2_4_5_cameron_martin_dichotomy.md) · **Criteria:** [bogachev_gaussian_2_4_5_cameron_martin_dichotomy.criteria.md](bogachev_gaussian_2_4_5_cameron_martin_dichotomy.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Gaussian measures on locally convex spaces, and the Cameron–Martin norm

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

**What the theorem says.** The shift $\gamma_h$ is either equivalent to $\gamma$ or mutually singular
with it, and which of the two happens is decided *exactly* by whether $|h|_{H(\gamma)}$ is finite. The
final display (2.4.3) records the consequence: the Cameron–Martin space is precisely the set of
admissible shifts, and also precisely $X \cap R_\gamma(X^*)$.

**The infinite case is not a technicality.** Part (i) is a statement *about* the vectors of infinite
Cameron–Martin norm; if the norm is read as a real number, those vectors disappear from the statement
and part (i) says nothing.
