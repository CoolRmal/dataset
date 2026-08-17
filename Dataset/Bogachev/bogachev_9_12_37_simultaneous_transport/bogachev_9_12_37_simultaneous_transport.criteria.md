# Criteria: bogachev_9_12_37_simultaneous_transport

**Statement:** [bogachev_9_12_37_simultaneous_transport.md](bogachev_9_12_37_simultaneous_transport.md) · **Lean:** [bogachev_9_12_37_simultaneous_transport.lean](bogachev_9_12_37_simultaneous_transport.lean) · **Context:** [bogachev_9_12_37_simultaneous_transport.context.md](bogachev_9_12_37_simultaneous_transport.context.md)

## What the theorem says

On a Souslin space, take finitely many atomless Borel probability measures $\mu_1,\dots,\mu_n$ and
any Borel probability measure $\nu$. There is a *single* Borel map $T$ of the space to itself that
pushes each one of the $\mu_i$ forward to $\nu$. The strength of the result is that one map works
for all $n$ measures at once; for a single measure this is the classical isomorphism theorem.
"Atomless" is used in the $\sigma$-algebra sense: every set of positive measure splits into a piece
of strictly smaller but still positive measure.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | One map $T$ serves every index: the existential comes before the universal. | ✅ `∃ T : X → X, ∀ i, MeasurePreserving T (μ i) ν`. |
| 2 | $T$ is Borel measurable, and the pushforward of each $\mu_i$ along $T$ is exactly $\nu$. | ✅ `MeasurePreserving T (μ i) ν` bundles `Measurable T` with `Measure.map T (μ i) = ν`. |
| 3 | The family is finite. | ✅ `μ : Fin n → Measure X` with `{n : ℕ}` arbitrary. |
| 4 | Each $\mu_i$ is a Borel probability measure. | ✅ `[∀ i, IsProbabilityMeasure (μ i)]` together with `[BorelSpace X]`. |
| 5 | Each $\mu_i$ is atomless in the book's sense: every measurable set of positive measure contains a measurable subset of positive but strictly smaller measure. | ✅ `hμ : ∀ i, IsAtomlessMeasure (μ i)`, defined in `Defs.lean` to say exactly that. |
| 6 | $\nu$ is an arbitrary Borel probability measure — the statement quantifies over all of them, atoms allowed. | ✅ `(ν : Measure X) [IsProbabilityMeasure ν]`, with no atomlessness hypothesis. |
| 7 | The space is Souslin, i.e. Hausdorff and an analytic set. | ✅ `[T2Space X] [SouslinSpace X]`, where the class asserts `AnalyticSet (univ : Set X)`. |
| 8 | The measurable structure is the Borel one coming from the topology. | ✅ `[TopologicalSpace X] [MeasurableSpace X] [BorelSpace X]`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Swapping the quantifiers to `∀ i, ∃ T, …`. | That is the one-measure isomorphism theorem repeated $n$ times, which is a known earlier result. The corollary's whole point is a single simultaneous $T$. |
| 2 | Writing only `Measure.map T (μ i) = ν` without requiring $T$ measurable. | `Measure.map` of a map that is not a.e. measurable is defined to be the zero measure in Lean, so the equation would be reporting something other than a pushforward, and the Borel requirement on $T$ would silently disappear. |
| 3 | Assuming $\nu$ is atomless too. | Strengthens the hypotheses and weakens the theorem. The book allows any Borel probability $\nu$, including a point mass. |
| 4 | Allowing countably many measures instead of finitely many. | The result is stated for a finite family; the countable version is not what is proved here. |
| 5 | Fixing $n = 2$ or a similar small case. | Loses the general statement. |
| 6 | Dropping the Souslin hypothesis, or replacing it by "Polish". | Souslin is strictly more general than Polish, and without some such hypothesis the transport statement fails. |
| 7 | Encoding "atomless" only as $\mu(\{x\}) = 0$ for every point. | That is a different definition. It agrees with the book's on nice spaces, so a candidate using it is not automatically wrong, but it substitutes a nontrivial equivalence for the printed hypothesis and deserves a case-by-case look. |

## Notes on the ground truth

- `SouslinSpace` is a class in `Defs.lean`: a Hausdorff space whose whole underlying set is analytic,
  spelled with Mathlib's `MeasureTheory.AnalyticSet (univ : Set X)`. This is the standard equivalent
  form of "continuous image of a Polish space" and avoids re-defining Polish images from scratch.
- `IsAtomlessMeasure` in `Defs.lean` is the direct negation of Definition 7.14.15: no measurable
  set is an atom. Mathlib's `[NoAtoms μ]` is a different definition, so it was not used.
- Probability and Borel assumptions are carried as typeclasses rather than as hypotheses such as
  `μ Set.univ = 1`, matching Mathlib style.
- For $n = 0$ the statement is trivially true, since there is nothing to transport. This is a
  harmless degenerate case of the general `Fin n` indexing.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[bogachev_9_12_37_simultaneous_transport.md](bogachev_9_12_37_simultaneous_transport.md) and the background in [bogachev_9_12_37_simultaneous_transport.context.md](bogachev_9_12_37_simultaneous_transport.context.md),
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

- Requirement 1: quantifying as $\forall i, \exists T$ rather than $\exists T, \forall i$. The simultaneity is the entire content of the corollary.
- Requirement 2 with measurability of $T$ dropped: the pushforward of a non-measurable map is defined to be the zero measure, so the transport equation would be reporting a default value.
- Requirement 6 strengthened by assuming $\nu$ atomless: a strictly weaker theorem.

### Domain-specific pitfalls for this problem

- Junk value — pushforward: `Measure.map T μ` is the zero measure unless `T` is (a.e.) measurable. `MeasurePreserving T μ ν` bundles measurability with `Measure.map T μ = ν` and is the safe spelling.
- "Atomless" must be Bogachev's definition (every positive-measure set splits), not `NoAtoms` in the sense of vanishing on singletons. The latter is a different predicate that happens to coincide on standard Borel spaces.
- Souslin is a strictly weaker hypothesis than Polish; substituting `PolishSpace` states a special case, and dropping the hypothesis altogether makes the corollary false.
- The measurable structure must be the Borel one generated by the topology (`BorelSpace X`), since "Borel probability measure" and "Borel transformation" both refer to it.
- The family is finite ($i \le n$). Replacing it by a countable family states a result the corollary does not prove.
