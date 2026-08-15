# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*, Exercise 1.4.8 (a priori $\mathcal{L}_2$ estimate in the plane)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovSobolev.krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate` ([krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate.lean](krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate.lean))
- **Criteria:** [krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate.criteria.md](krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate.criteria.md)
- **Context:** [krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate.context.md](krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate.context.md)

## Statement

**Exercise 1.4.8.** Let $d = 2$, $a^{ij}(x)$ be measurable functions on $\mathbb{R}^2$ satisfying $a^{ij} = a^{ji}$ and condition (5) for all $x, \xi \in \mathbb{R}^2$, where $\mu > 0$ and $\nu > 0$ are some constants. For a $\lambda > 0$ define

$$Lu = L_\lambda u = a^{ij}u_{x^ix^j} - \lambda(a^{11} + a^{22})u.$$

Prove that, for any $u \in C_0^2$,

$$\lambda^2\|u\|^2_{\mathcal{L}_2} + 2\lambda\sum_{j=1}^2\|u_{x^j}\|^2_{\mathcal{L}_2} + \sum_{j,k=1}^2\|u_{x^jx^k}\|^2_{\mathcal{L}_2} \le \frac{\nu^2}{\mu^4}\|Lu\|^2_{\mathcal{L}_2}. \tag{6}$$

**Notation.** Condition (5), from Exercise 1.4.7, is the two-sided ellipticity bound

$$\mu|\xi|^2 \le a^{ij}\xi^i\xi^j \le \nu|\xi|^2 \tag{5}$$

for all $\xi \in \mathbb{R}^2$. For an integer $k \ge 0$, $C_0^k$ denotes the $C^k$ functions on $\mathbb{R}^d$ that vanish for $|x|$ sufficiently large, and $C_0^\infty$ the infinitely differentiable ones. Subscripts denote partial derivatives: $u_{x^i} = D_iu$ and $u_{x^ix^j} = D_{ij}u$. Repeated indices are summed. $\mathcal{L}_p = \mathcal{L}_p(\mathbb{R}^d)$ is taken with respect to Lebesgue measure.
