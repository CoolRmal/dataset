# Context: krylov_sobolev_10_4_2_seminorm_embedding_forces_scaling_relation

**Statement:** [krylov_sobolev_10_4_2_seminorm_embedding_forces_scaling_relation.md](krylov_sobolev_10_4_2_seminorm_embedding_forces_scaling_relation.md) · **Criteria:** [krylov_sobolev_10_4_2_seminorm_embedding_forces_scaling_relation.criteria.md](krylov_sobolev_10_4_2_seminorm_embedding_forces_scaling_relation.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Top-order seminorms and the scaling relation

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

**The two displays.** (1) is the scaling identity $k - d/p = m - d/q$; (2) is the seminorm embedding
$[u]_{W_q^m(\Omega)} \le N[u]_{W_p^k(\Omega)}$. Both seminorms are **top-order**: the sums run over
multi-indices of order exactly $k$ and exactly $m$. Using the full Sobolev norms instead changes the
exercise, because the full norms are not homogeneous under dilation and the scaling argument collapses.

**What is assumed and what is proved.** The exercise **assumes** (2) holds for all $u \in C_0^\infty(\Omega)$
with one constant $N$ independent of $u$, and for *some* $k,m,p,q$ satisfying only the standing ranges
$k \ge 1$, $p \in [1,\infty)$, $m \in \{0,\dots,k\}$, $q \in (0,\infty)$ — with **no** relation among them
assumed. It **concludes** $k \ge m$ and the identity (1). That the exponents are forced is the point, so
assuming (1) as a hypothesis destroys the exercise.

**$\mathbb{R}^d_+ = \{x : x^1 > 0\}$**, the open half-space.

**The constant is uniform in $u$** — one $N$ for all test functions. A per-$u$ constant makes (2) trivially
true.
