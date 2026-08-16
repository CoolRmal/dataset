# Criteria: lee_8_8_constant_rank_level_set_theorem

**Statement:** [lee_8_8_constant_rank_level_set_theorem.md](lee_8_8_constant_rank_level_set_theorem.md) · **Lean:** [lee_8_8_constant_rank_level_set_theorem.lean](lee_8_8_constant_rank_level_set_theorem.lean) · **Context:** [lee_8_8_constant_rank_level_set_theorem.context.md](lee_8_8_constant_rank_level_set_theorem.context.md)

## What the theorem says

Let $\Phi : M \to N$ be a smooth map between smooth manifolds whose differential has the same rank
$k$ at every point of $M$. Then for each point $c$ of $N$, the level set $\Phi^{-1}(c)$ is a closed
subset of $M$ and is an embedded submanifold of codimension exactly $k$. "Embedded submanifold of
codimension $k$" means: around every point of the level set there is a chart of $M$ in which the
level set is exactly the piece where the last $k$ coordinates vanish. The claim is made for every
$c$, including values that $\Phi$ never takes (there the level set is empty, and the statement holds
with nothing to check).

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $M$ is a smooth manifold of dimension $m$ without boundary, and $N$ one of dimension $n$. | ✅ `[ChartedSpace (Fin m → ℝ) M]` with `[IsManifold 𝓘(ℝ, Fin m → ℝ) ∞ M]`, and the same for `N`. |
| 2 | $\Phi$ is smooth. | ✅ `hΦ : ContMDiff 𝓘(ℝ, Fin m → ℝ) 𝓘(ℝ, Fin n → ℝ) ∞ Φ`. |
| 3 | The differential of $\Phi$ has rank exactly $k$ at every point of $M$, as a single hypothesis stated before any level set is chosen. | ✅ `hrank : ConstantRank Φ k`, which is `∀ p, Module.finrank ℝ (LinearMap.range (mfderiv … Φ p).toLinearMap) = k`. |
| 4 | The smoothness hypothesis must be present so that `mfderiv` is the honest differential. | ✅ `hΦ` is there. Without it the rank predicate would be satisfied by any sufficiently bad $\Phi$ with $k = 0$. |
| 5 | The conclusion is asserted for **every** $c \in N$, with $c$ quantified inside the conclusion. | ✅ `∀ c, …`. |
| 6 | The level set is closed in $M$. | ✅ `IsClosed {p \| Φ p = c}`. |
| 7 | The same level set is an embedded submanifold of codimension exactly $k$, expressed by Lee's local slice condition. | ✅ `EmbeddedSubmanifoldOfCodimension (m := m) {p \| Φ p = c} k`: for each $p$ in the set there is a chart `φ ∈ IsManifold.maximalAtlas 𝓘(ℝ, Fin m → ℝ) ∞ M` with `p ∈ φ.source` and `φ '' (S ∩ φ.source) = {x ∈ φ.target \| ∀ i, m - codim ≤ i.1 → x i = 0}`. |
| 8 | The chart used in the slice condition must belong to the smooth structure, not merely be a homeomorphism. | ✅ Membership in `IsManifold.maximalAtlas … ∞ M` is required inside the definition. |
| 9 | The slice condition is relative to the chart's image: the chart carries $S \cap U$ onto the slice **of $\varphi(U)$**, not onto a whole coordinate hyperplane. | ✅ The right-hand side is `{x ∈ φ.target \| …}`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Encoding "embedded submanifold" as: there is some smooth structure on the subtype making the inclusion an injective immersion. | That is an *immersed* submanifold, which is strictly weaker. A figure-eight in the plane is an immersed submanifold and satisfies no slice condition. |
| 2 | Encoding "embedded submanifold" as `IsEmbedding (Subtype.val : S → M)` alone. | That is a purely topological condition and says nothing about the smooth structure. Any closed subset with the subspace topology satisfies it. |
| 3 | Moving $c$ outside and assuming the rank is constant only on the level set $\{p \mid \Phi p = c\}$. | The theorem is then false. Lee's own refinement weakens the hypothesis to constant rank on a *neighbourhood* of the level set, not on the level set alone. |
| 4 | Stating the constant-rank hypothesis but omitting `hΦ`, or weakening it to `MDifferentiable`. | With no smoothness, `mfderiv` is the zero map off the differentiability locus, so the predicate collapses to "$k = 0$" for pathological maps. Mere differentiability is also not enough — the proof runs through the $C^\infty$ rank theorem. |
| 5 | Dropping the `IsClosed` conjunct, or asserting it about a different set from the submanifold clause. | "Closed embedded submanifold" is two claims about one and the same level set; both are part of the statement. |
| 6 | Writing the slice condition as `φ '' (S ∩ φ.source) = {x \| ∀ i, m - k ≤ i.1 → x i = 0}` with no `x ∈ φ.target` restriction. | That would demand the chart image fill an entire coordinate hyperplane of $\mathbb{R}^m$, which is false for any chart whose image is a bounded ball. |
| 7 | Giving the codimension as $m - k$ (the dimension of the level set) instead of $k$. | Lee's statement is about codimension, and codimension $k$ is what the constant rank supplies. Confusing the two gives the wrong number whenever $k \ne m - k$. |

## Notes on the ground truth

- Mathlib has essentially no embedded-submanifold API, so `EmbeddedSubmanifoldOfCodimension` in
  `Defs.lean` is hand-rolled as Lee's local $k$-slice condition (his Theorem 5.8), which
  characterises embedded submanifolds. This is the right call given the state of the library.
- Using the *first* `codim` coordinates instead of the last would be an equally faithful convention:
  compose the chart with a coordinate permutation, which stays in the maximal atlas.
- No bound `k ≤ min(m,n)` is imposed, and none is needed: `ConstantRank` already forces it whenever
  $M$ is nonempty. This is cleaner than `lee_7_8` and `lee_7_13`, which carry a redundant `hk`.
  `m - codim` is truncated natural subtraction, so `codim > m` would silently read as
  `codim = m`; nothing here can reach that branch, but candidates that reintroduce a free dimension
  parameter should be checked for it.
- `IsClosed` is genuinely provable here with no separation typeclass on $N$: a
  `ChartedSpace (Fin n → ℝ) N` is automatically T1, so singletons are closed and $\Phi$ is
  continuous. A candidate that adds `[T2Space N]` for this purpose is harmless but unnecessary.
- Hausdorffness and second countability are assumed of both manifolds, as Lee's definition of a
  smooth manifold requires.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[lee_8_8_constant_rank_level_set_theorem.md](lee_8_8_constant_rank_level_set_theorem.md) and the background in [lee_8_8_constant_rank_level_set_theorem.context.md](lee_8_8_constant_rank_level_set_theorem.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 9 rows, so each row is worth 5.6 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 7 with codimension $\dim N$ instead of $k$.
- Requirement 3 with the rank condition imposed only on the level set rather than on all of $M$.
- Requirement 5 with $c$ moved into the hypotheses, or restricted to attained values.

### Domain-specific pitfalls for this problem

- The codimension is the rank $k$, not the dimension of the target.
- Constant rank is a global hypothesis on $M$.
- The conclusion is for every $c$, empty level sets included.
- The slice charts must belong to the smooth structure, and the slice condition is relative to the chart's image.
