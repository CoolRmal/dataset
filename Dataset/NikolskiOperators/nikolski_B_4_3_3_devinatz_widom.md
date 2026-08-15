# N. K. Nikolski, *Operators, Functions, and Systems: An Easy Reading*, Lemma 4.3.3 (Devinatz–Widom criterion)

- **Source:** N. K. Nikolski, *Operators, Functions, and Systems: An Easy Reading*, Volume 1: Hardy, Hankel, and Toeplitz (Part B)
- **Domain:** Operator theory
- **Lean declaration:** `Dataset.NikolskiOperators.nikolski_B_4_3_3_devinatz_widom` ([nikolski_B_4_3_3_devinatz_widom.lean](nikolski_B_4_3_3_devinatz_widom.lean))
- **Criteria:** [nikolski_B_4_3_3_devinatz_widom.criteria.md](nikolski_B_4_3_3_devinatz_widom.criteria.md)
- **Context:** [nikolski_B_4_3_3_devinatz_widom.context.md](nikolski_B_4_3_3_devinatz_widom.context.md)

## Statement

**4.3.3. Lemma.** Let $u \in L^\infty(\mathbb{T})$ be such that $|u| = 1$ a.e. on $\mathbb{T}$. The following are equivalent.

1. $T_u$ is invertible.
2. $\operatorname{dist}(u, H^\infty) < 1$, $\operatorname{dist}(\bar{u}, H^\infty) < 1$.
3. There exists an outer function $h \in H^\infty$ such that $\|u - h\|_\infty < 1$.
4. There exist real valued bounded functions $a, b$ and a constant $c \in \mathbb{R}$ such that $u = e^{i(c + a + \tilde{b})}$ and $\|a\|_\infty < \pi/2$.

**3.9.7. Definition.** Let $f \in H^p$, $p > 0$. The function $[f]$ is called the *outer part* of $f$, and $\lambda B S$ is called the *inner part* of $f$. A function $f \in H^p$ which is equal to its outer part (up to a multiplicative constant of modulus $1$), $f = \lambda [f]$, will simply be called *outer*.
