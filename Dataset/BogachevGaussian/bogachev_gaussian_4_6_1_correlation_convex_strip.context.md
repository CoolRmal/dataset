# Context: bogachev_gaussian_4_6_1_correlation_convex_strip

**Statement:** [bogachev_gaussian_4_6_1_correlation_convex_strip.md](bogachev_gaussian_4_6_1_correlation_convex_strip.md) · **Criteria:** [bogachev_gaussian_4_6_1_correlation_convex_strip.criteria.md](bogachev_gaussian_4_6_1_correlation_convex_strip.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Absolutely convex sets, strips, and the correlation inequality

**Centred Gaussian on $\mathbb{R}^n$.** A Borel probability measure every linear functional of which
has a centred Gaussian law; degenerate covariances are allowed.

**Absolutely convex** means convex **and** balanced ($\alpha A \subseteq A$ for $|\alpha| \le 1$), so in
particular symmetric about the origin. Both halves are used.

**A strip** is a set of the form $\Pi = \{x : |f(x)| \le c\}$ with $f$ a linear function on
$\mathbb{R}^n$ and $c$ a real constant. It is the region between two parallel hyperplanes, symmetric
about the origin. Note that $c$ is not assumed positive: for $c < 0$ the strip is empty and the
inequality is trivially true, and for $c = 0$ it is a hyperplane. On $\mathbb{R}^n$ every linear
functional is continuous, so the strip is closed and in particular measurable.

**What the inequality says.** $\gamma(A \cap \Pi) \ge \gamma(A)\gamma(\Pi)$: the two events are
*positively correlated*. This is the case of the Gaussian correlation conjecture that Bogachev proves —
one absolutely convex set and one *strip*. The general two-convex-sets version is a much deeper
statement and is not what is claimed here.

**The direction.** The intersection is on the large side. Reversing the inequality gives a false
statement.
