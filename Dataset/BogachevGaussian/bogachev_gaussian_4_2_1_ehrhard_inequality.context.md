# Context: bogachev_gaussian_4_2_1_ehrhard_inequality

**Statement:** [bogachev_gaussian_4_2_1_ehrhard_inequality.md](bogachev_gaussian_4_2_1_ehrhard_inequality.md) · **Criteria:** [bogachev_gaussian_4_2_1_ehrhard_inequality.criteria.md](bogachev_gaussian_4_2_1_ehrhard_inequality.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## $\gamma_n$, $\Phi^{-1}$, and Minkowski combinations

**$\gamma_n$** is the *standard* Gaussian measure on $\mathbb{R}^n$: mean $0$, identity covariance,
density $(2\pi)^{-n/2}e^{-|x|^2/2}$ with respect to Lebesgue measure. The Euclidean structure is part of
the data.

**$\Phi$ and $\Phi^{-1}$.** $\Phi(x) = \gamma_1((-\infty,x])$ is the standard normal distribution
function, a strictly increasing bijection from $\mathbb{R}$ onto the open interval $(0,1)$. Its inverse
$\Phi^{-1}$ is therefore defined on $(0,1)$, and the statement extends it to the closed interval by the
conventions $\Phi^{-1}(0) = -\infty$ and $\Phi^{-1}(1) = +\infty$. **These two values are not
decoration**: sets of Gaussian measure $0$ and $1$ are exactly the extreme cases the inequality has to
cover, so $\Phi^{-1}$ is a function into $[-\infty,+\infty]$, not into $\mathbb{R}$.

**$\lambda A + (1-\lambda)B$** is the Minkowski combination
$\{\lambda x + (1-\lambda)y : x \in A,\ y \in B\}$ — the set of all weighted averages of a point of
$A$ with a point of $B$. It is not a union, not an intersection, and not the convex hull of
$A \cup B$. For convex $A = B$ it equals $A$.

**Emptiness.** The empty set is convex, and $\lambda\emptyset + (1-\lambda)B = \emptyset$. With
$\gamma_n(\emptyset) = 0$ and $\Phi^{-1}(0) = -\infty$, arithmetic in $[-\infty,+\infty]$ needs care at
the endpoints of the $\lambda$-range; the natural reading of the printed statement is that $A$ and $B$
are nonempty.

**Convexity is essential.** Whether the inequality holds for arbitrary measurable sets is an open
problem, which Bogachev records. A statement without convexity is a conjecture, not this theorem.

**The direction.** The quantile of the *combination* is the large side: applying $\Phi^{-1}\circ\gamma_n$
turns Minkowski combination into a concave operation.
