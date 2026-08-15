# Context: bogachev_gaussian_2_8_10_anderson_inequality

**Statement:** [bogachev_gaussian_2_8_10_anderson_inequality.md](bogachev_gaussian_2_8_10_anderson_inequality.md) · **Criteria:** [bogachev_gaussian_2_8_10_anderson_inequality.criteria.md](bogachev_gaussian_2_8_10_anderson_inequality.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Absolutely convex sets and Anderson's inequality

**"Gaussian measure" on a locally convex space $X$** means a Borel probability measure $\gamma$ such
that the law $f_{\#}\gamma$ of every continuous linear functional $f \in X^*$ is a Gaussian measure on
the real line. Degenerate cases are included: a Dirac mass is Gaussian with variance $0$, so
$\gamma$ need not have a density, and $X$ may be finite-dimensional. **Centered** means every such
$f_{\#}\gamma$ has mean $0$, equivalently the mean vector $\int_X x \, d\gamma(x)$ vanishes; a Gaussian
measure always has moments of all orders (Fernique's theorem), so this integral exists.

**$a_\gamma$ and $R_\gamma$.** $a_\gamma(f) = \int_X f \, d\gamma$ is the mean of the functional $f$, and
$R_\gamma(f)(f) = \int_X (f - a_\gamma(f))^2 \, d\gamma$ is its **variance** — the mean is subtracted.
$R_\gamma$ is the covariance operator, viewed as a map $X^* \to (X^*)'$.

**Absolutely convex** means convex **and** balanced: $\alpha A \subseteq A$ whenever $|\alpha| \le 1$
(for real scalars this includes $\alpha = -1$, so $A$ is symmetric about the origin, and $0 \in A$
whenever $A \ne \emptyset$). Both halves are needed. Convexity alone fails — a half-line in
$\mathbb{R}$ gains measure when translated towards the bulk. Symmetry alone fails — a symmetric
annulus in the plane can gain measure under a translation that moves it onto the peak of the density.

**$A + a$** is the translate $\{x + a : x \in A\}$, and $A + ta$ the translate by the scaled vector.
The measurability caveats in the printed statement ("$A + a \in \mathcal{E}(X)_\gamma$") are there
because in a general locally convex space the translate of a $\gamma$-measurable set is again
$\gamma$-measurable only under mild conditions; on a Borel space translation is a homeomorphism and the
caveat is automatic.

**What is asserted.** Two inequalities. First, $\gamma(A+a) \le \gamma(A)$: among all translates, the
untranslated set has the largest measure. Second, the monotone refinement
$\gamma(A+a) \le \gamma(A+ta)$ for every $t \in [0,1]$: the measure decreases along the whole segment
from $A$ to $A+a$. The second is strictly stronger and is what applications use; the closed interval
includes both endpoints.

**Centredness is essential.** For a Gaussian with non-zero mean the inequality is false: translating
$A$ by minus the mean centres it on the bulk of the measure and increases its mass.
