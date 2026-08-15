# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*, Exercise 9.1.7 (a mollification rate forces a generalized derivative)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovSobolev.krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative` ([krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative.lean](krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative.lean))
- **Criteria:** [krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative.criteria.md](krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative.criteria.md)
- **Context:** [krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative.context.md](krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative.context.md)

## Statement

**Exercise 9.1.7.** Prove that, if $u \in \mathcal{L}_2$ and

$$\int_0^1\|u^{(\varepsilon)} - u\|^2_{\mathcal{L}_2}\,\varepsilon^{-3}\,d\varepsilon \le M^2,$$

then $u \in W_2^1$ and

$$\|u_x\|_{\mathcal{L}_2} \le N(M + \|u\|_{\mathcal{L}_2}),$$

where $N$ is independent of $M$ and $u$.

**Notation.** The mollification (1.8.4) is $u^{(\varepsilon)}(x) = \int_{\mathbb{R}^d}u(x - \varepsilon y)\zeta(y)\,dy$, and the standing assumption inherited from Exercise 9.1.6 is that $\zeta \in C_0^\infty$ is even and integrates to one. $W_2^1$ is the space of $u \in \mathcal{L}_2$ whose generalized first derivatives $u_{x^j}$ exist and lie in $\mathcal{L}_2$; $v$ is the generalized derivative $D_ju$ when $\int u\,D_j\varphi = -\int v\,\varphi$ for every $\varphi \in C_0^\infty$. $\|u_x\|_{\mathcal{L}_2}$ is the summed first-order seminorm $\sum_j\|u_{x^j}\|_{\mathcal{L}_2}$. For an integer $k \ge 0$, $C_0^k$ denotes the $C^k$ functions on $\mathbb{R}^d$ that vanish for $|x|$ sufficiently large, and $C_0^\infty$ the infinitely differentiable ones. Subscripts denote partial derivatives: $u_{x^i} = D_iu$ and $u_{x^ix^j} = D_{ij}u$. Repeated indices are summed. $\mathcal{L}_p = \mathcal{L}_p(\mathbb{R}^d)$ is taken with respect to Lebesgue measure.
