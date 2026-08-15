# Context: krylov_sobolev_13_6_3_divergence_form_solvability

**Statement:** [krylov_sobolev_13_6_3_divergence_form_solvability.md](krylov_sobolev_13_6_3_divergence_form_solvability.md) · **Criteria:** [krylov_sobolev_13_6_3_divergence_form_solvability.criteria.md](krylov_sobolev_13_6_3_divergence_form_solvability.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Divergence-form equations, VMO coefficients, and the scaled estimate

**Krylov's standing notation.** Multi-indices $\alpha = (\alpha_1,\dots,\alpha_d)$ with
$|\alpha| = \alpha_1+\dots+\alpha_d$ and $D^\alpha = D_1^{\alpha_1}\cdots D_d^{\alpha_d}$; subscripts denote
partial derivatives, $u_{x^i} = D_iu$ and $u_{x^ix^j} = D_{ij}u$; repeated indices are summed;
$\mathcal{L}_p = \mathcal{L}_p(\mathbb{R}^d)$ is with respect to Lebesgue measure. $C_0^k$ is the space of
$C^k$ functions vanishing for large $|x|$, and $C_0^\infty$ the smooth ones — "compactly supported", not
"vanishing at infinity".

**Sobolev spaces.** $W_p^k$ consists of the $\mathcal{L}_p$ functions whose *generalized* (distributional)
derivatives up to order $k$ lie in $\mathcal{L}_p$: $v = D_ju$ means $\int u\,D_j\varphi = -\int v\,\varphi$
for every $\varphi \in C_0^\infty$. The **seminorm** $[u]_{W_p^k} = \sum_{|\alpha|=k}\|D^\alpha u\|_{\mathcal{L}_p}$
runs over multi-indices of order **exactly** $k$; the full norm adds the lower orders. Confusing the two is
the most common error in this chapter.

**The equation is in divergence form**: $Lu - \lambda u = D_if^i + g$ with
$Lu = D_i(a^{ij}D_ju + a^iu) + b^iD_iu + cu$. Both sides are distributions — $D_if^i$ is a distributional
derivative of an $\mathcal{L}_p$ function — so the equation is understood in the sense of distributions and
the solution is sought in $W_p^1$.

**Two constants with different dependencies, and that difference is the theorem's content.**
$\lambda_0$ depends on $d,p,\kappa,\omega,K$ — including the modulus of continuity $\omega$. The constant
$N$ in the estimate depends only on $d,p,\kappa,K$ — **not** on $\omega$. So $N$ must be quantified
*before* $\omega$ and $\lambda_0$ *after* it.

**$\omega$ is a modulus of continuity for the $a^{ij}$ only** (a VMO-type condition), with
$\omega(\varepsilon)\to0$ as $\varepsilon\downarrow0$; the lower-order coefficients $a^i,b^i,c$ are merely
measurable and bounded by $K$.

**Uniform ellipticity**: $a^{rk}(x)\xi^r\xi^k \ge \kappa|\xi|^2$ for all $x,\xi$.

**The estimate** $\lambda^{1/2}\|u\|_{\mathcal{L}_p} + \|Du\|_{\mathcal{L}_p} \le
N\bigl(\lambda^{-1/2}\|g\|_{\mathcal{L}_p} + \sum_i\|f^i\|_{\mathcal{L}_p}\bigr)$ carries the scaling weights
$\lambda^{1/2}$ and $\lambda^{-1/2}$; they are what make the estimate uniform in $\lambda$ and are not
interchangeable.
