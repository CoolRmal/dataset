# Context: krylov_sobolev_1_1_13_const_coeff_operator_range_dense

**Statement:** [krylov_sobolev_1_1_13_const_coeff_operator_range_dense.md](krylov_sobolev_1_1_13_const_coeff_operator_range_dense.md) · **Criteria:** [krylov_sobolev_1_1_13_const_coeff_operator_range_dense.criteria.md](krylov_sobolev_1_1_13_const_coeff_operator_range_dense.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Density of the range of a constant-coefficient operator

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

**The operator.** $L = \sum_{|\alpha|\le m}a^\alpha D^\alpha$ with **complex** constant coefficients, **not
all zero** — the only hypothesis on them. In particular $L$ need not be elliptic, need not be of pure order
$m$, and the multi-index $\alpha = 0$ is included in the sum.

**$LC_0^\infty$** is the image of the compactly supported smooth functions under $L$, viewed as a subset of
$\mathcal{L}_p$.

**The claim is density**, not surjectivity: the closure of $LC_0^\infty$ is all of $\mathcal{L}_p$.

**The exponent range is $[2,\infty)$**, not $[1,\infty)$ — Remark 1.1.14 flags that the restriction is
genuine. Scalars are complex on both sides.
