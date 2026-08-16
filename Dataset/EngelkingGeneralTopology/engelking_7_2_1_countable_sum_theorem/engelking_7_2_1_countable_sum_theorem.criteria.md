# Criteria: engelking_7_2_1_countable_sum_theorem

**Statement:** [engelking_7_2_1_countable_sum_theorem.md](engelking_7_2_1_countable_sum_theorem.md) · **Lean:** [engelking_7_2_1_countable_sum_theorem.lean](engelking_7_2_1_countable_sum_theorem.lean) · **Context:** [engelking_7_2_1_countable_sum_theorem.context.md](engelking_7_2_1_countable_sum_theorem.context.md)

## What the theorem says

Covering dimension is defined like this: $\dim X \le n$ means every finite open cover of $X$ has a
finite open refinement in which no point belongs to more than $n+1$ members. The countable sum
theorem says that dimension cannot go up when you glue countably many closed pieces: if a normal
space $X$ is the union of countably many closed subsets $F_1, F_2, \ldots$, each of dimension at most
$n$ in its own subspace topology, then $X$ itself has dimension at most $n$. The same $n$ bounds every
piece and the whole.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The ambient space is normal. | ✅ `[NormalSpace X]`. |
| 2 | The cover is countable — indexed by $\mathbb{N}$, matching "$\{F_j\}$, $j = 1, 2, \ldots$". | ✅ `F : ℕ → Set X`. |
| 3 | Every member of the cover is **closed**. | ✅ `∀ j, IsClosed (F j)`. |
| 4 | The members cover all of $X$. | ✅ `⋃ j, F j = univ`. |
| 5 | Each piece has covering dimension at most $n$ **as a space in its own right**, with the subspace topology. | ✅ `∀ j, CoveringDimensionLE (F j) n`, which elaborates with `F j` coerced to the subtype `↥(F j)` and its subspace instance. |
| 6 | The same $n$ bounds every piece, and the conclusion uses that same $n$. | ✅ `{n : ℕ}` is a single fixed variable used in both the hypothesis and the conclusion `CoveringDimensionLE X n`. |
| 7 | $\dim \le n$ quantifies over **finite** open covers and produces **finite** open refinements. | ✅ `CoveringDimensionLE X n := ∀ (m : ℕ) (U : Fin m → Set X), IsOpenCover U → ∃ (k : ℕ) (V : Fin k → Set X), …` — finite in, finite out. |
| 8 | The refinement must itself be an open cover and refine in the right direction. | ✅ `IsOpenCover V ∧ Refines V U`, with `Refines V U := ∀ j, ∃ i, V j ⊆ U i`. |
| 9 | "Order at most $n+1$" means no point lies in more than $n+1$ members of the refinement. | ✅ `CoverOrderLE U n := ∀ x, ∀ s : Finset ι, (∀ i ∈ s, x ∈ U i) → s.card ≤ n + 1`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Dropping closedness of the $F_j$, or asking only that $\bigcup_j F_j$ be closed. | The theorem then fails spectacularly: $\mathbb{R}$ is the union of $\mathbb{Q}$ and $\mathbb{R} \setminus \mathbb{Q}$, both of dimension $0$, yet $\dim \mathbb{R} = 1$. |
| 2 | Writing the order condition as `s.card ≤ n` or `s.card < n + 1`. | Shifts the whole dimension theory by one. With `s.card ≤ n`, `CoveringDimensionLE X 0` would say the refinement misses every point, i.e. is empty. |
| 3 | Letting the definition of $\dim \le n$ quantify over arbitrary infinite open covers. | That defines a different, larger invariant. Engelking's covering dimension uses finite covers. |
| 4 | Forgetting that the refinement must again cover $X$. | The empty family then satisfies the order condition, so $\dim X \le n$ would hold for every space and every $n$. |
| 5 | Relativizing $\dim F_j \le n$ to covers of $X$ — e.g. "every finite open cover of $X$ has a refinement of order $\le n+1$ over $F_j$". | A different condition. Engelking means the dimension of $F_j$ as a topological space with the subspace topology. |
| 6 | Letting $n$ depend on $j$, or concluding $\dim X \le n+1$. | A different theorem. The point of the countable sum theorem is that the bound does not grow. |

## Notes on the ground truth

- Mathlib has no covering dimension, so `CoveringDimensionLE` and `CoverOrderLE` are hand-rolled in
  `Defs.lean` and must be read literally. `Fin m`-indexed finite families, `IsOpen`, `IsClosed` and
  `Finset.card` are the right primitives.
- `CoverOrderLE` counts *distinct sets*, so a refinement that lists the same set twice is not
  penalised; the order of a cover is about how many members contain a point.
- Engelking's "normal space" includes $T_1$, and `[T1Space X]` is assumed alongside `[NormalSpace X]`.
- The closed cover is supplied as data with its three properties as separate hypotheses, so the
  theorem reads as Engelking states it.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[engelking_7_2_1_countable_sum_theorem.md](engelking_7_2_1_countable_sum_theorem.md) and the background in [engelking_7_2_1_countable_sum_theorem.context.md](engelking_7_2_1_countable_sum_theorem.context.md),
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

- Requirement 7 with $\dim$ defined through arbitrary rather than finite open covers: a different dimension function.
- Requirement 3 with the pieces not required closed.
- Requirement 1 with normality dropped.

### Domain-specific pitfalls for this problem

- Covering dimension is defined by *finite* open covers and *finite* open refinements; using arbitrary covers defines a different invariant.
- "Order at most $n+1$" means at most $n+1$ members contain any given point — the $+1$ is not a typo.
- The dimension of each $F_j$ is computed in the subspace topology, so the covers there are relatively open.
- One fixed $n$ bounds every piece and is the $n$ of the conclusion.
