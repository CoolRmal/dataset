# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*, Exercise 1.1.3 (the integral of the Hessian determinant in the plane)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovSobolev.krylov_sobolev_1_1_3_hessian_determinant_integral` ([krylov_sobolev_1_1_3_hessian_determinant_integral.lean](krylov_sobolev_1_1_3_hessian_determinant_integral.lean))
- **Criteria:** [krylov_sobolev_1_1_3_hessian_determinant_integral.criteria.md](krylov_sobolev_1_1_3_hessian_determinant_integral.criteria.md)

## Statement

**Exercise 1.1.3.** By using the Fourier transform, prove that, if $d = 2$ and $u \in C_0^2$, then

$$\int_{\mathbb{R}^d} \det u_{xx}\,dx = 0.$$

**Notation.** $u_{xx} = (u_{x^ix^j})_{i,j=1}^d$ is the Hessian matrix of $u$, with $u_{x^ix^j} = D_{ij}u = D_jD_iu$ and $D_i = \partial/\partial x^i$; $\det u_{xx}$ is its determinant, so that for $d = 2$ it equals $u_{x^1x^1}u_{x^2x^2} - (u_{x^1x^2})^2$. $C_0^2$ is the set of twice continuously differentiable functions on $\mathbb{R}^d$ with compact support.
