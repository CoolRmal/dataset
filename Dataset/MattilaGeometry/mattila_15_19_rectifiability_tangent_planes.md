# P. Mattila, *Geometry of Sets and Measures in Euclidean Spaces*, Theorem 15.19 (rectifiability and approximate tangent planes)

- **Source:** P. Mattila, *Geometry of Sets and Measures in Euclidean Spaces*
- **Domain:** Geometric measure theory
- **Lean declaration:** `Dataset.MattilaGeometry.mattila_15_19_rectifiability_tangent_planes` ([mattila_15_19_rectifiability_tangent_planes.lean](mattila_15_19_rectifiability_tangent_planes.lean))
- **Criteria:** [mattila_15_19_rectifiability_tangent_planes.criteria.md](mattila_15_19_rectifiability_tangent_planes.criteria.md)
- **Context:** [mattila_15_19_rectifiability_tangent_planes.context.md](mattila_15_19_rectifiability_tangent_planes.context.md)

## Statement

**15.3. Definition.** A set $E \subset \mathbb{R}^n$ is called *$m$-rectifiable* if there exist Lipschitz maps $f_i : \mathbb{R}^m \to \mathbb{R}^n$, $i = 1, 2, \ldots$, such that

$$\mathcal{H}^m\Big(E \setminus \bigcup_i f_i(\mathbb{R}^m)\Big) = 0.$$

**15.7. Definition.** We say that a subset $E$ of $\mathbb{R}^n$ is *$m$-linearly approximable* if for $\mathcal{H}^m$ almost all $a \in E$ the following holds: if $\eta$ is a positive number, there are positive numbers $r_0$ and $\lambda$ and an affine $m$-plane $W$ such that $a \in W$ and for any $0 < r < r_0$,

$$\mathcal{H}^m(E \cap B(x, \eta r)) \ge \lambda r^m \quad \text{for } x \in W \cap B(a,r),$$

and

$$\mathcal{H}^m(E \cap B(a,r) \setminus W(\eta r)) < \eta r^m.$$

**15.17. Definition.** Let $A \subset \mathbb{R}^n$, $a \in \mathbb{R}^n$ and $V \in G(n,m)$. We say that $V$ is an *approximate tangent $m$-plane* for $A$ at $a$ if $\Theta^{*m}(A, a) > 0$ and for all $0 < s < 1$,

$$r^{-m}\,\mathcal{H}^m\big(A \cap B(a,r) \setminus X(a,V,s)\big) \to 0 \quad \text{as } r \downarrow 0.$$

**15.19. Theorem.** Let $E$ be an $\mathcal{H}^m$ measurable subset of $\mathbb{R}^n$ with $\mathcal{H}^m(E) < \infty$. Then the following are equivalent:

1. $E$ is $m$-rectifiable.
2. $E$ is $m$-linearly approximable.
3. For $\mathcal{H}^m$ almost all $a \in E$ there is a unique approximate tangent $m$-plane for $E$ at $a$.
4. For $\mathcal{H}^m$ almost all $a \in E$ there is some approximate tangent $m$-plane for $E$ at $a$.
