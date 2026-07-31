# Bogachev, *Measure Theory*, Theorem 10.5.4 (existence of liftings)

- **Source:** V. I. Bogachev, *Measure Theory*, Volume II
- **Domain:** Measure theory
- **Lean declaration:** `Dataset.Bogachev.bogachev_10_5_4_lifting` ([bogachev_10_5_4_lifting.lean](bogachev_10_5_4_lifting.lean))
- **Criteria:** [bogachev_10_5_4_lifting.criteria.md](bogachev_10_5_4_lifting.criteria.md)

## Statement

**10.5.4. Theorem.** For every complete probability measure $\mu$, there exists a lifting on $\mathcal{L}^\infty(\mu)$.

**10.5.1. Definition.** Let $(X, \mathcal{A}, \mu)$ be a measurable space with a nonnegative measure $\mu$ (possibly with values in $[0, +\infty]$) and let $\mathcal{L}^\infty_{\mathcal{A}}$ be the space of all bounded $\mathcal{A}$-measurable functions. A *lifting* on $\mathcal{L}^\infty_{\mathcal{A}}$ is a mapping $L \colon \mathcal{L}^\infty_{\mathcal{A}} \to \mathcal{L}^\infty_{\mathcal{A}}$ satisfying the following conditions:

1. $L(f) = f$ $\mu$-a.e.;
2. $L(f)(x) = L(g)(x)$ for all $x \in X$ if $f = g$ $\mu$-a.e.;
3. $L(f)(x) = 1$ for all $x \in X$ if $f = 1$ $\mu$-a.e.;
4. $L(\alpha f + \beta g)(x) = \alpha L(f)(x) + \beta L(g)(x)$ for all $x \in X$, $f, g \in \mathcal{L}^\infty_{\mathcal{A}}$ and $\alpha, \beta \in \mathbb{R}^1$;
5. $L(fg)(x) = L(f)(x) L(g)(x)$ for all $x \in X$, $f, g \in \mathcal{L}^\infty_{\mathcal{A}}$.
