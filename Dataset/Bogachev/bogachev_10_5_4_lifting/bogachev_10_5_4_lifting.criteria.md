# Criteria: bogachev_10_5_4_lifting

**Statement:** [bogachev_10_5_4_lifting.md](bogachev_10_5_4_lifting.md) · **Lean:** [bogachev_10_5_4_lifting.lean](bogachev_10_5_4_lifting.lean) · **Context:** [bogachev_10_5_4_lifting.context.md](bogachev_10_5_4_lifting.context.md)

## What the theorem says

A bounded measurable function is normally only pinned down up to a set of measure zero, so it has
many equally good representatives. A *lifting* picks one representative out of each class, for all
classes at once, and does so compatibly with the algebra: the chosen representatives of $f+g$,
of $\alpha f$, and of $fg$ are literally the sum, multiple and product of the chosen
representatives, at every single point — not just almost everywhere. The theorem says such a choice
exists for every complete probability measure.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $\mu$ is a probability measure. | ✅ `[IsProbabilityMeasure μ]`. |
| 2 | $\mu$ is complete, i.e. every subset of a null set is measurable. | ✅ `[μ.IsComplete]`. |
| 3 | The lifting is a map from functions to functions, not from a.e.-classes to a.e.-classes. | ✅ `toFun : (X → ℝ) → X → ℝ`. |
| 4 | It sends bounded measurable functions to bounded measurable functions. | ✅ `maps_bounded_measurable`. |
| 5 | Condition (i): $L(f) = f$ almost everywhere. This one is the a.e. statement. | ✅ `representative : toFun f =ᵐ[μ] f`. |
| 6 | Condition (ii): if $f = g$ a.e. then $L(f)$ and $L(g)$ are the same function at every point. | ✅ `congr_ae : … → toFun f = toFun g`. |
| 7 | Condition (iii): if $f = 1$ a.e. then $L(f)$ is the constant $1$ at every point. | ✅ `map_ae_one : … → toFun f = (1 : X → ℝ)`. |
| 8 | Condition (iv): linearity, holding at every point — both $L(f+g) = L(f)+L(g)$ and $L(\alpha f) = \alpha L(f)$ for real $\alpha$. | ✅ `map_add` and `map_smul`, both exact equalities of functions. |
| 9 | Condition (v): $L(fg) = L(f)L(g)$ at every point. | ✅ `map_mul`. |
| 10 | Every condition is stated only for arguments that are bounded and measurable, since that is the book's space $\mathcal{L}^\infty_{\mathcal{A}}$. | ✅ Each field carries the guard `Measurable f ∧ ∃ C : ℝ, ∀ x, \|f x\| ≤ C`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Typing the lifting as `Lp ℝ ∞ μ → Lp ℝ ∞ μ`, a map between spaces of a.e.-classes. | On classes there is nothing to say: the identity map satisfies every condition. The whole content is the pointwise choice, and conditions (ii)–(v) cannot even be written down on classes. |
| 2 | Writing conditions (ii)–(v) with `=ᵐ[μ]` instead of exact equality. | The identity map then satisfies all of them, so the theorem becomes trivially true. Only condition (i) is an a.e. statement. |
| 3 | Dropping the completeness hypothesis on $\mu$. | This is the hypothesis models omit most often. The theorem is stated and proved for complete measures. |
| 4 | Dropping condition (iii), or folding it into condition (i). | Unitality does not follow from the other four conditions as stated; a lifting is required to send the class of $1$ to the genuine constant function $1$. |
| 5 | Stating the conditions for arbitrary $f : X \to \mathbb{R}$ with no boundedness or measurability guard. | That asserts a lifting defined on all real-valued functions, a much stronger claim than the printed one. |
| 6 | Replacing the probability hypothesis with $\sigma$-finiteness or nothing at all. | The theorem as printed is about a complete probability measure; a weaker hypothesis states a different result. |
| 7 | Requiring only additivity and forgetting scalars, or vice versa. | The book's (iv) is $L(\alpha f + \beta g) = \alpha L(f) + \beta L(g)$, which needs both halves. |

## Notes on the ground truth

- The five book conditions are packaged as a structure `LInfinityLifting μ` in `Defs.lean`, and the
  theorem concludes `Nonempty (LInfinityLifting μ)`. An unfolded `∃ L : (X → ℝ) → X → ℝ, …` with a
  seven-way conjunction says exactly the same thing and is equally acceptable.
- Because Lean functions are total, membership in $\mathcal{L}^\infty_{\mathcal{A}}$ is expressed by
  repeating the guard `Measurable f ∧ ∃ C : ℝ, ∀ x, |f x| ≤ C` on each field. A subtype
  `{f : X → ℝ // Measurable f ∧ …}` would avoid the repetition; the guarded form was chosen because
  it keeps the pointwise algebra (`f + g`, `f * g`, `c • f`) readable.
- "Bounded" is taken as bounded at every point, not just essentially bounded. That matches the
  book's $\mathcal{L}^\infty_{\mathcal{A}}$, which is the space of bounded measurable functions.
- The book's single linearity condition (iv) is split into `map_add` and `map_smul`. Together they
  give the printed statement.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[bogachev_10_5_4_lifting.md](bogachev_10_5_4_lifting.md) and the background in [bogachev_10_5_4_lifting.context.md](bogachev_10_5_4_lifting.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 10 rows, so each row is worth 5.0 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 3 with requirements 6–9: if the lifting acts on almost-everywhere classes, or if any of conditions (ii)–(v) is stated with `=ᵐ[μ]` rather than exact equality, the statement is trivially true and is not this theorem.
- Requirement 2: dropping completeness of $\mu$ states an unproved (and, in the printed generality, different) result.

### Domain-specific pitfalls for this problem

- The confusable pair here is $\mathcal{L}^\infty$ (bounded measurable *functions*) versus $L^\infty$ (their a.e. classes). Mathlib's `Lp ℝ ∞ μ` is the quotient, so it is the wrong home for the domain and codomain of a lifting.
- Boundedness must be part of the guard on every condition. Without it the statement asserts a lifting on all of $X \to \mathbb{R}$, which is a strictly stronger and different claim.
- `IsProbabilityMeasure` versus `IsFiniteMeasure` versus `SFinite`: the printed hypothesis is a probability measure, and substituting a weaker one silently changes the theorem.
- Completeness of a measure is `Measure.IsComplete`, a property of the measure together with its σ-algebra; it is not the same as `MeasureSpace` or as working with `NullMeasurableSet`.
