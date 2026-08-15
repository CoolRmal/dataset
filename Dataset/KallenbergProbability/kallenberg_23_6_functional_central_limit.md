# O. Kallenberg, *Foundations of Modern Probability*, Theorem 23.6 (functional central limit theorem, Donsker)

- **Source:** O. Kallenberg, *Foundations of Modern Probability*
- **Domain:** Stochastic processes
- **Lean declaration:** `Dataset.KallenbergProbability.kallenberg_23_6_functional_central_limit` ([kallenberg_23_6_functional_central_limit.lean](kallenberg_23_6_functional_central_limit.lean))
- **Criteria:** [kallenberg_23_6_functional_central_limit.criteria.md](kallenberg_23_6_functional_central_limit.criteria.md)
- **Context:** [kallenberg_23_6_functional_central_limit.context.md](kallenberg_23_6_functional_central_limit.context.md)

## Statement

**Theorem 23.6 (functional central limit theorem, Donsker).** Let $\xi_1, \xi_2, \dots$ be i.i.d. random vectors in $\mathbb{R}^d$ with mean $0$ and covariances $\delta_{ij}$, form the continuous processes

$$X_t^n = n^{-1/2}\Big[\sum_{k \le nt} \xi_k + (nt - [nt])\,\xi_{[nt]+1}\Big], \qquad t \ge 0,\ n \in \mathbb{N},$$

and let $B$ be a Brownian motion in $\mathbb{R}^d$. Then $X^n \to B$ in distribution in $C_{\mathbb{R}_+, \mathbb{R}^d}$.

**$d$-dimensional Brownian motion.** A $d$-dimensional Brownian motion is a process $B = (B^1, \dots, B^d)$ in $\mathbb{R}^d$, where $B^1, \dots, B^d$ are independent, one-dimensional Brownian motions.
