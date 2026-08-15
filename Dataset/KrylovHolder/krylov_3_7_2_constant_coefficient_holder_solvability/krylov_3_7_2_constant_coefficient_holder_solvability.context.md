# Context: krylov_3_7_2_constant_coefficient_holder_solvability

**Statement:** [krylov_3_7_2_constant_coefficient_holder_solvability.md](krylov_3_7_2_constant_coefficient_holder_solvability.md) · **Criteria:** [krylov_3_7_2_constant_coefficient_holder_solvability.criteria.md](krylov_3_7_2_constant_coefficient_holder_solvability.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Constant-coefficient solvability in Hölder spaces

**Multi-index notation.** $\alpha = (\alpha_1,\dots,\alpha_d) \in \mathbb{N}^d$,
$|\alpha| = \alpha_1+\dots+\alpha_d$, $D^\alpha = D_1^{\alpha_1}\cdots D_d^{\alpha_d}$ with
$D_i = \partial/\partial x_i$, and $\xi^\alpha = \xi_1^{\alpha_1}\cdots\xi_d^{\alpha_d}$. Repeated indices
in expressions such as $a^{ij}D_{ij}u$ are summed.

**Krylov's Hölder spaces.** For an integer $k \ge 0$ and $\delta \in (0,1)$,
$$[u]_{k,\Omega} = \max_{|\alpha|=k}\sup_\Omega|D^\alpha u|, \qquad
[u]_{k+\delta,\Omega} = \max_{|\alpha|=k}\sup_{x\ne y}\frac{|D^\alpha u(x)-D^\alpha u(y)|}{|x-y|^\delta},$$
$$|u|_{k+\delta,\Omega} = \sum_{j=0}^{k}[u]_{j,\Omega} + [u]_{k+\delta,\Omega},$$
and $C^{k+\delta}(\Omega)$ is the set of $u$ with $k$ continuous derivatives on $\Omega$ and finite
$|u|_{k+\delta,\Omega}$. Two things are easy to lose. First, the norm bundles **all** the lower-order sup
norms, not only the top seminorm — so $C^{k+\delta}$ membership is a boundedness statement about $u$ and
all its derivatives up to order $k$, not merely a Hölder-continuity statement about the top one. Second,
membership means *both* that the derivatives exist and are continuous *and* that the norm is finite; a
finite gauge alone says nothing when the derivatives do not exist.

**Uniform ellipticity** with constant $\kappa>0$ for an operator of order $m$ is
$\sum_{|\alpha|=m}a^\alpha(x)\xi^\alpha \ge \kappa|\xi|^m$ for all $x$ and $\xi$: a lower bound on the
principal symbol only, uniform in $x$.

**The shifted operator $L_\lambda u = Lu - \lambda u$.** The sign matters: $L_\lambda$ is invertible for
$\lambda$ on one side only, and stating the theorem for an arbitrary $\lambda$ (or for the wrong sign)
gives a false statement — the negative spectrum of $L$ obstructs it.

**Constant coefficients.** $L = \sum_{|\alpha|\le m} a^\alpha D^\alpha$ with the $a^\alpha$ numbers, not
functions. The order is $m \ge 1$ and ellipticity constrains the top-order part only.

**$\lambda \ne 0$, with a sign.** The equation solved is $L_\lambda u = Lu - \lambda u = f$. Solvability
holds for $\lambda$ on the side of $0$ that makes $L_\lambda$ invertible; an unrestricted $\lambda$ would
include eigenvalues of $L$ and the statement would be false.

**Existence and uniqueness** in $C^{k+m+\delta}(\mathbb{R}^d)$, for every $f \in C^{k+\delta}(\mathbb{R}^d)$:
the solution gains exactly $m$ derivatives.
