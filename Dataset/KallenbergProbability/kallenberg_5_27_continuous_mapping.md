# O. Kallenberg, *Foundations of Modern Probability*, Theorem 5.27 (continuous mapping; Mann & Wald, Prohorov, Rubin)

- **Source:** O. Kallenberg, *Foundations of Modern Probability*
- **Domain:** Probability
- **Lean declaration:** `Dataset.KallenbergProbability.kallenberg_5_27_continuous_mapping` ([kallenberg_5_27_continuous_mapping.lean](kallenberg_5_27_continuous_mapping.lean))
- **Criteria:** [kallenberg_5_27_continuous_mapping.criteria.md](kallenberg_5_27_continuous_mapping.criteria.md)

## Statement

**Theorem 5.27 (continuous mapping; Mann & Wald, Prohorov, Rubin).** For any metric spaces $S, T$ and set $C \subset S$, consider some measurable functions $f, f_1, f_2, \dots : S \to T$ satisfying

$$s_n \to s \in C \ \Rightarrow\ f_n(s_n) \to f(s).$$

Then for any random elements $\xi, \xi_1, \xi_2, \dots$ in $S$,

$$\xi_n \xrightarrow{d} \xi \in C \text{ a.s.} \ \Rightarrow\ f_n(\xi_n) \xrightarrow{d} f(\xi).$$

In particular, we see that if $f : S \to T$ is a.s. continuous at $\xi$, then $\xi_n \xrightarrow{d} \xi \Rightarrow f(\xi_n) \xrightarrow{d} f(\xi)$.
