# Context: krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership

**Statement:** [krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership.md](krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership.md) · **Criteria:** [krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership.criteria.md](krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Recognising membership in a negative-order space from pointwise decay

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

**Why the exercise is interesting.** A $u$ satisfying $|u(x)| \le N_0|x|^{-\nu}$ with $\nu < d$ but
$\nu p \ge d$ need **not** lie in $\mathcal{L}_p$, so the trivial embedding $\mathcal{L}_p \subset H_p^\gamma$
($\gamma<0$) is unavailable. The point is to get membership in $H_p^\gamma$ anyway.

**First half.** $u$ supported in $B_\rho$ with $|u(x)| \le N_0|x|^{-\nu}$, and $\nu<d$,
$0<(\nu+\gamma)p<d$, $\gamma<0$. Conclusion: $u \in H_p^\gamma$ with $\|u\|_{H_p^\gamma}$ bounded by a
constant depending only on $d,p,\rho,\nu,\gamma,N_0$ — in particular **not** on $u$.

**Second half.** With $n \ge 0$ an integer and $\gamma \le n$: if $|D^\alpha u(x)| \le N_0|x|^{-\nu}$ for
**all** $|\alpha| \le n$, $\nu<d$, and **either** $\gamma<n$ with $0<(\nu+\gamma-n)p<d$, **or** $\gamma=n$
with $\nu p<d$, then again $u \in H_p^\gamma$ with a bound depending only on the data. The "either/or" is a
genuine disjunction and both branches are needed.

**Dimension.** The statement is about $\mathbb{R}^d$ with $d \ge 1$; in dimension $0$ the support and decay
hypotheses degenerate and the constant-function counterexample makes the second half false.

**$p \in (1,\infty)$.**
