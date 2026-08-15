# Context: krylov_8_7_3_shifted_heat_holder_solvability

**Statement:** [krylov_8_7_3_shifted_heat_holder_solvability.md](krylov_8_7_3_shifted_heat_holder_solvability.md) · **Criteria:** [krylov_8_7_3_shifted_heat_holder_solvability.criteria.md](krylov_8_7_3_shifted_heat_holder_solvability.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The shifted heat equation on all of space-time

**Multi-index notation.** $\alpha = (\alpha_1,\dots,\alpha_d) \in \mathbb{N}^d$,
$|\alpha| = \alpha_1+\dots+\alpha_d$, $D^\alpha = D_1^{\alpha_1}\cdots D_d^{\alpha_d}$ with
$D_i = \partial/\partial x_i$, and $\xi^\alpha = \xi_1^{\alpha_1}\cdots\xi_d^{\alpha_d}$. Repeated indices
in expressions such as $a^{ij}D_{ij}u$ are summed.

**Parabolic Hölder spaces.** Points of $\mathbb{R}^{d+1}$ are $p=(t,x)$. The parabolic scaling gives a
space direction weight $1$ and the time direction weight $1/2$, so "$2+\delta$ derivatives in $x$"
corresponds to "$1+\delta/2$ derivatives in $t$". Accordingly $C^{\delta/2,\delta}$ consists of functions
$\delta$-Hölder in $x$ and $(\delta/2)$-Hölder in $t$; $C^{1+\delta/2,2+\delta}$ of functions $u$ for which
$u$, $D_xu$, $D_x^2u$ and $u_t$ exist and are bounded, with $D_x^2u$ and $u_t$ in $C^{\delta/2,\delta}$.
The two exponents are locked together by the scaling and cannot be chosen independently.

**The equation** is $\Delta u - u_t - u = f$ on all of $\mathbb{R}^{d+1}$, with $\Delta$ acting in the
**space** variables only. The zeroth-order shift $-u$ is essential: without it the operator is not
invertible on these spaces (constants solve the homogeneous equation).

**What is asserted**: for every $f \in C^{\delta/2,\delta}(\mathbb{R}^{d+1})$ there is a **unique**
$u \in C^{1+\delta/2,2+\delta}(\mathbb{R}^{d+1})$ solving it. Uniqueness is relative to that regularity
class — the equation has other solutions in larger classes.

**The equation holds pointwise everywhere**, classically; the regularity assumption on $u$ is what makes
$\Delta u$ and $u_t$ genuine derivatives rather than default values.
