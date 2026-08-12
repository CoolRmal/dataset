# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*, Theorem 10.3.2 (the Gagliardo–Nirenberg theorem)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovSobolev.krylov_sobolev_10_3_2_gagliardo_nirenberg` ([krylov_sobolev_10_3_2_gagliardo_nirenberg.lean](krylov_sobolev_10_3_2_gagliardo_nirenberg.lean))
- **Criteria:** [krylov_sobolev_10_3_2_gagliardo_nirenberg.criteria.md](krylov_sobolev_10_3_2_gagliardo_nirenberg.criteria.md)

## Statement

**Theorem 10.3.2 (Gagliardo–Nirenberg).** Let $\Omega = \mathbb{R}^d$ or $\Omega = \mathbb{R}^d_+$. Let $u \in W^1_1(\Omega)$. Then $u \in \mathcal{L}_{d/(d-1)}(\Omega)$ and

$$\|u\|_{\mathcal{L}_{d/(d-1)}(\Omega)} \le \prod_{j=1}^d \|D_j u\|_{\mathcal{L}_1(\Omega)}^{1/d}. \tag{1}$$

**Notation.** $\mathbb{R}^d_+ = \{(x^1,x') : x^1 > 0,\ x' = (x^2,\dots,x^d) \in \mathbb{R}^{d-1}\}$, and $D_j = \partial/\partial x^j$ is taken in the generalized (Sobolev) sense: $h = D_j u$ means $\int_\Omega \phi\,h\,dx = -\int_\Omega u\,D_j\phi\,dx$ for all $\phi \in C_0^\infty(\Omega)$. The space $W^1_1(\Omega)$ consists of the $u \in \mathcal{L}_1(\Omega)$ whose generalized derivatives $D_j u$, $j = 1,\dots,d$, exist and belong to $\mathcal{L}_1(\Omega)$. The exponent $d/(d-1)$ is read as $\infty$ when $d = 1$, the case in which the proof of the theorem starts.
