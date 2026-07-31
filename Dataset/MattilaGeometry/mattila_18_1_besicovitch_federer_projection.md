# P. Mattila, *Geometry of Sets and Measures in Euclidean Spaces*, Theorem 18.1 (Besicovitch–Federer projection theorem)

- **Source:** P. Mattila, *Geometry of Sets and Measures in Euclidean Spaces*
- **Domain:** Geometric measure theory
- **Lean declaration:** `Dataset.MattilaGeometry.mattila_18_1_besicovitch_federer_projection` ([mattila_18_1_besicovitch_federer_projection.lean](mattila_18_1_besicovitch_federer_projection.lean))
- **Criteria:** [mattila_18_1_besicovitch_federer_projection.criteria.md](mattila_18_1_besicovitch_federer_projection.criteria.md)

## Statement

**15.3. Definition.** A set $E \subset \mathbb{R}^n$ is called *$m$-rectifiable* if there exist Lipschitz maps $f_i : \mathbb{R}^m \to \mathbb{R}^n$, $i = 1, 2, \ldots$, such that

$$\mathcal{H}^m\Big(E \setminus \bigcup_i f_i(\mathbb{R}^m)\Big) = 0.$$

A set $F \subset \mathbb{R}^n$ is called *purely $m$-unrectifiable* if $\mathcal{H}^m(E \cap F) = 0$ for every $m$-rectifiable set $E$.

**18.1. Theorem.** Let $A$ be an $\mathcal{H}^m$ measurable subset of $\mathbb{R}^n$ with $\mathcal{H}^m(A) < \infty$.

1. $A$ is $m$-rectifiable if and only if $\mathcal{H}^m(P_V B) > 0$ for $\gamma_{n,m}$ almost all $V \in G(n,m)$ whenever $B$ is an $\mathcal{H}^m$ measurable subset of $A$ with $\mathcal{H}^m(B) > 0$.
2. $A$ is purely $m$-unrectifiable if and only if $\mathcal{H}^m(P_V A) = 0$ for $\gamma_{n,m}$ almost all $V \in G(n,m)$.
