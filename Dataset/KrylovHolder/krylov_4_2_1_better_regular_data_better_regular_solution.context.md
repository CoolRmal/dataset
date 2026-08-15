# Context: krylov_4_2_1_better_regular_data_better_regular_solution

**Statement:** [krylov_4_2_1_better_regular_data_better_regular_solution.md](krylov_4_2_1_better_regular_data_better_regular_solution.md) · **Criteria:** [krylov_4_2_1_better_regular_data_better_regular_solution.criteria.md](krylov_4_2_1_better_regular_data_better_regular_solution.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Bootstrapping regularity, and the weighted a-priori estimate

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

**Two separate assertions.**

1. A **regularity gain valid for every $\lambda$, with no threshold**: if $u \in C^{m+\delta}$ and
   $L_\lambda u \in C^{k+\delta}$, then $u \in C^{k+m+\delta}$. Attaching a threshold here weakens it.
2. A **weighted a-priori estimate valid only above a threshold**: for $|\lambda| \ge \lambda_0$,
   $$|u|_{k+m+\delta} + |\lambda|^{(k+m+\delta)/m}|u|_0 \le N\bigl(|L_\lambda u|_{k+\delta} + |\lambda|^{(k+\delta)/m}|L_\lambda u|_0\bigr).$$
   Both weighted terms are present, with the exponents $(k+m+\delta)/m$ on the left and $(k+\delta)/m$ on
   the right; those exponents are dictated by the parabolic/elliptic scaling and are not interchangeable.

**$N$ depends only on $\kappa,k,m,\delta,K_1,d$** and is chosen before $\lambda$, $u$ and $f$. $K_1 \ge 1$
bounds every $|a^\alpha|_{k+\delta}$.

**$\lambda_0$ comes from Theorem 4.1.2** and depends only on the structural data.
