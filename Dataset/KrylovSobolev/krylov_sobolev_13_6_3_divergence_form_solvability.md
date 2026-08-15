# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*, Theorem 13.6.3 (solvability of divergence-type equations)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovSobolev.krylov_sobolev_13_6_3_divergence_form_solvability` ([krylov_sobolev_13_6_3_divergence_form_solvability.lean](krylov_sobolev_13_6_3_divergence_form_solvability.lean))
- **Criteria:** [krylov_sobolev_13_6_3_divergence_form_solvability.criteria.md](krylov_sobolev_13_6_3_divergence_form_solvability.criteria.md)
- **Context:** [krylov_sobolev_13_6_3_divergence_form_solvability.context.md](krylov_sobolev_13_6_3_divergence_form_solvability.context.md)

## Statement

**Theorem 13.6.3.** There exists a constant $\lambda_0 > 0$, depending only on $d, p, \kappa, \omega$, and $K$, such that for any $\lambda \ge \lambda_0$ and $f^1, \dots, f^d, g \in \mathcal{L}_p$ there exists a unique $u \in W_p^1$ satisfying (1). Furthermore, for this solution

$$\lambda^{1/2}\|u\|_{\mathcal{L}_p} + \|Du\|_{\mathcal{L}_p} \le N\Big(\lambda^{-1/2}\|g\|_{\mathcal{L}_p} + \sum_{i=1}^d\|f^i\|_{\mathcal{L}_p}\Big), \tag{3}$$

where $N$ depends only on $d, p, \kappa$, and $K$.

**Notation.** The standing setting of Section 13.6: $p \in (1, \infty)$ is fixed and in $\mathbb{R}^d$ we consider the equation

$$Lu - \lambda u = D_if^i + g \tag{1}$$

where

$$Lu(x) = D_i\big(a^{ij}(x)D_ju(x) + a^i(x)u(x)\big) + b^i(x)D_iu(x) + c(x)u(x).$$

All coefficients and $f^i$ and $g$ are *real valued* and, for some constant $K, \kappa > 0$ and all $i, j$, on $\mathbb{R}^d$

$$|a^{ij}|, |a^i|, |b^i|, |c| \le K, \qquad a^{rk}\xi^r\xi^k \ge \kappa|\xi|^2, \quad \forall\xi \in \mathbb{R}^d.$$

There also exists a function $\omega(\varepsilon)$, $\varepsilon > 0$, such that $\omega(\varepsilon) \to 0$ as $\varepsilon \downarrow 0$ and, for all $i, j$ and $x, y \in \mathbb{R}^d$ with $|x - y| \le \varepsilon$, $|a^{ij}(x) - a^{ij}(y)| \le \omega(\varepsilon)$. Solutions of (1) are sought in the class $W_p^1 = H_p^1$, and (1) is understood in the sense of distributions. For an integer $k \ge 0$, $C_0^k$ denotes the $C^k$ functions on $\mathbb{R}^d$ that vanish for $|x|$ sufficiently large, and $C_0^\infty$ the infinitely differentiable ones. Subscripts denote partial derivatives: $u_{x^i} = D_iu$ and $u_{x^ix^j} = D_{ij}u$. Repeated indices are summed. $\mathcal{L}_p = \mathcal{L}_p(\mathbb{R}^d)$ is taken with respect to Lebesgue measure.
