# Criteria: lee_8_10_regular_level_set_theorem

**Statement:** [lee_8_10_regular_level_set_theorem.md](lee_8_10_regular_level_set_theorem.md) · **Lean:** [lee_8_10_regular_level_set_theorem.lean](lee_8_10_regular_level_set_theorem.lean) · **Context:** [lee_8_10_regular_level_set_theorem.context.md](lee_8_10_regular_level_set_theorem.context.md)

## What the theorem says

Let $\Phi : M \to N$ be a smooth map between smooth manifolds and let $c$ be a *regular value*: at
every point $p$ with $\Phi(p) = c$, the differential $d\Phi_p$ is surjective. Then the level set
$\Phi^{-1}(c)$ is closed in $M$ and is an embedded submanifold whose codimension is $\dim N$ — the
dimension of the target, not the dimension of the level set. This is the special case of the
constant-rank level set theorem where the rank is full. Values that $\Phi$ never takes count as
regular, and there the statement holds with nothing to check.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $M$ is a smooth manifold of dimension $m$ without boundary, and $N$ one of dimension $n$. | ✅ `[ChartedSpace (Fin m → ℝ) M]` with `[IsManifold 𝓘(ℝ, Fin m → ℝ) ∞ M]`, and the same for `N` with `n`. |
| 2 | $\Phi$ is smooth, as a hypothesis in its own right. | ✅ `hΦ : ContMDiff 𝓘(ℝ, Fin m → ℝ) 𝓘(ℝ, Fin n → ℝ) ∞ Φ`. It is not implied by regularity of $c$, which says nothing at points off the level set. |
| 3 | "$c$ is a regular value": the condition is imposed at **every** point of the fibre $\Phi^{-1}(c)$, not at one point and not on all of $M$. | ✅ `hc : RegularValue Φ c`, which is `∀ p, Φ p = c → Manifold.IsSubmersionAt 𝓘(ℝ, Fin m → ℝ) 𝓘(ℝ, Fin n → ℝ) ∞ Φ p`. |
| 4 | The regularity condition must be free of junk values: it must not be satisfiable by a map that has no derivative at all. | ✅ `RegularValue` is now Lee's own condition — `ContMDiffAt` at the point **and** `Function.Surjective (mfderiv … F p)`. The smoothness conjunct is what keeps `mfderiv` from being a default, and surjectivity of the differential is the printed hypothesis rather than a chart normal form. |
| 5 | The level set is closed in $M$. | ✅ `IsClosed {p \| Φ p = c}`. |
| 6 | The same level set is an embedded submanifold, expressed by Lee's local slice condition using a chart from the smooth structure. | ✅ `EmbeddedSubmanifoldOfCodimension (m := m) {p \| Φ p = c} n`, which requires for each point of the set a chart `φ ∈ IsManifold.maximalAtlas 𝓘(ℝ, Fin m → ℝ) ∞ M` with `φ '' (S ∩ φ.source) = {x ∈ φ.target \| ∀ i, m - n ≤ i.1 → x i = 0}`. |
| 7 | The codimension is exactly $n = \dim N$. | ✅ The last argument is `n`, the model dimension of `N`. |
| 8 | The statement holds for every regular value, so $c$ and its regularity hypothesis are universally quantified. | ✅ `{c : N}` and `hc` are binders, so the theorem reads "for every $c$ that is a regular value…". |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Writing regularity as `∀ p, Φ p = c → Function.Surjective (mfderiv 𝓘(ℝ, Fin m → ℝ) 𝓘(ℝ, Fin n → ℝ) Φ p)` with no differentiability side condition and no `hΦ`. | Mathlib's `mfderiv` is the zero map wherever $\Phi$ is not `MDifferentiableAt`. For $n = 0$ the zero map is surjective, so a completely non-smooth $\Phi$ can satisfy the hypothesis. Pairing the `mfderiv` version with `MDifferentiableAt … Φ p` fixes it. |
| 2 | Giving the codimension as $m - n$. | That is the *dimension* of the level set, not its codimension. Lee's corollary says the codimension equals the dimension of the range. |
| 3 | Reusing the rank $k$ from Theorem 8.8 as the codimension without tying it to $n$. | At a regular value the rank is full, so it is $n$; leaving it as a free $k$ states a different, unproven claim. |
| 4 | Encoding "embedded submanifold" as an injective immersion from an abstract manifold, or as `IsEmbedding (Subtype.val)`. | The first gives an *immersed* submanifold, strictly weaker; the second is purely topological and says nothing about the smooth structure. Neither is Lee's notion. |
| 5 | Dropping the `IsClosed` conjunct. | "Closed embedded submanifold" is two claims about the same set; only one of them is the slice condition. |
| 6 | Adding a surjectivity or nonemptiness hypothesis on $\Phi$, or requiring $c$ to be in the image. | Lee requires neither. Every value outside the image is vacuously regular and the conclusion is true there; excluding those cases weakens the theorem. |
| 7 | Dropping `hΦ` because `hc` looks like it already forces smoothness. | `hc` only constrains $\Phi$ at points of the fibre. Off the fibre $\Phi$ would be unconstrained, and the proof needs smoothness everywhere near the fibre. |

## Notes on the ground truth

- We render "$d\Phi_p$ is surjective" by Mathlib's `Manifold.IsSubmersionAt`, which asks for charts
  in which $\Phi$ reads $(u,v) \mapsto u$. `Mathlib/Geometry/Manifold/Submersion.lean` still lists
  "`mfderiv` surjective ⟹ `IsSubmersionAt` for finite-dimensional manifolds" as a TODO, so as a
  *hypothesis* `IsSubmersionAt` is formally stronger than Lee's condition and our theorem is
  formally weaker. Mathematically the two agree here since both manifolds are finite-dimensional.
  The literal alternative `MDifferentiableAt … Φ p ∧ Surjective (mfderiv … Φ p)` would be closer to
  the text and equally free of junk values; a candidate using it should be accepted.
- `IsClosed` is provable with no separation typeclass on $N$: a `ChartedSpace (Fin n → ℝ) N` is
  automatically T1, so `{c}` is closed and $\Phi$ is continuous.
- Hausdorffness and second countability are assumed of both manifolds, as Lee's definition of a
  smooth manifold requires.
- `m - n` inside `EmbeddedSubmanifoldOfCodimension` is truncated natural subtraction. Nothing in a
  realizable situation reaches the truncated branch (a regular value forces $n \le m$ when the fibre
  is nonempty), but it is worth checking in candidate statements.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[lee_8_10_regular_level_set_theorem.md](lee_8_10_regular_level_set_theorem.md) and the background in [lee_8_10_regular_level_set_theorem.context.md](lee_8_10_regular_level_set_theorem.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 8 rows, so each row is worth 6.2 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 3 with the regularity condition imposed at only one point, or on all of $M$.
- Requirement 7 with a codimension other than $\dim N$.
- Requirement 4 with the surjectivity condition stated about a differential that is not known to be genuine.

### Domain-specific pitfalls for this problem

- Regularity is surjectivity of the differential, at every point of the fibre.
- "Embedded submanifold" is the local slice condition with charts from the smooth structure.
- Junk value — `mfderiv`: the smoothness hypothesis must be present for the regularity condition to constrain anything.
- Both conclusions — closedness and the submanifold structure — are asserted.
- The statement is for every regular value, with $c$ quantified inside.
