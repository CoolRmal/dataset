# Context: krylov_sobolev_1_3_23_unit_ball_estimate_and_polynomial_operator_bijective

**Statement:** [krylov_sobolev_1_3_23_unit_ball_estimate_and_polynomial_operator_bijective.md](krylov_sobolev_1_3_23_unit_ball_estimate_and_polynomial_operator_bijective.md) · **Criteria:** [krylov_sobolev_1_3_23_unit_ball_estimate_and_polynomial_operator_bijective.criteria.md](krylov_sobolev_1_3_23_unit_ball_estimate_and_polynomial_operator_bijective.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## A Poincaré-type estimate on the ball and a polynomial operator

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

**Part (i).** $B$ is the **open** unit ball at the origin; $u$ is $C^2$ on the **closed** ball and vanishes
on the boundary sphere; $f = \Delta u$. The estimate is
$$\|u\|_{\mathcal{L}_2(B)}^2 + \sum_i\|u_{x^i}\|_{\mathcal{L}_2(B)}^2 \le 4\|f\|_{\mathcal{L}_2(B)}^2,$$
with the explicit constant $4$ — not an unspecified one. The left side has $u$ and its **first** derivatives
only; the second derivatives do not appear.

**Part (ii).** $P_n$ is the space of polynomials in $x$ of **total** degree $\le n$, and
$A\colon P_n \to P_n$ is $Ap = \Delta[(1-|x|^2)p]$. That $A$ lands in $P_n$ is part of the claim (the factor
$1-|x|^2$ raises the degree by $2$ and the Laplacian lowers it by $2$). The conclusion is that $A$ is
invertible, for **every** $n$.

**Part (iii) of the exercise, which needs $W_2^2(B)$, is deliberately outside the scope of this problem.**
