# Context: bogachev_gaussian_4_3_1_isoperimetric_inequality

**Statement:** [bogachev_gaussian_4_3_1_isoperimetric_inequality.md](bogachev_gaussian_4_3_1_isoperimetric_inequality.md) · **Criteria:** [bogachev_gaussian_4_3_1_isoperimetric_inequality.criteria.md](bogachev_gaussian_4_3_1_isoperimetric_inequality.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## $\gamma_n$, $\Phi^{-1}$, and the enlargement $A + rU$

**$\gamma_n$, $\Phi$, $\Phi^{-1}$.** As in 4.2.1: $\gamma_n$ is the standard Gaussian measure on
$\mathbb{R}^n$, $\Phi(x) = \gamma_1((-\infty,x])$ is the standard normal distribution function, and
$\Phi^{-1}$ is its inverse extended to $[0,1]$ by $\Phi^{-1}(0) = -\infty$, $\Phi^{-1}(1) = +\infty$.
The infinite values are load-bearing: a set of measure $0$ or $1$ is a legitimate input, and the
inequality has to say something sensible there.

**$U$ and $A + rU$.** $U$ is the *closed* unit ball of $\mathbb{R}^n$ centred at the origin, in the
Euclidean metric. $A + rU = \{a + ru : a \in A, u \in U\}$ is the Minkowski sum — the union of the
closed $r$-balls centred at points of $A$. When $A$ is closed this is exactly the closed
$r$-neighbourhood $\{z : \operatorname{dist}(z,A) \le r\}$; for a general $A$ it can be strictly
smaller than that neighbourhood, so the two readings are not interchangeable and the Minkowski sum is
the printed one.

**$A$ is arbitrary measurable.** No convexity, no closedness, no symmetry. This is what distinguishes
the isoperimetric inequality from Ehrhard's inequality, and it is why the theorem is sharp: half-spaces
are the extremal sets, and for a half-space equality holds.

**The gain is exactly $r$.** The right-hand side is $\Phi^{-1}(\gamma_n(A)) + r$ with the literal
radius, no constant and no dimensional factor; the dimension $n$ does not appear in the inequality at
all.
