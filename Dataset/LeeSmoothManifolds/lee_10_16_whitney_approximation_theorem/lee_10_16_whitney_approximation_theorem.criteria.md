# Criteria: lee_10_16_whitney_approximation_theorem

**Statement:** [lee_10_16_whitney_approximation_theorem.md](lee_10_16_whitney_approximation_theorem.md) · **Lean:** [lee_10_16_whitney_approximation_theorem.lean](lee_10_16_whitney_approximation_theorem.lean) · **Context:** [lee_10_16_whitney_approximation_theorem.context.md](lee_10_16_whitney_approximation_theorem.context.md)

## What the theorem says

Let $M$ be a smooth manifold and $F : M \to \mathbb{R}^k$ a continuous map. Pick any tolerance
function $\delta$ on $M$ that is continuous and strictly positive — the tolerance is allowed to
shrink as you move around $M$, which matters when $M$ is not compact. Then there is a smooth map
$F'$ with $\lvert F'(x) - F(x)\rvert < \delta(x)$ for every $x$. Moreover, if $F$ is already smooth
on a closed set $A$, the same $F'$ can be taken to agree with $F$ exactly on $A$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $M$ is a smooth manifold of dimension $m$ without boundary. | ✅ `[ChartedSpace (Fin m → ℝ) M]` and `[IsManifold 𝓘(ℝ, Fin m → ℝ) ∞ M]`. |
| 2 | $M$ is Hausdorff and second countable — Lee's separation and countability conditions, which he builds into the phrase "smooth manifold". | ✅ `[T2Space M]` and `[SecondCountableTopology M]`. Second countability is the hypothesis the textbook states; for a locally Euclidean Hausdorff space it is equivalent to $\sigma$-compactness, but the textbook's own form is the faithful one. |
| 3 | $F$ is only assumed **continuous**, not smooth. | ✅ `hF : Continuous F`. |
| 4 | $\delta$ is a function on $M$, not a constant, and it is continuous. | ✅ `δ : M → ℝ` with `hδ : Continuous δ`. |
| 5 | $\delta$ is strictly positive at every point. | ✅ `hδpos : ∀ x, 0 < δ x`. |
| 6 | $A$ is closed. | ✅ `hA : IsClosed A`. |
| 7 | Some form of "$F$ is smooth on $A$". | ✅ `∀ p ∈ A, ∃ U ∈ 𝓝 p, ∃ G, ContMDiff … G ∧ EqOn G F (U ∩ A)` — Lee's definition of smoothness on an arbitrary subset: a local smooth extension near each point, not one smooth extension over a neighbourhood of all of $A$. |
| 8 | One single $F'$ carrying all the conclusions, not two separate existence claims. | ✅ A single `∃ Fsmooth : M → (EuclideanSpace ℝ (Fin k))` followed by a three-way conjunction. |
| 9 | $F'$ is smooth on all of $M$. | ✅ `ContMDiff 𝓘(ℝ, Fin m → ℝ) 𝓘(ℝ, EuclideanSpace ℝ (Fin k)) ∞ Fsmooth`. |
| 10 | $F'$ is within $\delta$ of $F$ at every point, with a strict inequality. | ✅ `∀ x, dist (Fsmooth x) (F x) < δ x`. |
| 11 | $F'$ agrees with $F$ on $A$. | ✅ `EqOn Fsmooth F A`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Dropping the `EqOn Fsmooth F A` clause. | It is the last sentence of the printed statement and the whole point of the *relative* version. Easy to lose, so check for it explicitly. |
| 2 | Splitting the conclusion into two existentials — one map that approximates, another that agrees on $A$. | Lee says $F'$ "can be chosen" to do both. Two separate maps do not say that one map has both properties. |
| 3 | Replacing the function $\delta$ by a constant $\varepsilon > 0$. | Strictly weaker whenever $M$ is not compact, and it discards the point of a variable tolerance: on $\mathbb{R}$ one cannot approximate an arbitrary continuous function uniformly by a smooth one to within any prescribed shrinking accuracy using a fixed $\varepsilon$ statement. |
| 4 | Keeping $\delta$ a function but dropping `Continuous δ`. | The statement becomes false: an arbitrary positive function can be made to drop to near zero on a dense set, and no smooth map can track a continuous one that closely. |
| 5 | Assuming $F$ is smooth rather than merely continuous. | Then the theorem is a triviality — take $F' = F$. The content is upgrading continuity to smoothness. |
| 6 | Dropping `[T2Space M]` or `[SecondCountableTopology M]`. | The proof is a partition-of-unity argument and needs paracompactness. Without those hypotheses the statement is false for non-paracompact locally Euclidean spaces. |
| 7 | Requiring $A$ to be compact, or nonempty. | Neither is in the text. In particular $A = \emptyset$ must be allowed, since that is how the unconditional version is recovered. |

## Notes on the ground truth

- "$F$ is smooth on $A$" is Lee's notion: each $p \in A$ has a neighbourhood and a smooth map
  agreeing with $F$ on the intersection with $A$.
- Lee states the unconditional approximation first and the relative version as a refinement; we merge
  them into one theorem with a mandatory $A$. No content is lost: taking $A = \emptyset$ recovers the
  unconditional case, using `isClosed_empty`, `mem_nhdsSet_empty`, `contMDiffOn_empty` and the fact
  that `EqOn` on the empty set is trivial — exactly how Mathlib derives its unconditional version.
- The target is `EuclideanSpace ℝ (Fin k)`, so $\delta$-closeness is measured in the Euclidean
  metric Lee intends, not the sup metric of the plain function space.
- Mathlib's `Continuous.exists_contMDiff_approx_and_eqOn` returns a bundled smooth map and adds the
  extra conclusion `support g ⊆ support f`; it is also stated for an arbitrary normed target and
  `n : ℕ∞`. Using a plain function plus `ContMDiff … ∞` is cleaner for a benchmark and matches Lee;
  omitting the support clause is faithful, since it is not in the book. A candidate that generalizes
  the target from `EuclideanSpace ℝ (Fin k)` to an arbitrary finite-dimensional normed space has
  strengthened the statement and should be accepted.
- This file does not import `Defs.lean`; everything it uses is in Mathlib.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[lee_10_16_whitney_approximation_theorem.md](lee_10_16_whitney_approximation_theorem.md) and the background in [lee_10_16_whitney_approximation_theorem.context.md](lee_10_16_whitney_approximation_theorem.context.md),
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

- Requirement 4 with $\delta$ a constant rather than a positive continuous function.
- Requirement 3 with $F$ assumed smooth.
- Requirement 11 weakened from exact agreement on $A$ to closeness on $A$.

### Domain-specific pitfalls for this problem

- "Smooth on a closed set" means smooth on a neighbourhood of it; a `ContMDiffOn` restricted to the set itself is a different (weaker) condition.
- The approximation is pointwise-strict, $|F'(x)-F(x)| < \delta(x)$, at every $x$.
- Hausdorffness and second countability of $M$ are needed — the proof is a partition-of-unity argument — and Lee's stated countability condition is second countability.
- One single $F'$ must satisfy all three conclusions.
