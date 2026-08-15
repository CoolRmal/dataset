# Context: krylov_sobolev_13_3_13_negative_order_divergence_decomposition

**Statement:** [krylov_sobolev_13_3_13_negative_order_divergence_decomposition.md](krylov_sobolev_13_3_13_negative_order_divergence_decomposition.md) · **Criteria:** [krylov_sobolev_13_3_13_negative_order_divergence_decomposition.criteria.md](krylov_sobolev_13_3_13_negative_order_divergence_decomposition.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Negative-order Bessel spaces and divergence decompositions

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

**Bessel potential spaces.** $(1-\Delta)^{\gamma/2}$ is the Fourier multiplier with symbol
$(1+|\xi|^2)^{\gamma/2}$, i.e. $(1-\Delta)^{\gamma/2}\phi = F^{-1}\bigl((1+|\xi|^2)^{\gamma/2}F\phi\bigr)$,
and $H_p^\gamma$ is the space of distributions $u$ with $(1-\Delta)^{\gamma/2}u \in \mathcal{L}_p$, normed by
$\|u\|_{H_p^\gamma} = \|(1-\Delta)^{\gamma/2}u\|_{\mathcal{L}_p}$. The order $\gamma$ is a **real** number and
may be negative, in which case elements of $H_p^\gamma$ are genuine distributions and need not be functions.

**$H_p^{-1}$ consists of distributions**, not functions: the exercise is precisely about representing them.

**The decomposition** $g = f_0 + \sum_{j=1}^d D_jf_j$ with $f_0,\dots,f_d \in \mathcal{L}_p$. Note there are
$d+1$ functions: $f_0$ appears undifferentiated and $f_1,\dots,f_d$ under first derivatives. The identity is
an identity of **distributions**, i.e. it is tested against $C_0^\infty$; the $D_jf_j$ are distributional
derivatives of $\mathcal{L}_p$ functions and are not functions.

**Two directions, two constants, both uniform.** Forward: every $g \in H_p^{-1}$ admits such a
decomposition with $\sum_j\|f_j\|_{\mathcal{L}_p} \le N\|g\|_{H_p^{-1}}$. Backward: any $g$ of that form lies
in $H_p^{-1}$ with $\|g\|_{H_p^{-1}} \le N\sum_j\|f_j\|_{\mathcal{L}_p}$. In each case $N$ is independent of
the data and must be quantified before it.

**$p \in (1,\infty)$.**
