# Context: kallenberg_23_6_functional_central_limit

**Statement:** [kallenberg_23_6_functional_central_limit.md](kallenberg_23_6_functional_central_limit.md) · **Criteria:** [kallenberg_23_6_functional_central_limit.criteria.md](kallenberg_23_6_functional_central_limit.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Donsker's invariance principle

**The interpolated partial-sum process.** $X^n_t = n^{-1/2}\bigl[\sum_{k\le nt}\xi_k + (nt-[nt])\xi_{[nt]+1}\bigr]$
where $[\cdot]$ is the integer part. The second term linearly interpolates between the jumps, which is
exactly what makes $X^n$ a **continuous** path, so that $X^n$ is a random element of
$C(\mathbb{R}_+,\mathbb{R}^d)$ rather than of a Skorokhod space.

**"Covariances $\delta_{ij}$"** means the covariance matrix of $\xi_1$ is the identity: each coordinate
has variance $1$ and distinct coordinates are uncorrelated. Together with mean $0$ this is the
standardisation.

**i.i.d.** is mutual independence of the whole sequence — not pairwise — together with a common law.

**$d$-dimensional Brownian motion** has independent one-dimensional Brownian coordinates.

**Convergence in distribution on $C(\mathbb{R}_+,\mathbb{R}^d)$** is weak convergence of the laws on
that path space with its topology of uniform convergence on compacts; the $X^n$ and $B$ need not live on
a common probability space.
