# Context: krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative

**Statement:** [krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative.md](krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative.md) · **Criteria:** [krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative.criteria.md](krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Mollification rates and generalized derivatives

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

**The mollification** is $u^{(\varepsilon)}(x) = \int u(x-\varepsilon y)\zeta(y)\,dy$, where $\zeta \in C_0^\infty$
is **even** and integrates to $1$. Both properties of $\zeta$ are standing hypotheses inherited from the
previous exercise, and evenness is used.

**The hypothesis** is a weighted integral rate:
$\int_0^1 \|u^{(\varepsilon)}-u\|_{\mathcal{L}_2}^2\,\varepsilon^{-3}\,d\varepsilon \le M^2$. The weight
$\varepsilon^{-3}$ and the interval $(0,1)$ are as printed; the integrand is a square.

**The conclusion** is that $u$ lies in $W_2^1$ — i.e. its **generalized** first derivatives exist and lie in
$\mathcal{L}_2$ — together with the bound $\|u_x\|_{\mathcal{L}_2} \le N(M+\|u\|_{\mathcal{L}_2})$, where
$\|u_x\|$ is the summed first-order seminorm $\sum_j\|u_{x^j}\|$ and $N$ is independent of $M$ and $u$.

**Generalized derivative** means the distributional one: $v = D_ju$ when $\int u\,D_j\varphi = -\int v\,\varphi$
for every $\varphi \in C_0^\infty$. The sign is part of the definition.
