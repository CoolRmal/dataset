# Context: krylov_2_3_1_green_poisson_representation

**Statement:** [krylov_2_3_1_green_poisson_representation.md](krylov_2_3_1_green_poisson_representation.md) · **Criteria:** [krylov_2_3_1_green_poisson_representation.criteria.md](krylov_2_3_1_green_poisson_representation.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Green's function, the Poisson kernel and the outward normal

**Multi-index notation.** $\alpha = (\alpha_1,\dots,\alpha_d) \in \mathbb{N}^d$,
$|\alpha| = \alpha_1+\dots+\alpha_d$, $D^\alpha = D_1^{\alpha_1}\cdots D_d^{\alpha_d}$ with
$D_i = \partial/\partial x_i$, and $\xi^\alpha = \xi_1^{\alpha_1}\cdots\xi_d^{\alpha_d}$. Repeated indices
in expressions such as $a^{ij}D_{ij}u$ are summed.

**$K$ is the fundamental solution of the Laplacian** — the Newtonian kernel, with $\Delta_y K(x,y) = 0$ for
$y \ne x$ and the standard singularity at $y = x$. It is a specific function of $(x,y)$, not an arbitrary
kernel.

**The corrector $h$ and Green's function $G$.** For each $x \in \Omega$, $h(x,\cdot)$ is the harmonic
function in $\Omega$ with boundary values $K(x,\cdot)$; then $G(x,y) = K(x,y)-h(x,y)$ is harmonic in
$y \in \Omega\setminus\{x\}$ and vanishes for $y \in \partial\Omega$.

**The Poisson kernel is $H(x,y) = -\partial G(x,y)/\partial n_y$**, the **outward** normal derivative in the
second variable, with the minus sign. Both the direction of the normal and the sign are part of the
definition; reversing either flips the sign of the boundary term.

**$dS_y$** is surface measure on $\partial\Omega$.

**"Regular bounded domain"** means every boundary point admits a barrier, which is what makes the Dirichlet
problem solvable and the corrector $h$ exist.

**$u$ is a classical solution**: $C^2$ inside, continuous up to $\bar\Omega$, with $\Delta u = f$ in
$\Omega$ and $u = g$ on $\partial\Omega$. The conclusion holds at every interior point.
