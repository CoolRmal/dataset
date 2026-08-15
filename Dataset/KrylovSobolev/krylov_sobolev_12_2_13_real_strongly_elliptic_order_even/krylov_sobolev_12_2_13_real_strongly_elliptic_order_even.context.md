# Context: krylov_sobolev_12_2_13_real_strongly_elliptic_order_even

**Statement:** [krylov_sobolev_12_2_13_real_strongly_elliptic_order_even.md](krylov_sobolev_12_2_13_real_strongly_elliptic_order_even.md) · **Criteria:** [krylov_sobolev_12_2_13_real_strongly_elliptic_order_even.criteria.md](krylov_sobolev_12_2_13_real_strongly_elliptic_order_even.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Strong ellipticity and the characteristic polynomial

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

**Strong ellipticity (Definition 12.2.1) is two conditions**, both required:

1. $\sum_{|\alpha|=m}a^\alpha\xi^\alpha \ne 0$ for every real $\xi \ne 0$ — the **principal symbol**
   (top-order part only) does not vanish off the origin;
2. $\sigma(\xi) = \sum_{|\alpha|\le m}a^\alpha i^{|\alpha|}\xi^\alpha \ne 0$ for every real $\xi$ — the
   **characteristic polynomial**, which involves the full symbol with the factors $i^{|\alpha|}$, does not
   vanish anywhere.

The powers of $i$ in the second condition come from $D^\alpha \mapsto (i\xi)^\alpha$ under the Fourier
transform and are not decoration.

**The coefficients are complex in general**; the exercise's hypothesis is that they are **real** — all of
them, the lower-order ones included.

**The hypotheses $m \ge 1$ and $d \ge 2$** are both used: in dimension $1$ the conclusion is false.

**The conclusion**: $m$ is even.
