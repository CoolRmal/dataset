# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*, Lemma 1.1.1 (the $\mathcal{L}_2$ energy identity for $\lambda u - \Delta u = f$)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovSobolev.krylov_sobolev_1_1_1_energy_identity` ([krylov_sobolev_1_1_1_energy_identity.lean](krylov_sobolev_1_1_1_energy_identity.lean))
- **Criteria:** [krylov_sobolev_1_1_1_energy_identity.criteria.md](krylov_sobolev_1_1_1_energy_identity.criteria.md)

## Statement

**Lemma 1.1.1.** Let $u \in C_0^2$ be a solution of

$$\lambda u - \Delta u = f \tag{1}$$

in $\mathbb{R}^d$. Then

$$\lambda^2 \|u\|^2_{\mathcal{L}_2} + 2\lambda \sum_{j=1}^d \|u_{x^j}\|^2_{\mathcal{L}_2} + \sum_{j,k=1}^d \|u_{x^jx^k}\|^2_{\mathcal{L}_2} = \|f\|^2_{\mathcal{L}_2}. \tag{2}$$

**Notation.** Equation (1) is considered in $\mathbb{R}^d$ with an "arbitrary" right-hand side $f$ and fixed $\lambda > 0$. $\Delta u = u_{x^1x^1} + \dots + u_{x^dx^d}$ is Laplace's operator, $u_{x^i} = \partial u/\partial x^i = D_i u$ and $u_{x^ix^j} = D_{ij}u = D_jD_iu$. $C_0^2$ is the set of twice continuously differentiable functions on $\mathbb{R}^d$ with compact support, and $\|g\|_{\mathcal{L}_2}^2 = \int_{\mathbb{R}^d} |g(x)|^2\,dx$.
