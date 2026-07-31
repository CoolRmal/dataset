# N. K. Nikolski, *Operators, Functions, and Systems: An Easy Reading*, Theorem 5.4.1 (Helson–Szegő)

- **Source:** N. K. Nikolski, *Operators, Functions, and Systems: An Easy Reading*, Volume 1: Hardy, Hankel, and Toeplitz (Part A)
- **Domain:** Harmonic analysis
- **Lean declaration:** `Dataset.NikolskiOperators.nikolski_A_5_4_helson_szego` ([nikolski_A_5_4_helson_szego.lean](nikolski_A_5_4_helson_szego.lean))
- **Criteria:** [nikolski_A_5_4_helson_szego.criteria.md](nikolski_A_5_4_helson_szego.criteria.md)

## Statement

**5.4.1. Theorem.** Let $\mu$ be a finite Borel measure on $\mathbb{T}$. The following assertions are equivalent.

1. The family $(z^n)_{n \in \mathbb{Z}}$ is a (symmetric or non-symmetric) basis of $L^2(\mu)$.
2. The Riesz projection $P_+$ is bounded on $L^2(\mu)$.
3. $\sin(\mathrm{Pol}_+, \mathrm{Pol}_-) > 0$.
4. $d\mu = |h|^2 \, dm$ where $h \in H^2$ is an outer function such that $\operatorname{dist}(\bar{h}/h, H^\infty) < 1$.
5. $d\mu = w \, dm$ where $w = e^{u + \tilde{v}}$ and $u, v$ are real valued bounded functions and $\|v\|_\infty < \pi/2$ (condition (HS)).
