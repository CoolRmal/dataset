# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*, Exercise 13.3.13 (functions of negative order are divergences)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovSobolev.krylov_sobolev_13_3_13_negative_order_divergence_decomposition` ([krylov_sobolev_13_3_13_negative_order_divergence_decomposition.lean](krylov_sobolev_13_3_13_negative_order_divergence_decomposition.lean))
- **Criteria:** [krylov_sobolev_13_3_13_negative_order_divergence_decomposition.criteria.md](krylov_sobolev_13_3_13_negative_order_divergence_decomposition.criteria.md)

## Statement

**Exercise 13.3.13.** Prove that for any $g \in H_p^{-1}$ there exist $f_0, \dots, f_d \in \mathcal{L}_p$ such that

$$g = f_0 + \sum_j D_jf_j \tag{7}$$

and

$$\sum_{j=0}^d\|f_j\|_{\mathcal{L}_p} \le N\|g\|_{H_p^{-1}},$$

where the constant $N$ is independent of $g$. Also prove that if (7) holds with $f_0, \dots, f_d \in \mathcal{L}_p$, then $g \in H_p^{-1}$ and

$$\|g\|_{H_p^{-1}} \le N\sum_{j=0}^d\|f_j\|_{\mathcal{L}_p},$$

where the constant $N$ is independent of the $f_j$'s.

**Notation.** Throughout Section 13.3, $p \in (1, \infty)$. By Definition 13.3.1, $H_p^\gamma = (1 - \Delta)^{-\gamma/2}\mathcal{L}_p$ and, for $g \in H_p^\gamma$,

$$\|g\|_{H_p^\gamma} = \|(1 - \Delta)^{\gamma/2}g\|_{\mathcal{L}_p}. \tag{1}$$

These are the *spaces of Bessel potentials*. In (7) the $D_jf_j$ are distributional derivatives, so the identity is an identity of distributions, not of functions.
