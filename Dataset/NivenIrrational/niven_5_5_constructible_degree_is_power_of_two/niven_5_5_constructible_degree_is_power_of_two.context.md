# Context: niven_5_5_constructible_degree_is_power_of_two

**Statement:** [niven_5_5_constructible_degree_is_power_of_two.md](niven_5_5_constructible_degree_is_power_of_two.md) · **Criteria:** [niven_5_5_constructible_degree_is_power_of_two.criteria.md](niven_5_5_constructible_degree_is_power_of_two.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Constructible numbers have degree a power of two

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

**Two conclusions.** The constructible length is algebraic over $\mathbb{Q}$, **and** its degree is $2^k$
for some $k$. The exponent depends on the number and is chosen after it.

**Degree $1$ is allowed** ($k = 0$): every rational is constructible.

**The class of constructible numbers is closed under the field operations and non-negative square roots**,
and contains the rationals; that closure description is what the theorem's hypothesis means.
