# Context: krylov_10_3_3_parabolic_dirichlet_domain_solvability

**Statement:** [krylov_10_3_3_parabolic_dirichlet_domain_solvability.md](krylov_10_3_3_parabolic_dirichlet_domain_solvability.md) · **Criteria:** [krylov_10_3_3_parabolic_dirichlet_domain_solvability.criteria.md](krylov_10_3_3_parabolic_dirichlet_domain_solvability.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The parabolic boundary and parabolic Hölder spaces

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

**Parabolic Hölder spaces.** Points of $\mathbb{R}^{d+1}$ are $p=(t,x)$. The parabolic scaling gives a
space direction weight $1$ and the time direction weight $1/2$, so "$2+\delta$ derivatives in $x$"
corresponds to "$1+\delta/2$ derivatives in $t$". Accordingly $C^{\delta/2,\delta}$ consists of functions
$\delta$-Hölder in $x$ and $(\delta/2)$-Hölder in $t$; $C^{1+\delta/2,2+\delta}$ of functions $u$ for which
$u$, $D_xu$, $D_x^2u$ and $u_t$ exist and are bounded, with $D_x^2u$ and $u_t$ in $C^{\delta/2,\delta}$.
The two exponents are locked together by the scaling and cannot be chosen independently.

**The parabolic boundary $\partial' Q$.** Not the topological boundary: it is $\partial Q$ minus the points
that $Q$ reaches only from *earlier* times — formally, minus the points $p$ that have a backward
neighbourhood $\{q : |q-p|<\varepsilon,\ q_t<p_t\}$ contained in $Q$. For a cylinder $Q=(0,T)\times\Omega$
it is the bottom $\{0\}\times\Omega$ together with the lateral surface $[0,T)\times\partial\Omega$; the
**top** $\{T\}\times\Omega$ is excluded. Imposing the boundary datum on all of $\partial Q$ instead
over-determines the problem and makes the statement false.

**$L$ acts in the space variables only**: $Lu = a^{ij}D_{ij}u + b^iD_iu + cu$ with $D$ spatial. The time
derivative appears separately, in $Lu - u_t = f$.

**Uniform parabolicity** is $a^{ij}(t,x)\xi_i\xi_j \ge \kappa|\xi|^2$ for all $(t,x)$ and all
$\xi \in \mathbb{R}^d$ — the spatial part is uniformly elliptic, uniformly in time.

**What is asserted**: existence **and** uniqueness of $u \in C^{1+\delta/2,2+\delta}(Q)$ solving
$Lu-u_t=f$ in $Q$ and equal to $g$ on $\partial'Q$.
