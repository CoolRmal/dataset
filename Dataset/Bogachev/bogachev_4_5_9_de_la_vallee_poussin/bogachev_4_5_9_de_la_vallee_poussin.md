# Bogachev, *Measure Theory*, Theorem 4.5.9 (de la Vallée Poussin criterion)

- **Source:** V. I. Bogachev, *Measure Theory*, Volume I
- **Domain:** Measure theory
- **Lean declaration:** `Dataset.Bogachev.bogachev_4_5_9_de_la_vallee_poussin` ([bogachev_4_5_9_de_la_vallee_poussin.lean](bogachev_4_5_9_de_la_vallee_poussin.lean))
- **Criteria:** [bogachev_4_5_9_de_la_vallee_poussin.criteria.md](bogachev_4_5_9_de_la_vallee_poussin.criteria.md)
- **Context:** [bogachev_4_5_9_de_la_vallee_poussin.context.md](bogachev_4_5_9_de_la_vallee_poussin.context.md)

## Statement

**4.5.9. Theorem.** Let $\mu$ be a finite nonnegative measure. A family $\mathcal{F}$ of $\mu$-integrable functions is uniformly integrable if and only if there exists a nonnegative increasing function $G$ on $[0, +\infty)$ such that

$$\lim_{t \to +\infty} \frac{G(t)}{t} = \infty \quad \text{and} \quad \sup_{f \in \mathcal{F}} \int G(|f(x)|) \, \mu(dx) < \infty.$$

In such a case, one can choose a convex increasing function $G$.
