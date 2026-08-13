# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*, Exercise 1.3.23 (i)–(ii) (a Dirichlet estimate on the ball, and a polynomial operator)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovSobolev.krylov_sobolev_1_3_23_unit_ball_estimate_and_polynomial_operator_bijective` ([krylov_sobolev_1_3_23_unit_ball_estimate_and_polynomial_operator_bijective.lean](krylov_sobolev_1_3_23_unit_ball_estimate_and_polynomial_operator_bijective.lean))
- **Criteria:** [krylov_sobolev_1_3_23_unit_ball_estimate_and_polynomial_operator_bijective.criteria.md](krylov_sobolev_1_3_23_unit_ball_estimate_and_polynomial_operator_bijective.criteria.md)

## Statement

**Exercise 1.3.23.** (i) Let $B$ be the open unit ball centered at the origin and let $u$ be a twice continuously differentiable function on $\bar{B}$. Assume that $u = 0$ on $\partial B$. Set $f = \Delta u$ and prove that

$$\|u\|^2_{\mathcal{L}_2(B)} + \sum_i\|u_{x^i}\|^2_{\mathcal{L}_2(B)} \le 4\|f\|^2_{\mathcal{L}_2(B)}.$$

(ii) Given an integer $n$, denote by $P_n$ the set of polynomials of $x$ of degree $\le n$ and let $A$ be the operator $A : P_n \to P_n$ given by the formula

$$Ap = \Delta[(1 - |x|^2)p].$$

Conclude from (i) that $A$ is invertible.

**Notation.** Part (iii) of the exercise, which needs $W_2^2(B)$, is not formalized. $\Delta u = u_{x^1x^1} + \dots + u_{x^dx^d}$ is the Laplacian, and "degree $\le n$" means total degree in the $d$ variables. For an integer $k \ge 0$, $C_0^k$ denotes the $C^k$ functions on $\mathbb{R}^d$ that vanish for $|x|$ sufficiently large, and $C_0^\infty$ the infinitely differentiable ones. Subscripts denote partial derivatives: $u_{x^i} = D_iu$ and $u_{x^ix^j} = D_{ij}u$. Repeated indices are summed. $\mathcal{L}_p = \mathcal{L}_p(\mathbb{R}^d)$ is taken with respect to Lebesgue measure.
