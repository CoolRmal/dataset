# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*, Theorem 10.2.1 (Morrey's theorem)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovSobolev.krylov_sobolev_10_2_1_morrey_embedding` ([krylov_sobolev_10_2_1_morrey_embedding.lean](krylov_sobolev_10_2_1_morrey_embedding.lean))
- **Criteria:** [krylov_sobolev_10_2_1_morrey_embedding.criteria.md](krylov_sobolev_10_2_1_morrey_embedding.criteria.md)

## Statement

**Theorem 10.2.1 (Morrey).** Let $\Omega$ be a bounded convex domain in $\mathbb{R}^d$ satisfying condition (10.1.1) with a constant $\kappa < \infty$. Let $M < \infty$, $\alpha \in (0,1]$ be some constants. Finally, let $u, u_x \in \mathcal{L}_1(\Omega)$ and assume that for any ball $B \subset \Omega$ we have

$$\fint_B |u_x|\,dx \le M r_B^{\alpha-1}, \tag{1}$$

where $r_B$ is the radius of $B$. Then for any $x, y \in \Omega$ we have

$$|u(x) - u(y)| \le NM|x-y|^\alpha, \tag{2}$$

$$|u(x)| \le NM + \sup_{y \in \Omega} \fint_{\Omega \cap B_1(y)} |u(z)|\,dz, \tag{3}$$

where $N$ depends only on $d$, $\alpha$, and $\kappa$. In particular, if $p > d$ and $u, u_x \in \mathcal{L}_p(\Omega)$, then (2) and (3) hold with

$$\alpha = 1 - d/p, \qquad M = \|u_x\|_{\mathcal{L}_p(\Omega)}$$

and $N$ depending only on $d$, $p$, and $\kappa$.

**Notation.** For an open convex set $\Omega$ we denote by $\rho(\Omega)$ its *interior diameter*, which is the largest diameter of open balls contained in $\Omega$; $B_r(x)$ is the open ball of radius $r$ centred at $x$. Condition (10.1.1) is

$$\operatorname{diam}\Omega \le \kappa\,\rho(\Omega). \tag{10.1.1}$$

By $|\Gamma|$ we denote the volume of $\Gamma \subset \mathbb{R}^d$, and $\fint_A g\,dx = |A|^{-1}\int_A g\,dx$. The derivatives $u_x$ are generalized (Sobolev) derivatives. As is explained in the proof, the assertion is that there is a *modification* of $u$ (a function equal to $u$ almost everywhere) satisfying (2) and (3).
