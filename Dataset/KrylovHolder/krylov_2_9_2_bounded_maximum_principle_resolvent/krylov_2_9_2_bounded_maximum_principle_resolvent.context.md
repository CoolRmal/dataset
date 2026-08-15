# Context: krylov_2_9_2_bounded_maximum_principle_resolvent

**Statement:** [krylov_2_9_2_bounded_maximum_principle_resolvent.md](krylov_2_9_2_bounded_maximum_principle_resolvent.md) · **Criteria:** [krylov_2_9_2_bounded_maximum_principle_resolvent.criteria.md](krylov_2_9_2_bounded_maximum_principle_resolvent.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## A maximum principle with a strictly negative zeroth-order coefficient

**Multi-index notation.** $\alpha = (\alpha_1,\dots,\alpha_d) \in \mathbb{N}^d$,
$|\alpha| = \alpha_1+\dots+\alpha_d$, $D^\alpha = D_1^{\alpha_1}\cdots D_d^{\alpha_d}$ with
$D_i = \partial/\partial x_i$, and $\xi^\alpha = \xi_1^{\alpha_1}\cdots\xi_d^{\alpha_d}$. Repeated indices
in expressions such as $a^{ij}D_{ij}u$ are summed.

**The operator** is $Lu = a^{ij}D_{ij}u + b^iD_iu + cu$, second order, with $a$ and $b$ **bounded** and the
zeroth-order coefficient satisfying $c(x) \le -\lambda$ for a constant $\lambda > 0$. The strict negativity
of $c$ is what produces the factor $\lambda^{-1}$ and makes the estimate global.

**$t^- = \max(-t,0)$** is the negative part of a real number — a **nonnegative** quantity. So
$\sup_\Omega(Lu)^-$ measures how negative $Lu$ gets. The first conclusion $u \le \lambda^{-1}\sup(Lu)^-$ is
one-sided; the second $|u| \le \lambda^{-1}\sup|Lu|$ is two-sided. Both are asserted.

**The boundary condition** is $u = 0$ on $\partial\Omega$ *if* $\partial\Omega \ne \emptyset$; when
$\Omega = \mathbb{R}^d$ there is no boundary and the hypothesis is vacuous. A formalization must let that
case through.

**$u$ is bounded and continuous on $\Omega$ and $C^2_{\mathrm{loc}}$ inside.**
