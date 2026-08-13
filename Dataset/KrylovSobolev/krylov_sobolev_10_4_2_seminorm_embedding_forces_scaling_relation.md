# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*, Exercise 10.4.2 (the converse of the general embedding lemma)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovSobolev.krylov_sobolev_10_4_2_seminorm_embedding_forces_scaling_relation` ([krylov_sobolev_10_4_2_seminorm_embedding_forces_scaling_relation.lean](krylov_sobolev_10_4_2_seminorm_embedding_forces_scaling_relation.lean))
- **Criteria:** [krylov_sobolev_10_4_2_seminorm_embedding_forces_scaling_relation.criteria.md](krylov_sobolev_10_4_2_seminorm_embedding_forces_scaling_relation.criteria.md)

## Statement

**Exercise 10.4.2.** Let $\Omega = \mathbb{R}^d$ or $\Omega = \mathbb{R}^d_+$ and assume that (2) holds for any $u \in C_0^\infty(\Omega)$ and *some* $k, m, p, q$ with a constant independent of $u$. Then prove that $k \ge m$ and (1) holds.

**Notation.** The displays referred to are those of Lemma 10.4.1, where $k \in \{1, 2, \dots\}$, $p \in [1, \infty)$, $m \in \{0, \dots, k\}$ and $q \in (0, \infty)$:

$$k - \frac{d}{p} = m - \frac{d}{q} \tag{1}$$

$$[u]_{W_q^m(\Omega)} \le N[u]_{W_p^k(\Omega)} \tag{2}$$

Here $[u]_{W_p^k(\Omega)} = \sum_{|\alpha| = k}\|D^\alpha u\|_{\mathcal{L}_p(\Omega)}$ is the top-order seminorm — the sum runs over multi-indices of order exactly $k$ — and $\mathbb{R}^d_+ = \{x \in \mathbb{R}^d : x^1 > 0\}$. In the exercise $k, m, p, q$ are not assumed to satisfy any relation; that they must is the point. For an integer $k \ge 0$, $C_0^k$ denotes the $C^k$ functions on $\mathbb{R}^d$ that vanish for $|x|$ sufficiently large, and $C_0^\infty$ the infinitely differentiable ones. Subscripts denote partial derivatives: $u_{x^i} = D_iu$ and $u_{x^ix^j} = D_{ij}u$. Repeated indices are summed. $\mathcal{L}_p = \mathcal{L}_p(\mathbb{R}^d)$ is taken with respect to Lebesgue measure.
