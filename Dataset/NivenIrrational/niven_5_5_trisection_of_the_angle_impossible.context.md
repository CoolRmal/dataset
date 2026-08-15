# Context: niven_5_5_trisection_of_the_angle_impossible

**Statement:** [niven_5_5_trisection_of_the_angle_impossible.md](niven_5_5_trisection_of_the_angle_impossible.md) · **Criteria:** [niven_5_5_trisection_of_the_angle_impossible.criteria.md](niven_5_5_trisection_of_the_angle_impossible.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Trisection of the angle

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

**One specific angle suffices.** To show trisection is impossible in general it is enough to exhibit one
angle that cannot be trisected; the book takes $60°$. Trisecting it means constructing a $20°$ angle,
equivalently the length $\cos 20°$.

**$20°$ in radians is $\pi/9$.** $\cos 20°$ satisfies $8y^3-6y-1=0$, irreducible over $\mathbb{Q}$, so
it has degree $3$ and is not constructible.

**The claim is about that one number**, not about all angles.
