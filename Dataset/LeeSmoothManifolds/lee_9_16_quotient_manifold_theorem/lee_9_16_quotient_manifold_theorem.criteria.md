# Criteria: lee_9_16_quotient_manifold_theorem

**Statement:** [lee_9_16_quotient_manifold_theorem.md](lee_9_16_quotient_manifold_theorem.md) · **Lean:** [lee_9_16_quotient_manifold_theorem.lean](lee_9_16_quotient_manifold_theorem.lean) · **Context:** [lee_9_16_quotient_manifold_theorem.context.md](lee_9_16_quotient_manifold_theorem.context.md)

## What the theorem says

Let a Lie group $G$ of dimension $g$ act on a smooth manifold $M$ of dimension $m$, and suppose the
action is smooth, free (only the identity fixes any point) and proper. Then the set of orbits
$M/G$ can be made into a manifold of dimension $m - g$, and there is exactly one smooth structure on
it for which the map sending each point to its orbit is a smooth submersion. "Exactly one" means:
any other manifold with a projection having the same properties is diffeomorphic to this one by a
diffeomorphism that respects the two projections.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $G$ is a Lie group of dimension $g$: a group that is also a smooth manifold with smooth multiplication and inversion. | ✅ `[Group G]`, `[ChartedSpace (Fin g → ℝ) G]`, `[LieGroup 𝓘(ℝ, Fin g → ℝ) ∞ G]`. `LieGroup` extends `ContMDiffMul`, which extends `IsManifold`, so no separate `IsManifold` instance is needed. |
| 2 | $M$ is a smooth manifold of dimension $m$ without boundary. | ✅ `[ChartedSpace (Fin m → ℝ) M]` and `[IsManifold 𝓘(ℝ, Fin m → ℝ) ∞ M]`. |
| 3 | `act` really is a group action: the identity acts trivially and the action is compatible with multiplication. | ✅ Inside `SmoothFreeProperAction`: `∀ x, act 1 x = x` and `∀ a b x, act (a * b) x = act a (act b x)`. |
| 4 | The action is smooth **jointly** in the group element and the point. | ✅ `ContMDiff (𝓘(ℝ, Fin g → ℝ).prod 𝓘(ℝ, Fin m → ℝ)) 𝓘(ℝ, Fin m → ℝ) ∞ (fun p : G × M ↦ act p.1 p.2)`. |
| 5 | The action is free. | ✅ `∀ a x, act a x = x → a = 1`. |
| 6 | The action is proper: the map $(a,x) \mapsto (a \cdot x, x)$ from $G \times M$ to $M \times M$ is a proper map. | ✅ `IsProperMap fun p : G × M ↦ (act p.1 p.2, p.2)`. |
| 7 | The conclusion produces a *type* $Q$ carrying a topology, a charted-space structure over $\mathbb{R}^{m-g}$, and a smooth-manifold structure — Mathlib has no quotient-manifold construction to appeal to. | ✅ `∃ (Q : Type v) (_ : TopologicalSpace Q) (_ : ChartedSpace (Fin (m - g) → ℝ) Q) (_ : IsManifold 𝓘(ℝ, Fin (m - g) → ℝ) ∞ Q)`. The dimension is $m - g$ as the theorem requires. |
| 8 | A projection $\pi : M \to Q$ that is surjective and whose fibres are exactly the orbits. | ✅ `Surjective π` and `∀ x y, π x = π y ↔ ∃ a, act a x = y`. The `↔` is essential in both directions. |
| 9 | $\pi$ is a smooth submersion. | ✅ `Manifold.IsSubmersion 𝓘(ℝ, Fin m → ℝ) 𝓘(ℝ, Fin (m - g) → ℝ) ∞ π`. |
| 10 | Uniqueness of the smooth structure: any other $Q'$ with the same kind of structure and a projection $\pi'$ that is surjective, orbit-separating and a smooth submersion is related to $Q$ by a diffeomorphism $e$ with $e \circ \pi = \pi'$. | ✅ The whole trailing `∀ (Q' : Type v) …` block, concluding `∃ e : Diffeomorph … Q Q' ∞, e ∘ π = π'`. |
| 11 | The quotient $M/G$ is Hausdorff (and second countable) — for Lee this is part of being a topological manifold, and separating orbits is the substantive job that properness does. | ✅ `T2Space Q` and `SecondCountableTopology Q` are among the existentially produced instances, with `[T2Space M]` and `[SecondCountableTopology M]` as hypotheses. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Dropping properness. | The theorem is then false. The irrational-slope line acting on the torus $T^2$ is a smooth free action whose orbit space is not a manifold — it is not even Hausdorff. |
| 2 | Assuming properness of the action map `act` itself, rather than of $(a,x) \mapsto (a\cdot x, x)$. | These are not equivalent. The twisted map is what "proper action" means; properness of `act` alone is a different and insufficient condition. |
| 3 | Asserting that each $a \cdot (-) : M \to M$ is smooth for fixed $a$, instead of joint smoothness on $G \times M$. | Strictly weaker. A "smooth action" in Lee's sense is smooth as a map $G \times M \to M$, and the proof uses smoothness in the group direction. |
| 4 | Leaving out the group-action axioms and treating `act` as an arbitrary function $G \to M \to M$. | Then the "orbits" $\{y \mid \exists a, act\ a\ x = y\}$ need not partition $M$, and the fibre condition is not an equivalence relation. |
| 5 | Stating the fibre condition as a one-way implication, `π x = π y → ∃ a, act a x = y` or its converse. | Only one direction each. The converse alone permits $Q$ to be a single point with $\pi$ constant; the forward direction alone permits $\pi$ injective. Both fail to say "the fibres are the orbits". |
| 6 | Omitting the uniqueness clause. | It is the second half of the printed sentence and the harder half. Without it the theorem is just "some manifold structure exists". |
| 7 | Weakening `Diffeomorph` to `Homeomorph` or `Equiv` in the uniqueness clause. | Uniqueness is asserted of the *smooth* structure. A homeomorphism respecting the projections does not identify the smooth structures. |
| 8 | Dropping the submersion requirement on $\pi$ and asking only that $\pi$ be smooth, or continuous. | The smooth structure is only unique among those making $\pi$ a submersion; without that qualifier the uniqueness claim is false. |

## Notes on the ground truth

- No separate "$Q$ carries the quotient topology" clause is needed: a surjective submersion is
  continuous and open, hence a quotient map, so the topology on $Q$ is pinned down.
- The diffeomorphism $e$ in the uniqueness clause is automatically unique, because $\pi$ is
  surjective and $e \circ \pi = \pi'$ determines $e$ on all of $Q$.
- `hgm : g ≤ m` is assumed, so the quotient dimension `m - g` is genuine subtraction.
- **Deliberate departure.** Mathlib offers `[MulAction G M]`, `[ContMDiffSMul I n G M]` and `[ProperSMul G M]`. Phrasing the
  hypothesis with those classes and `fun p : G × M ↦ p.1 • p.2` would be more idiomatic and inherit
  the `MulAction` API. Hand-rolling `SmoothFreeProperAction` is defensible because the theorem
  quantifies over a bare function `act : G → M → M`, but then the action axioms have to be restated
  by hand, which they are.
- **Deliberate departure.** Candidates that state properness as "for every compact $K$, the set $\{a \mid (a \cdot K) \cap K
  \ne \emptyset\}$ is compact", or via `[ProperSMul G M]`, should be judged acceptable. That
  equivalence holds for locally compact Hausdorff spaces but is not proved in Mathlib in this
  generality.
- $Q$ lives in the same universe as $M$, which is right — the orbit space is a quotient of $M$.
  Binding the instances as `∃ (_ : TopologicalSpace Q) …` makes them anonymous but still visible to
  instance search inside the body. Without a construction in Mathlib this chain of existentials is
  the only option; the statement is heavy but faithful.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[lee_9_16_quotient_manifold_theorem.md](lee_9_16_quotient_manifold_theorem.md) and the background in [lee_9_16_quotient_manifold_theorem.context.md](lee_9_16_quotient_manifold_theorem.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 11 rows, so each row is worth 4.5 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 6 with properness dropped or weakened: the orbit space need not be Hausdorff.
- Requirement 10 with uniqueness of the smooth structure omitted.
- Requirement 11 with the Hausdorff/second-countable conclusions about the quotient omitted.

### Domain-specific pitfalls for this problem

- Smoothness of the action is joint in $(a,x)$.
- Properness is properness of $(a,x)\mapsto(a\cdot x,x)$, not of the action map itself.
- The dimension of the quotient is $\dim M - \dim G$; in a formalization with natural-number dimensions, truncated subtraction must not be allowed to hide a degenerate case.
- "Topological manifold" for Lee carries Hausdorffness and second countability, so those belong among the produced structures.
- Uniqueness is up to a diffeomorphism commuting with the projections, not mere existence of some diffeomorphism.
