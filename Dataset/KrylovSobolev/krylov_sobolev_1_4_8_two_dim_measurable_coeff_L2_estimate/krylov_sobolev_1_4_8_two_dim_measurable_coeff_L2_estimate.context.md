# Context: krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate

**Statement:** [krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate.md](krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate.md) · **Criteria:** [krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate.criteria.md](krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## A two-dimensional estimate with merely measurable coefficients

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

**The setting is exactly $d = 2$.** The coefficients $a^{ij}$ are merely **measurable** — no continuity — and
symmetric, $a^{ij} = a^{ji}$, and satisfy the two-sided bound
$\mu|\xi|^2 \le a^{ij}\xi^i\xi^j \le \nu|\xi|^2$ for all $x$ and $\xi$, with $\mu,\nu>0$.

**The operator carries a specific zeroth-order term**: $Lu = a^{ij}u_{x^ix^j} - \lambda(a^{11}+a^{22})u$ —
the shift is $\lambda$ times the **trace** of the coefficient matrix, not $\lambda u$.

**The estimate**
$$\lambda^2\|u\|^2 + 2\lambda\sum_j\|u_{x^j}\|^2 + \sum_{j,k}\|u_{x^jx^k}\|^2 \le \frac{\nu^2}{\mu^4}\|Lu\|^2$$
has three groups on the left with weights $\lambda^2$, $2\lambda$ and $1$; the second-derivative sum runs over
**all four ordered pairs** $(j,k)$, so mixed derivatives are counted twice. The constant is exactly
$\nu^2/\mu^4$, not an unspecified one.

**$u \in C_0^2$**: twice continuously differentiable on $\mathbb{R}^2$ and vanishing for large $|x|$.
