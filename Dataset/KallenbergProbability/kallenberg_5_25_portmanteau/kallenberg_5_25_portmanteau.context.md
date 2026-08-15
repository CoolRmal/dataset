# Context: kallenberg_5_25_portmanteau

**Statement:** [kallenberg_5_25_portmanteau.md](kallenberg_5_25_portmanteau.md) · **Criteria:** [kallenberg_5_25_portmanteau.criteria.md](kallenberg_5_25_portmanteau.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Weak convergence and $\xi$-continuity sets

**Convergence in distribution** $\xi_n \to \xi$ is weak convergence of the *laws*: $\mathbb{E}f(\xi_n) \to
\mathbb{E}f(\xi)$ for every bounded continuous $f$ on $S$. The random elements may live on different
probability spaces; only their laws matter.

**The directions of the two inequalities.** Open sets get a $\liminf$ lower bound
($\liminf P\{\xi_n \in G\} \ge P\{\xi \in G\}$) and closed sets a $\limsup$ upper bound
($\limsup P\{\xi_n \in F\} \le P\{\xi \in F\}$). Swapping them, or using the same kind of limit for both,
gives false statements. The two are equivalent by complementation.

**$\xi$-continuity sets.** $\mathcal{S}_\xi$ is the class of Borel $B$ with $P\{\xi \in \partial B\} = 0$,
where $\partial B$ is the boundary of $B$ **in $S$**. Condition (iv) asserts genuine convergence of the
probabilities, but only for these sets — for a general Borel set it is false.

**All four conditions are equivalent**, in one statement.
