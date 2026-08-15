# Context: krylov_2_5_2_harmonic_smooth_interior_estimates

**Statement:** [krylov_2_5_2_harmonic_smooth_interior_estimates.md](krylov_2_5_2_harmonic_smooth_interior_estimates.md) · **Criteria:** [krylov_2_5_2_harmonic_smooth_interior_estimates.criteria.md](krylov_2_5_2_harmonic_smooth_interior_estimates.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Interior derivative estimates for harmonic functions

**Multi-index notation.** $\alpha = (\alpha_1,\dots,\alpha_d) \in \mathbb{N}^d$,
$|\alpha| = \alpha_1+\dots+\alpha_d$, $D^\alpha = D_1^{\alpha_1}\cdots D_d^{\alpha_d}$ with
$D_i = \partial/\partial x_i$, and $\xi^\alpha = \xi_1^{\alpha_1}\cdots\xi_d^{\alpha_d}$. Repeated indices
in expressions such as $a^{ij}D_{ij}u$ are summed.

**Domain** in Krylov means a nonempty connected open subset of $\mathbb{R}^d$. **Harmonic** means
$\Delta u = 0$; here $u$ is assumed $C^2_{\mathrm{loc}}(\Omega)\cap C(\Omega)$, so the Laplacian is
classical.

**The constant $N$ depends only on $d$ and $\alpha$** — not on $u$, not on $\Omega$, not on $x$ and not on
$R$. That independence is the content of the estimate, and it fixes the quantifier order: $N$ must be
chosen before everything else it is claimed to be independent of.

**The bound** $|D^\alpha u(x)| \le N R^{-|\alpha|}\sup_{B_R(x)}|u|$ holds **whenever
$B_R(x) \subseteq \Omega$** — the radius is constrained by the geometry, and that constraint is a
hypothesis of the inequality, not of the theorem.

**Two conclusions**: $u$ is $C^\infty$ in $\Omega$, and the derivative bound holds.
