# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*, Theorem 2.5.2 (smoothness and interior estimates for harmonic functions)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovHolder.krylov_2_5_2_harmonic_smooth_interior_estimates` ([krylov_2_5_2_harmonic_smooth_interior_estimates.lean](krylov_2_5_2_harmonic_smooth_interior_estimates.lean))
- **Criteria:** [krylov_2_5_2_harmonic_smooth_interior_estimates.criteria.md](krylov_2_5_2_harmonic_smooth_interior_estimates.criteria.md)
- **Context:** [krylov_2_5_2_harmonic_smooth_interior_estimates.context.md](krylov_2_5_2_harmonic_smooth_interior_estimates.context.md)

## Statement

**Theorem 2.5.2.** Let $\Omega$ be a domain and $u \in C^2_{\mathrm{loc}}(\Omega) \cap C(\Omega)$ be a harmonic function in $\Omega$. Then $u$ is infinitely differentiable in $\Omega$ and for any multi-index $\alpha$ and any $x \in \Omega$ we have

$$|D^\alpha u(x)| \le N R^{-|\alpha|} \sup_{B_R(x)} |u|$$

whenever $B_R(x) \subset \Omega$.

**Notation.** $\Omega \subset \mathbb{R}^d$ is a domain, i.e. a nonempty connected open set; $u$ is harmonic in $\Omega$ if $\Delta u = 0$ in $\Omega$. For a multi-index $\alpha = (\alpha_1,\dots,\alpha_d) \in \mathbb{N}^d$ we write $|\alpha| = \alpha_1 + \dots + \alpha_d$ and $D^\alpha = D_1^{\alpha_1}\cdots D_d^{\alpha_d}$ with $D_i = \partial/\partial x_i$; $B_R(x)$ is the open ball of radius $R$ centred at $x$. The constant $N$ depends only on $d$ and $\alpha$; in particular it is independent of $u$, of $\Omega$, of $x$ and of $R$.
