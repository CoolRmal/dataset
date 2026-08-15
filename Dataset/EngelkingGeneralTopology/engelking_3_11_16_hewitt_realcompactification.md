# R. Engelking, *General Topology*, Theorem 3.11.16 (Hewitt realcompactification)

- **Source:** R. Engelking, *General Topology*
- **Domain:** Topology
- **Lean declaration:** `Dataset.EngelkingGeneralTopology.engelking_3_11_16_hewitt_realcompactification` ([engelking_3_11_16_hewitt_realcompactification.lean](engelking_3_11_16_hewitt_realcompactification.lean))
- **Criteria:** [engelking_3_11_16_hewitt_realcompactification.criteria.md](engelking_3_11_16_hewitt_realcompactification.criteria.md)
- **Context:** [engelking_3_11_16_hewitt_realcompactification.context.md](engelking_3_11_16_hewitt_realcompactification.context.md)

## Statement

**Definition.** A topological space $X$ is called a *realcompact space* if $X$ is a Tychonoff space and there is no Tychonoff space $\tilde X$ which satisfies:

1. **(RC1)** there exists a homeomorphic embedding $r \colon X \to \tilde X$ such that $r(X) \neq \overline{r(X)} = \tilde X$;
2. **(RC2)** for every continuous real-valued function $f \colon X \to \mathbb{R}$ there exists a continuous function $\tilde f \colon \tilde X \to \mathbb{R}$ such that $\tilde f r = f$.

**3.11.16. Theorem.** For every Tychonoff space $X$ there exists exactly one (up to a homeomorphism) realcompact space $\nu X$ which satisfies:

1. **(i)** there exists a homeomorphic embedding $\nu \colon X \to \nu X$ such that $\overline{\nu(X)} = \nu X$;
2. **(ii)** for every continuous real-valued function $f \colon X \to \mathbb{R}$ there exists a continuous function $f^{\nu} \colon \nu X \to \mathbb{R}$ such that $f^{\nu} \nu = f$.

The space $\nu X$ also satisfies:

3. **(iii)** for every continuous mapping $f \colon X \to Y$ of $X$ to a realcompact space $Y$ there exists a continuous mapping $f^{\nu} \colon \nu X \to Y$ such that $f^{\nu} \nu = f$.
