# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*, Lemma 1.1.7 (whole-space maximum principle and a Liouville theorem)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovSobolev.krylov_sobolev_1_1_7_whole_space_maximum_principle` ([krylov_sobolev_1_1_7_whole_space_maximum_principle.lean](krylov_sobolev_1_1_7_whole_space_maximum_principle.lean))
- **Criteria:** [krylov_sobolev_1_1_7_whole_space_maximum_principle.criteria.md](krylov_sobolev_1_1_7_whole_space_maximum_principle.criteria.md)

## Statement

**Lemma 1.1.7.** Let $\lambda > 0$ and let $u$ be a bounded from above twice continuously differentiable function on $\mathbb{R}^d$ satisfying

$$\Delta u - \lambda u \ge 0$$

in $\mathbb{R}^d$. Then $u \le 0$. In particular, if $u$ is bounded and $\Delta u - \lambda u = 0$, then $\pm u \le 0$, so that $u \equiv 0$.

**Notation.** $\Delta u = u_{x^1x^1} + \dots + u_{x^dx^d}$ is Laplace's operator. "Bounded from above" means $\sup_{\mathbb{R}^d} u < \infty$, and "bounded" means $\sup_{\mathbb{R}^d}|u| < \infty$. No decay of $u$ at infinity is assumed.
