# Bogachev, *Measure Theory*, Proposition 5.5.4

- **Source:** V. I. Bogachev, *Measure Theory*, Volume I
- **Domain:** Analysis
- **Lean declaration:** `Dataset.Bogachev.proposition_5_5_4` ([proposition_5_5_4.lean](proposition_5_5_4.lean))
- **Criteria:** [proposition_5_5_4.criteria.md](proposition_5_5_4.criteria.md)

## Statement

**5.5.4. Proposition.** Let $f$ be a function on the real line and let $E$ be a measurable set such that at every point of $E$ the function $f$ is differentiable. Then

$$\lambda\bigl(f(E)\bigr) \le \int_E |f'(x)| \, dx.$$

In particular, the function $f$ on $E$ has Lusin's property (N). If for all $x \in E$ we have $|f'(x)| \le L$, then

$$\lambda\bigl(f(E)\bigr) \le L \, \lambda(E).$$
