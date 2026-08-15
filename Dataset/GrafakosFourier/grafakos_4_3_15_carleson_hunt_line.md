# L. Grafakos, *Classical Fourier Analysis*, Theorem 4.3.15 (the Carleson–Hunt theorem: $L^p$ bounds for the Carleson operator on the line)

- **Source:** L. Grafakos, *Classical Fourier Analysis*
- **Domain:** Fourier analysis
- **Lean declaration:** `Dataset.GrafakosFourier.grafakos_4_3_15_carleson_hunt_line` ([grafakos_4_3_15_carleson_hunt_line.lean](grafakos_4_3_15_carleson_hunt_line.lean))
- **Criteria:** [grafakos_4_3_15_carleson_hunt_line.criteria.md](grafakos_4_3_15_carleson_hunt_line.criteria.md)
- **Context:** [grafakos_4_3_15_carleson_hunt_line.context.md](grafakos_4_3_15_carleson_hunt_line.context.md)

## Statement

**Theorem 4.3.15.** For every $1 < p < \infty$ there exists a finite constant $C_p$ such that for all $f \in C_0^\infty(\mathbb{R})$ we have
$$\|\mathcal{C}^{**}(f)\|_{L^p(\mathbb{R})} \le C_p \|f\|_{L^p(\mathbb{R})},$$
where
$$\mathcal{C}^{**}(f)(x) = \sup_{R > 0} \left| \int_{|\xi| \le R} \widehat{f}(\xi)\, e^{2\pi i x \xi} \, d\xi \right|$$
is the Carleson operator.
