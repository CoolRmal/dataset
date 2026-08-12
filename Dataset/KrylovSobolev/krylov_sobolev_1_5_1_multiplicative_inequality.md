# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*, Theorem 1.5.1 (multiplicative inequality)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovSobolev.krylov_sobolev_1_5_1_multiplicative_inequality` ([krylov_sobolev_1_5_1_multiplicative_inequality.lean](krylov_sobolev_1_5_1_multiplicative_inequality.lean))
- **Criteria:** [krylov_sobolev_1_5_1_multiplicative_inequality.criteria.md](krylov_sobolev_1_5_1_multiplicative_inequality.criteria.md)

## Statement

Everywhere in this section

$$\Omega = \mathbb{R}^d \quad \text{or} \quad \Omega = \mathbb{R}^d_+.$$

**Theorem 1.5.1.** For any $p \in [1,\infty)$ and $u \in W_p^2(\Omega)$ we have

$$\|u_x\|_{\mathcal{L}_p(\Omega)} \le N \|u\|^{1/2}_{\mathcal{L}_p(\Omega)} \|u_{xx}\|^{1/2}_{\mathcal{L}_p(\Omega)}, \tag{1}$$

where $N$ is independent of $u$.

**Notation.** $\mathbb{R}^d_+ = \{(x^1,x') : x^1 > 0,\ x' = (x^2,\dots,x^d) \in \mathbb{R}^{d-1}\}$. $u_x = \operatorname{grad} u = \nabla u$ and $u_{xx} = (u_{x^ix^j})$, so that $\|u_x\|_{\mathcal{L}_p(\Omega)}$ and $\|u_{xx}\|_{\mathcal{L}_p(\Omega)}$ are the $\mathcal{L}_p(\Omega)$ norms of the lengths $|u_x|$ and $|u_{xx}|$ of the gradient vector and of the Hessian matrix. The derivatives are generalized (Sobolev) derivatives: for $u \in \mathcal{L}_p(\Omega)$, $h = D^\alpha u$ means $\int_\Omega \phi\, h\,dx = (-1)^{|\alpha|}\int_\Omega u\,D^\alpha\phi\,dx$ for all $\phi \in C_0^\infty(\Omega)$, and $u \in W_p^k(\Omega)$ means that $u$ and all its generalized derivatives $D^\alpha u$ with $|\alpha| \le k$ belong to $\mathcal{L}_p(\Omega)$.
