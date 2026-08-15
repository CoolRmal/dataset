# Criteria: mattila_8_8_frostman_lemma

**Statement:** [mattila_8_8_frostman_lemma.md](mattila_8_8_frostman_lemma.md) · **Lean:** [mattila_8_8_frostman_lemma.lean](mattila_8_8_frostman_lemma.lean) · **Context:** [mattila_8_8_frostman_lemma.context.md](mattila_8_8_frostman_lemma.context.md)

## What the theorem says

Frostman's lemma converts a statement about Hausdorff measure into a statement about measures. For a
Borel set $B \subset \mathbb{R}^n$, the $s$-dimensional Hausdorff measure of $B$ is positive exactly
when $B$ carries a nonzero finite measure $\mu$, with compact support inside $B$, whose mass on every
ball satisfies $\mu(B(x,r)) < r^s$. One direction is the easy "mass distribution principle"; the
other direction is the substantial one. The theorem adds a quantitative refinement: when
$\mathcal{H}^s(B) > 0$ one can choose such a $\mu$ with total mass on $B$ bigger than
$c\,\mathcal{H}^s_\infty(B)$, where $\mathcal{H}^s_\infty$ is the Hausdorff content (the same
infimum over countable covers as $\mathcal{H}^s$, but with no restriction on the diameters) and
$c > 0$ depends only on $n$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The constant $c$ depends only on $n$: it is quantified before $s$ and $B$, and it is both positive and finite. | ✅ `∃ c : ℝ≥0∞, 0 < c ∧ c < ∞ ∧ ∀ (s : ℝ) (B), …`, with `n` implicit in the theorem's binders. |
| 2 | $B$ is a Borel set. | ✅ `MeasurableSet B`; the `MeasurableSpace` instance on `EuclideanSpace ℝ (Fin n)` is the Borel $\sigma$-algebra. |
| 3 | The main assertion is a biconditional with $\mathcal{H}^s(B) > 0$ — the Hausdorff **measure**, not the content — on the left. | ✅ `0 < μH[s] B ↔ ∃ μ, …`. |
| 4 | The witnessing measure belongs to $\mathcal{M}(B)$: it is nonzero, finite, Radon (finite on compacts and inner regular), and its support is compact and contained in $B$. | ✅ `IsFiniteMeasure μ ∧ IsFiniteMeasureOnCompacts μ ∧ Measure.InnerRegular μ ∧ μ ≠ 0 ∧ IsCompact μ.support ∧ μ.support ⊆ B`. |
| 5 | The growth bound is the strict inequality $\mu(\bar B(x,r)) < r^s$, for **every** $x \in \mathbb{R}^n$ (not only $x \in B$) and **every** $r > 0$ (no small-radius restriction). | ✅ `∀ x, ∀ r : ℝ, 0 < r → μ (closedBall x r) < ENNReal.ofReal (r ^ s)`. |
| 6 | The quantitative refinement is a strengthening of the forward direction, so it must be stated under the assumption $\mathcal{H}^s(B) > 0$, not as a free-standing claim. | ✅ `(0 < μH[s] B → ∃ μ, … ∧ c * hausdorffContent s B < μ B)`. |
| 7 | The refinement's measure must satisfy the same growth bound and support conditions, plus the mass lower bound, with the book's strict `<`. | ✅ The full property list is repeated inside the second conjunct, ending in `c * hausdorffContent s B < μ B`. |
| 8 | The Hausdorff content is an infimum over countable covers of $\sum_i d(E_i)^s$ with no diameter restriction, and the diameters must be extended-real so that unbounded covering sets count as $\infty$. | ✅ `hausdorffContent s A = ⨅ U : ℕ → Set X, ⨅ (_ : A ⊆ ⋃ i, U i), ∑' i, Metric.ediam (U i) ^ s` in `Defs.lean`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Asserting the "moreover" clause for every Borel $B$, outside the forward implication. | Take $B = \emptyset$. The clause then demands a nonzero measure with support inside $\emptyset$, which cannot exist, so the whole theorem becomes false — `False` is derivable from its type in a few lines. |
| 2 | Building the content from `Metric.diam`, the real-valued diameter. | `Metric.diam` is `0` on unbounded sets. Covering by `U i = univ` then gives content `0` for every set, so the mass bound $c\,\mathcal{H}^s_\infty(B) < \mu(B)$ would say nothing at all. The extended diameter is required. |
| 3 | Relaxing the growth bound to `≤`, or restricting it to $x \in B$, or to small $r$. | Theorem 8.8 states a strict inequality for all centres and all radii. Each relaxation changes which measures qualify, so it changes both directions of the biconditional. |
| 4 | Writing the growth bound as $\mu(B(x,r)) \le C r^s$ with a free constant $C$. | That is the more common textbook form but not what 8.8 states; here the bound is normalized with constant $1$. |
| 5 | Writing `∀ B, ∃ c, …`, or omitting `0 < c`. | If $c$ may depend on $B$ the refinement is unquantified; if $c$ may be $0$ the mass bound is trivially satisfied. |
| 6 | Dropping compactness of the support, or finiteness of $\mu$. | Those are the content of "$\mu \in \mathcal{M}(B)$". Without them the forward direction is weaker and the reverse direction becomes stronger than proved. |
| 7 | Stating only one direction of the biconditional. | Both directions are asserted; the reverse one is the mass distribution principle. |
| 8 | Putting the content $\mathcal{H}^s_\infty(B)$, rather than the measure $\mathcal{H}^s(B)$, on the left of the biconditional. | The two vanish together, but the theorem as printed compares against the measure; the content appears only in the refinement. |

## Notes on the ground truth

- Three earlier defects have been repaired and are recorded here as regression checks. The
  quantitative clause used to be a free-standing conjunct (Mistake 1); `hausdorffContent` used to be
  built from `Metric.diam`, making it identically `0` on an unbounded space (Mistake 2); and the
  witnessing measures were only required to satisfy `μ Bᶜ = 0` rather than being finite with compact
  support inside $B$.
- "$\mu$ lives on $B$" can be read either as `μ Bᶜ = 0` (concentrated on $B$) or as
  `μ.support ⊆ B`. For Borel $B$ these genuinely differ, since the support is closed. We take the
  literal reading from the book, `IsCompact μ.support ∧ μ.support ⊆ B`.
- `IsFiniteMeasureOnCompacts` and `Measure.InnerRegular` are classes, but `μ` here is existentially
  bound, so they correctly appear as plain propositions. On $\mathbb{R}^n$ inner regularity is
  automatic for locally finite Borel measures, so that conjunct is redundant but harmless.
- ⚠️ `0 < s` is our hypothesis, not stated in the transcribed text. It is needed for `r ^ s` to
  behave as intended.
- ⚠️ Honest weakness: when $\mathcal{H}^s_\infty(B) = \infty$ — for example $B = \mathbb{R}^n$ with
  $s = n$ — the refinement demands `c * ∞ < μ B` for a finite measure `μ`, which is impossible, so
  our second conjunct is false for such $B$. Mattila's "moreover" is only meaningful for sets of
  finite content (in particular for bounded ones); a faithful repair would restrict $B$ to be
  bounded, or require `hausdorffContent s B < ∞`.
- ⚠️ The property list is written out twice, once in each conjunct. A named abbreviation would be
  tidier, but the duplication is faithful.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[mattila_8_8_frostman_lemma.md](mattila_8_8_frostman_lemma.md) and the background in [mattila_8_8_frostman_lemma.context.md](mattila_8_8_frostman_lemma.context.md),
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

- Requirement 1 with $c$ quantified after $B$ or $s$.
- Requirement 4 with the witnessing measure allowed to be zero, or not required to be supported in $B$.
- Requirement 5 with a non-strict growth bound, or with the bound restricted to small $r$ or to $x \in B$.

### Domain-specific pitfalls for this problem

- $\mathcal{H}^s_\infty$ (content, covers of unrestricted diameter) and $\mathcal{H}^s$ (measure, diameters $\to 0$) are different quantities and both appear.
- The measure must be nonzero, finite, Radon and compactly supported inside $B$.
- The growth bound is strict and holds for all centres and all radii.
- The quantitative clause strengthens one direction of the biconditional and must be attached there.
- All quantities live in $[0,\infty]$.
