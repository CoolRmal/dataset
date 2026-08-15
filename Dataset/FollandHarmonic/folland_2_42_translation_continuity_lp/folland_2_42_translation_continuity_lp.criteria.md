# Criteria: folland_2_42_translation_continuity_lp

**Statement:** [folland_2_42_translation_continuity_lp.md](folland_2_42_translation_continuity_lp.md) · **Lean:** [folland_2_42_translation_continuity_lp.lean](folland_2_42_translation_continuity_lp.lean) · **Context:** [folland_2_42_translation_continuity_lp.context.md](folland_2_42_translation_continuity_lp.context.md)

## What the theorem says

On a locally compact group $G$ with a left Haar measure, translating a function moves it only a
little in $L^p$ provided the translation is by an element close to the identity. Precisely: fix
$1 \le p < \infty$ and $f \in L^p(G)$. Write $L_yf(x) = f(y^{-1}x)$ and $R_yf(x) = f(xy)$. Then both
$\lVert L_yf - f\rVert_p$ and $\lVert R_yf - f\rVert_p$ tend to $0$ as $y$ tends to the group identity.

The restriction $p < \infty$ is essential. On $L^\infty$ the statement fails: the indicator of an
interval stays at distance $1$ from all of its nontrivial translates.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $G$ is a locally compact topological group with its Borel structure, and $\mu$ is a left Haar measure. | ✅ `[IsTopologicalGroup G] [LocallyCompactSpace G] [BorelSpace G]`, `(μ : Measure G) [μ.IsHaarMeasure]`. |
| 2 | The exponent satisfies $1 \le p$. | ✅ `hp : 1 ≤ p`. |
| 3 | The exponent is finite. | ✅ `hp' : p ≠ ∞`. |
| 4 | $f$ lies in $L^p$. | ✅ `hf : MemLp f p μ`. |
| 5 | The left translate is $L_yf(x) = f(y^{-1}x)$. | ✅ `leftTranslate y f`, defined in `Defs.lean` as `fun x ↦ f (y⁻¹ * x)`. |
| 6 | The right translate is $R_yf(x) = f(xy)$. | ✅ `rightTranslate y f`, defined as `fun x ↦ f (x * y)`. |
| 7 | Both limits are asserted. | ✅ A conjunction of two `Tendsto` statements. |
| 8 | The limit is taken as $y$ approaches the group identity, along the whole neighbourhood filter. | ✅ `Tendsto … (𝓝 (1 : G)) …`. |
| 9 | The quantity going to zero is the $L^p$ seminorm of the difference, and its limit is $0$. | ✅ `fun y ↦ eLpNorm (leftTranslate y f - f) p μ` tending to `𝓝 0`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Allowing $p = \infty$. | The proposition is false there. On $\mathbb{R}$ with $f$ the indicator of $[0,1]$, $\lVert L_yf - f\rVert_\infty = 1$ for every $y \ne 0$, however small. This is the highest-value trap. |
| 2 | Asserting only the left-translation limit. | Half the proposition. The right-translate case is not a formal consequence, because the Haar measure is only left invariant and the modular function enters the proof. |
| 3 | Taking the limit along a sequence $y_n \to 1$, or along `atTop`, instead of the neighbourhood filter of $1$. | On a general topological group the filter $\mathcal{N}(1)$ need not be countably generated, so a sequential limit is a strictly weaker statement. |
| 4 | Restricting $f$ to be continuous with compact support. | That is the easy case and is the first step of the actual proof. The proposition is about all of $L^p$. |
| 5 | Concluding pointwise or almost-everywhere convergence $L_yf \to f$ instead of convergence in the $L^p$ norm. | A different, and generally false, statement: an $L^p$ function has no pointwise regularity at all. |
| 6 | Using an arbitrary measure instead of a Haar measure. | Without invariance, translating can change the norm by an arbitrary amount and the limit need not exist. |
| 7 | Stating that the limit exists, or that $y \mapsto \lVert L_yf - f\rVert_p$ is continuous, without saying the limit is $0$. | The value of the limit is the whole content. |

## Notes on the ground truth

- `leftTranslate` and `rightTranslate` are one-line definitions in `Defs.lean`, shared by four
  problems in this book. Mathlib has no $L_y$/$R_y$ for scalar functions on a general group, so
  defining them is warranted rather than a pointless wrapper.
- `eLpNorm` is `ℝ≥0∞`-valued, so the target of the limit is `𝓝 (0 : ℝ≥0∞)`. Nothing in the statement
  presupposes that the seminorm is finite, although `hf` makes it so.
- `leftTranslate y f - f` is pointwise subtraction of functions `G → ℂ`, which is what the book's
  $L_yf - f$ means.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[folland_2_42_translation_continuity_lp.md](folland_2_42_translation_continuity_lp.md) and the background in [folland_2_42_translation_continuity_lp.context.md](folland_2_42_translation_continuity_lp.context.md),
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

- Requirement 3 with $p = \infty$ admitted: the statement is then false.
- Requirement 7 with only one of the two translations.
- Requirement 8 with the limit taken along a sequence rather than along the neighbourhood filter of $1$.

### Domain-specific pitfalls for this problem

- $L_y f(x) = f(y^{-1}x)$ and $R_y f(x) = f(xy)$ — the inverse appears on the left translate only.
- The limit is along `𝓝 (1 : G)`, the neighbourhood filter of the group identity; a sequential formulation is weaker on a non-metrizable group.
- The quantity tending to $0$ is the $L^p$ seminorm of the *difference*, which for `eLpNorm` lives in `ℝ≥0∞`.
- The right-translation half is independent of the left-translation half on a non-unimodular group.
