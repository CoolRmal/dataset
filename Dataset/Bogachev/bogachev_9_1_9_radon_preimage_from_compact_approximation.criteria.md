# Criteria: bogachev_9_1_9_radon_preimage_from_compact_approximation

**Statement:** [bogachev_9_1_9_radon_preimage_from_compact_approximation.md](bogachev_9_1_9_radon_preimage_from_compact_approximation.md) · **Lean:** [bogachev_9_1_9_radon_preimage_from_compact_approximation.lean](bogachev_9_1_9_radon_preimage_from_compact_approximation.lean) · **Context:** [bogachev_9_1_9_radon_preimage_from_compact_approximation.context.md](bogachev_9_1_9_radon_preimage_from_compact_approximation.context.md)

## What the theorem says

A map $f$ goes from a topological space $X$ to a space $Y$ that carries a Radon measure $\nu$. The
map is not assumed measurable; all we know is that there is an increasing sequence of compact sets
$K_n \subseteq X$ on which $f$ is continuous, and that the images $f(K_n)$ eventually capture
essentially all of the mass of $\nu$. The theorem produces a Radon measure $\mu$ on $X$ whose image
under $f$ is $\nu$, and $\mu$ can be chosen with the same total variation norm as $\nu$. The special
case worth naming: if $X$ and $Y$ are compact and $f$ is a continuous surjection, this always
applies.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $\nu$ is a finite signed measure on $Y$ that is Radon, i.e. its total variation is inner regular with respect to compact sets. | ✅ `ν : SignedMeasure Y` with `hν : Measure.InnerRegular ν.totalVariation`. |
| 2 | No measurability or continuity of $f$ on all of $X$ may be assumed. | ✅ The only facts about `f` in the first part are `ContinuousOn f (K n)` for each `n`. |
| 3 | The compact sets increase: $K_n \subseteq K_{n+1}$. | ✅ `Monotone K`. |
| 4 | Each $K_n$ is compact. | ✅ `∀ n, IsCompact (K n)`. |
| 5 | $f$ is continuous on each $K_n$. | ✅ `∀ n, ContinuousOn f (K n)`. |
| 6 | The approximation hypothesis: $\lvert \nu\rvert(f(K_n)) \to \lVert \nu\rVert$. | ✅ `Tendsto (fun n ↦ ν.totalVariation (f '' K n)) atTop (𝓝 (ν.totalVariation univ))`. The image sets need not be measurable; `totalVariation` is applied as an outer measure. |
| 7 | The conclusion produces one measure $\mu$ that is Radon *and* has the same variation norm *and* has image $\nu$ — all three at once. | ✅ A single `∃ μ : SignedMeasure X` whose body is a three-way conjunction. |
| 8 | "$\mu \circ f^{-1} = \nu$" must be expressed without a pushforward, since $f$ is not measurable: for each measurable $A \subseteq Y$ there is a measurable $B \subseteq X$ that agrees with $f^{-1}(A)$ outside a $\lvert \mu\rvert$-null set, and $\mu(B) = \nu(A)$. | ✅ `∀ A, MeasurableSet A → ∃ B, MeasurableSet B ∧ (∀ᵐ x ∂μ.totalVariation, x ∈ B ↔ x ∈ f ⁻¹' A) ∧ μ B = ν A`. |
| 9 | The norm equality $\lVert \mu\rVert = \lVert \nu\rVert$. | ✅ `μ.totalVariation univ = ν.totalVariation univ`. |
| 10 | The "in particular" corollary: the conclusion also holds when $X$ and $Y$ are compact and $f$ is a continuous surjection, with no compact-approximation hypothesis. | ✅ Second conjunct, under `CompactSpace X → CompactSpace Y → Continuous f → Function.Surjective f`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Adding `Measurable f` or `Continuous f` to the hypotheses of the first part. | Assumes away the content. The theorem's job is to build a measure for a map that is only continuous on the compacts $K_n$. |
| 2 | Writing the image measure as `Measure.map f μ = ν` or a signed-measure analogue. | For a map that is not a.e. measurable, `Measure.map` is defined to be the zero measure, so the equation would hold or fail for reasons that have nothing to do with the theorem. |
| 3 | Restricting to nonnegative measures. | The book's measures are signed, and the norm bookkeeping via total variation is a real part of the statement; the nonnegative case is materially simpler. |
| 4 | Encoding "Radon" as outer regularity, or asserting inner regularity only for $\nu$ and not for the produced $\mu$. | The measure produced must itself be Radon; that is what makes the conclusion useful. Inner regularity with respect to compact sets is the defining property. |
| 5 | Dropping the norm equality $\lVert \mu\rVert = \lVert \nu\rVert$, or asserting it for a possibly different $\mu$ than the one with image $\nu$. | The book says a single $\mu$ can be chosen with both properties, so it must be one existential with a conjunction, not two separate claims. |
| 6 | Dropping monotonicity of the $K_n$. | Stated in the theorem, and the increasing structure is what lets the images exhaust the mass. |
| 7 | Omitting the compact-surjection corollary. | It is part of the printed theorem. |
| 8 | Requiring $f(K_n)$ to be measurable in order to state the approximation hypothesis. | An extra assumption the book does not make. Applying `totalVariation` to an arbitrary set is legitimate — Mathlib measures are outer measures defined on all sets. |

## Notes on the ground truth

- The book's "$f$ is $\lvert \mu\rvert$-measurable and the image measure is $\nu$" is what
  requirement 8 spells out. Measurability with respect to the completion of $\lvert \mu\rvert$ is
  exactly the statement that each preimage agrees with a measurable set off a null set.
- The a.e. statement is taken with respect to `μ.totalVariation`, the total variation of the
  *produced* measure, which is the correct reference measure for its own completion.
- The two parts of the theorem are packaged as one conjunction of implications so that they can
  share `hν`. Splitting into two theorems would be more idiomatic.
- The sequence `K : ℕ → Set X` is a parameter of the whole declaration even though the second
  conjunct never mentions it. Harmless: the second conjunct is then asserted for every choice of
  `K`, which is the same as asserting it once.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[bogachev_9_1_9_radon_preimage_from_compact_approximation.md](bogachev_9_1_9_radon_preimage_from_compact_approximation.md) and the background in [bogachev_9_1_9_radon_preimage_from_compact_approximation.context.md](bogachev_9_1_9_radon_preimage_from_compact_approximation.context.md),
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

- Requirement 2: adding global measurability or continuity of $f$ to the hypotheses, which assumes away what the theorem constructs.
- Requirement 8: expressing $\mu \circ f^{-1} = \nu$ as a pushforward `Measure.map f μ = ν`, which for a non-measurable $f$ is the zero measure.
- Requirement 7: producing the Radon property, the norm equality and the image equation for possibly *different* measures rather than for one $\mu$.

### Domain-specific pitfalls for this problem

- Junk value — pushforward: `Measure.map f μ` collapses to `0` unless `f` is a.e. measurable, precisely the situation here. The image condition must be spelled out set by set.
- Radon means *inner* regularity of the total variation with respect to compacts (`Measure.InnerRegular ν.totalVariation`). Outer regularity is a different property and does not give the theorem.
- $|\nu|$ applied to the non-measurable set $f(K_n)$ is the outer measure and is perfectly meaningful; adding a measurability hypothesis on $f(K_n)$ is an extra assumption the book does not make.
- The variation norm is `ν.totalVariation univ`, a value in `ℝ≥0∞`; comparing it with an `ℝ`-valued norm requires a coercion that can lose the infinite case.
- The compact-surjection corollary is a second conjunct with its own hypotheses, not a consequence a reader may leave implicit.
