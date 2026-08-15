# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*, Theorem 2.9.2 (maximum principle for bounded solutions)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovHolder.krylov_2_9_2_bounded_maximum_principle_resolvent` ([krylov_2_9_2_bounded_maximum_principle_resolvent.lean](krylov_2_9_2_bounded_maximum_principle_resolvent.lean))
- **Criteria:** [krylov_2_9_2_bounded_maximum_principle_resolvent.criteria.md](krylov_2_9_2_bounded_maximum_principle_resolvent.criteria.md)
- **Context:** [krylov_2_9_2_bounded_maximum_principle_resolvent.context.md](krylov_2_9_2_bounded_maximum_principle_resolvent.context.md)

## Statement

**Theorem 2.9.2.** Let $\Omega$ be a domain in $\mathbb{R}^d$ and $u$ be a bounded and continuous function on $\Omega$ and $u = 0$ on $\partial\Omega$ if $\partial\Omega \ne \emptyset$ (that is, if $\Omega \ne \mathbb{R}^d$). Moreover, assume that $u \in C^2_{\mathrm{loc}}(\Omega)$. Finally, let $a(x)$, $b(x)$ be bounded and $c(x) \le -\lambda$, where the constant $\lambda > 0$. Then in $\Omega$,

$$u \le \lambda^{-1} \sup_\Omega (Lu)^- \qquad \text{and} \qquad |u| \le \lambda^{-1} \sup_\Omega |Lu| .$$

**Notation.** $L$ is the second-order operator

$$Lu(x) = a^{ij}(x) D_{ij} u(x) + b^i(x) D_i u(x) + c(x) u(x),$$

with summation over repeated indices, $D_i = \partial/\partial x_i$ and $D_{ij} = \partial^2/\partial x_i \partial x_j$; $a = (a^{ij})$ and $b = (b^i)$ are its second- and first-order coefficient arrays and $c$ its zeroth-order coefficient. For a real number $t$ we write $t^- = \max(-t, 0)$ for its negative part.
