# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*, Theorem 2.3.1 (Green–Poisson representation formula)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovHolder.krylov_2_3_1_green_poisson_representation` ([krylov_2_3_1_green_poisson_representation.lean](krylov_2_3_1_green_poisson_representation.lean))
- **Criteria:** [krylov_2_3_1_green_poisson_representation.criteria.md](krylov_2_3_1_green_poisson_representation.criteria.md)

## Statement

**Theorem 2.3.1.** Let $\Omega$ be a regular bounded domain. Assume that for any $x \in \Omega$ there exists a function $h(x,\cdot) \in C^2(\Omega)$ such that

$$\Delta_y h(x,y) = 0 \quad \text{in } \Omega, \qquad h(x,y) = K(x,y) \quad \text{for } y \in \partial\Omega .$$

Define the Green's function

$$G(x,y) = K(x,y) - h(x,y),$$

so that, in particular, $\Delta_y G(x,y) = 0$ in $\Omega \setminus \{x\}$ and $G(x,y) = 0$ for $y \in \partial\Omega$. Then for any $C^2(\Omega)$-solution $u$ of the Dirichlet problem (2.3.1) and $x \in \Omega$ we have

$$u(x) = \int_\Omega G(x,y) f(y)\,dy + \int_{\partial\Omega} H(x,y) g(y)\,dS_y ,$$

where

$$H(x,y) := -\frac{\partial G(x,y)}{\partial n_y}, \qquad x \in \Omega,\ y \in \partial\Omega,$$

is the so-called Poisson kernel.

**Notation.** The Dirichlet problem (2.3.1) is

$$\Delta u = f \quad \text{in } \Omega, \qquad u = g \quad \text{on } \partial\Omega ,$$

and a $C^2(\Omega)$-solution of it is a function $u$ that is twice continuously differentiable in $\Omega$, continuous on $\bar\Omega$, and satisfies both relations pointwise.

**Notation.** $K(x,y)$ is the fundamental solution of the Laplace operator on $\mathbb{R}^d$, that is, the kernel — a constant multiple of $|x-y|^{2-d}$ for $d \ge 3$, of $\log|x-y|$ for $d = 2$ — normalized so that $\Delta_y K(x,\cdot) = \delta_x$ in the sense of distributions. Further, $n_y$ is the outward unit normal to $\partial\Omega$ at $y$, $\partial/\partial n_y$ the corresponding (inward-limit) normal derivative, and $dS_y$ the surface measure, i.e. the $(d-1)$-dimensional Hausdorff measure, on $\partial\Omega$.

**Notation.** A bounded domain $\Omega \subset \mathbb{R}^d$ is *regular* if at every $z \in \partial\Omega$ there is a barrier: a function $b$ continuous on $\bar\Omega$ with $b(z) = 0$, $b > 0$ on $\bar\Omega \setminus \{z\}$, and $\Delta b \le 0$ in $\Omega$.
