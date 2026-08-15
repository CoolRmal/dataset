# Context: niven_5_5_squaring_the_circle_impossible

**Statement:** [niven_5_5_squaring_the_circle_impossible.md](niven_5_5_squaring_the_circle_impossible.md) · **Criteria:** [niven_5_5_squaring_the_circle_impossible.criteria.md](niven_5_5_squaring_the_circle_impossible.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Squaring the circle

**Constructible lengths.** A length is constructible when it can be obtained from a unit segment by
straightedge and compass. Algebraically these are exactly the numbers reachable from $\mathbb{Q}$ by the
four field operations together with square roots of **non-negative** quantities already constructed. The
square-root closure is restricted to non-negative arguments — this is what keeps the class inside
$\mathbb{R}$ and is not a technicality.

**Degree of an algebraic number** is the degree of its minimal polynomial over $\mathbb{Q}$, equivalently
the dimension of $\mathbb{Q}(x)$ as a $\mathbb{Q}$-vector space. Degree $1$ means rational.

**The Theorem on Geometric Constructions** says every constructible length is algebraic **and** its degree
is a power of $2$ (with $2^0 = 1$ allowed). The three classical impossibility results are corollaries, each
about a *specific* number: $\sqrt[3]{2}$ has degree $3$; $\sqrt\pi$ is not algebraic at all; $\cos 20°$ has
degree $3$.

**The number is $\sqrt\pi$, not $\pi$**: squaring the circle means constructing a square of the same
area as the unit circle, i.e. a side of length $\sqrt\pi$.

**The transcendence of $\pi$ over $\mathbb{Q}$ is a hypothesis**, exactly as in the book ("granted
that $\pi$ is transcendental"). Transcendence is over the **rationals**; over $\mathbb{R}$ nothing is
transcendental. Since $\pi$ is transcendental, so is $\sqrt\pi$, so it is not algebraic of any degree,
let alone of degree a power of $2$.
