# Context: krylov_2_3_1_green_poisson_representation

**Statement:** [krylov_2_3_1_green_poisson_representation.md](krylov_2_3_1_green_poisson_representation.md) · **Criteria:** [krylov_2_3_1_green_poisson_representation.criteria.md](krylov_2_3_1_green_poisson_representation.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation

$K$ is the fundamental solution of the Laplacian, normalized so that $\Delta_y K(x,\cdot) = \delta_x$ — Krylov works with the positive Laplacian, not $-\Delta$. Accordingly the Poisson kernel is the **outward** normal derivative of $G$ in the **second** variable with **no** minus sign, $H = \partial G/\partial n_y$; do not import the minus sign that texts built on $-\Delta$ would attach. "Regular bounded domain" is the standing notion of Krylov's Chapter 2: a bounded domain regular enough for integration by parts, i.e. Green's identities hold for every pair of functions of class $C^2$ up to the closure. It is **not** the barrier (Perron-method) notion of regularity used later in the book, in Chapter 7.6; the two notions are inequivalent. Finally, $C^2(\bar\Omega)$ means derivatives through second order continuous and bounded on the closed domain — both the corrector $h(x,\cdot)$ and the solution $u$ are of this class, which is strictly more than being $C^2$ inside and merely continuous up to the boundary.
