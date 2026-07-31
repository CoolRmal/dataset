# Bogachev, *Measure Theory*, Definition 3.6.8 and Theorem 3.6.9

- **Source:** V. I. Bogachev, *Measure Theory*, Volume I
- **Domain:** Measure theory
- **Lean declaration:** `Dataset.Bogachev.hasLusinPropertyN_iff_maps_nullMeasurableSet` ([hasLusinPropertyN_iff_maps_nullMeasurableSet.lean](hasLusinPropertyN_iff_maps_nullMeasurableSet.lean))
- **Criteria:** [hasLusinPropertyN_iff_maps_nullMeasurableSet.criteria.md](hasLusinPropertyN_iff_maps_nullMeasurableSet.criteria.md)

## Statement

**3.6.8. Definition.** Let $F \colon X \to Y$ be a mapping between measure spaces $(X, \mathcal{A}, \mu)$ and $(Y, \mathcal{B}, \nu)$. We shall say that $F$ has *Lusin's property (N)* with respect to the pair $(\mu, \nu)$ if

$$\nu(F(A)) = 0 \quad \text{for every set } A \in \mathcal{A} \text{ with } \mu(A) = 0.$$

**3.6.9. Theorem.** Let $F \colon \mathbb{R}^n \to \mathbb{R}^n$ be a Lebesgue measurable mapping. Then $F$ has Lusin's property (N) with respect to Lebesgue measure precisely when $F$ takes all Lebesgue measurable sets to Lebesgue measurable sets.
