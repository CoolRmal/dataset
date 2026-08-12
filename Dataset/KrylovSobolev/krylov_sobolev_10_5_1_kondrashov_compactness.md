# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*, Theorem 10.5.1 (Kondrashov's compactness theorem)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovSobolev.krylov_sobolev_10_5_1_kondrashov_compactness` ([krylov_sobolev_10_5_1_kondrashov_compactness.lean](krylov_sobolev_10_5_1_kondrashov_compactness.lean))
- **Criteria:** [krylov_sobolev_10_5_1_kondrashov_compactness.criteria.md](krylov_sobolev_10_5_1_kondrashov_compactness.criteria.md)

## Statement

**Theorem 10.5.1.** Let $p \in [1,\infty)$, $k \in \{1,2,\dots\}$, $m \in \{0,1,\dots,k-1\}$, $\Omega \in C^k$, and let $U$ be a bounded subset of $W_p^k(\Omega)$. Then $U$ is precompact in $W_q^m(\Omega)$ for any $q \in [1,\infty)$ satisfying the strict inequality in (10.4.4):

$$k - \frac{d}{p} > m - \frac{d}{q},$$

so that $q$ is just any number in $[1,\infty)$ if $p(k-m) \ge d$.

**Notation.** $\|u\|_{W_p^k(\Omega)} = \sum_{|\alpha| \le k}\|D^\alpha u\|_{\mathcal{L}_p(\Omega)}$, the derivatives being generalized (Sobolev) derivatives; "$U$ is a bounded subset of $W_p^k(\Omega)$" means $U \subset W_p^k(\Omega)$ and $\sup_{u \in U}\|u\|_{W_p^k(\Omega)} < \infty$, and "$U$ is precompact in $W_q^m(\Omega)$" means that every sequence in $U$ has a subsequence converging in the norm of $W_q^m(\Omega)$ to an element of $W_q^m(\Omega)$.

**Definition 8.3.1.** Let $k \in \{1,2,\dots\}$ and $\Omega$ be a *bounded* domain in $\mathbb{R}^d$. We write $\Omega \in C^k$ (or $\partial\Omega \in C^k$) and say that the domain $\Omega$ is of class $C^k$ if there are numbers $K_0, \rho_0 > 0$ such that for any point $z \in \partial\Omega$ there exists a one-to-one mapping $\psi$ of $B_{\rho_0}(z)$ onto a domain $D^z \subset \mathbb{R}^d$ such that

(i) $D^z_+ := \psi(B_{\rho_0}(z) \cap \Omega) \subset \mathbb{R}^d_+$ and $\psi(z) = 0$,

(ii) $\psi(B_{\rho_0}(z) \cap \partial\Omega) = D^z \cap \{y \in \mathbb{R}^d : y^1 = 0\}$,

(iii) $\psi \in C^k(\bar{B}_{\rho_0}(z))$, $\psi^{-1} \in C^k(\bar{D}^z)$ and

$$|\psi|_{C^k(B_{\rho_0}(z))} + |\psi^{-1}|_{C^k(D^z)} \le K_0.$$
