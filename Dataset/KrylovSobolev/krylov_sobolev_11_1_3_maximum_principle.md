# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*, Theorem 11.1.3 (the maximum principle)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovSobolev.krylov_sobolev_11_1_3_maximum_principle` ([krylov_sobolev_11_1_3_maximum_principle.lean](krylov_sobolev_11_1_3_maximum_principle.lean))
- **Criteria:** [krylov_sobolev_11_1_3_maximum_principle.criteria.md](krylov_sobolev_11_1_3_maximum_principle.criteria.md)

## Statement

**Theorem 11.1.3 (Maximum principle).** Let $\Omega$ be a bounded domain, $c \le 0$. If $u \in C^2_{\mathrm{loc}}(\Omega) \cap C(\bar{\Omega})$ and $Lu \ge 0$ in $\Omega$, then

$$u \le \max_{\partial\Omega} u_+ \tag{1}$$

holds in $\Omega$.

**Notation.** Throughout Chapter 11 we deal with operators of the type

$$L = a^{ij}D_{ij} + b^iD_i + c,$$

with the summation convention in force. By Definition 1.4.1, $a^{ij}(x), b^i(x), c(x)$ are real-valued measurable functions on $\mathbb{R}^d$ with $a^{ij} = a^{ji}$, and $L$ is a *second-order elliptic differential operator* if there is a constant $\kappa > 0$, called *a constant of ellipticity*, such that for all $x,\xi \in \mathbb{R}^d$

$$\kappa^{-1}|\xi|^2 \ge a^{ij}(x)\xi^i\xi^j \ge \kappa|\xi|^2;$$

by Assumption 1.6.1 the coefficients are in addition bounded: $|a^{ij}(x)|, |b^i(x)|, |c(x)| \le K$. (As is observed at the start of Section 11.1, the uniform continuity of $a^{ij}$, which is also part of Assumption 1.6.1, is not used in this section.) The condition "$c \le 0$" is the condition $L1 = c \le 0$. By domains we mean general open sets, $a_+ = \frac12(|a| + a)$, and $C^2_{\mathrm{loc}}(\Omega) \cap C(\bar\Omega)$ is the set of functions twice continuously differentiable in $\Omega$ and continuous on $\bar\Omega$.
