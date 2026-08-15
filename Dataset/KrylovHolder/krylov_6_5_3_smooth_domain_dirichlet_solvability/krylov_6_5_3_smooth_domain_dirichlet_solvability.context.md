# Context: krylov_6_5_3_smooth_domain_dirichlet_solvability

**Statement:** [krylov_6_5_3_smooth_domain_dirichlet_solvability.md](krylov_6_5_3_smooth_domain_dirichlet_solvability.md) · **Criteria:** [krylov_6_5_3_smooth_domain_dirichlet_solvability.criteria.md](krylov_6_5_3_smooth_domain_dirichlet_solvability.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The Dirichlet problem on a smooth bounded domain

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

**The domain** $\Omega$ is bounded, nonempty, open, with **smooth** boundary. Smoothness of $\partial\Omega$
is what gives regularity up to the boundary.

**The operator** is second order and uniformly elliptic, with coefficients in $C^{k+\delta}$. The
zeroth-order coefficient must satisfy $c \le 0$ — without a sign condition on $c$ the Dirichlet problem is
not uniquely solvable, because $L$ can have a positive eigenvalue.

**The data and the two different domains.** $f \in C^{k+\delta}(\Omega)$ is required on the open set;
$g \in C^{k+2+\delta}(\bar\Omega)$ on the **closure**. The distinction is deliberate: the boundary datum
must be regular up to the boundary.

**The conclusion** is existence and uniqueness of $u \in C^{k+2+\delta}(\Omega)$ with $Lu=f$ in $\Omega$
and $u=g$ on $\partial\Omega$; the solution is classical, continuous up to $\bar\Omega$.
