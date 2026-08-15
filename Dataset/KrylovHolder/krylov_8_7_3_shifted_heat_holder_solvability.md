# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*, Theorem 8.7.3 (whole-space solvability for the shifted heat equation)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovHolder.krylov_8_7_3_shifted_heat_holder_solvability` ([krylov_8_7_3_shifted_heat_holder_solvability.lean](krylov_8_7_3_shifted_heat_holder_solvability.lean))
- **Criteria:** [krylov_8_7_3_shifted_heat_holder_solvability.criteria.md](krylov_8_7_3_shifted_heat_holder_solvability.criteria.md)
- **Context:** [krylov_8_7_3_shifted_heat_holder_solvability.context.md](krylov_8_7_3_shifted_heat_holder_solvability.context.md)

## Statement

**Theorem 8.7.3.** For any $f \in C^{\delta/2,\,\delta}(\mathbb{R}^{d+1})$ there exists a unique function $u \in C^{1+\delta/2,\,2+\delta}(\mathbb{R}^{d+1})$ satisfying the equation

$$\Delta u - u_t - u = f \quad \text{in } \mathbb{R}^{d+1}.$$

**Notation (parabolic Hölder spaces).** Points of $\mathbb{R}^{d+1}$ are written $(t,x)$ with $t \in \mathbb{R}$, $x \in \mathbb{R}^d$; $u_t = \partial_t u$ and $\Delta = \sum_{i=1}^d D_{ii}$ acts in the space variables only. For $0 < \delta < 1$, the anisotropic parabolic Hölder space $C^{\delta/2,\,\delta}(\mathbb{R}^{d+1})$ consists of the functions that are $\delta$-Hölder in $x$ and $(\delta/2)$-Hölder in $t$, and $C^{1+\delta/2,\,2+\delta}(\mathbb{R}^{d+1})$ of the functions $u$ for which $u$, $D_x u$, $D^2_x u$ and $u_t$ exist and are bounded, with $D^2_x u$ and $u_t$ being $\delta$-Hölder in $x$ and $(\delta/2)$-Hölder in $t$; the parabolic scaling assigns weight $1$ to a space direction and weight $1/2$ to the time direction, so that $2 + \delta$ derivatives in $x$ correspond to $1 + \delta/2$ derivatives in $t$.
