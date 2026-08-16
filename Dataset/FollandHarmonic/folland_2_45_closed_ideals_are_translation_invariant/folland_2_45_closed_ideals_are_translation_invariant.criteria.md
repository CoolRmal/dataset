# Criteria: folland_2_45_closed_ideals_are_translation_invariant

**Statement:** [folland_2_45_closed_ideals_are_translation_invariant.md](folland_2_45_closed_ideals_are_translation_invariant.md) · **Lean:** [folland_2_45_closed_ideals_are_translation_invariant.lean](folland_2_45_closed_ideals_are_translation_invariant.lean) · **Context:** [folland_2_45_closed_ideals_are_translation_invariant.context.md](folland_2_45_closed_ideals_are_translation_invariant.context.md)

## What the theorem says

$L^1(G)$ is an algebra under convolution. Let $I$ be a closed linear subspace of it. The theorem
identifies the ideals of this algebra in purely geometric terms: $I$ is a left ideal — closed under
$f \mapsto g * f$ for every $g \in L^1$ — exactly when it is closed under the left translations
$L_yf(x) = f(y^{-1}x)$. And $I$ is a right ideal — closed under $f \mapsto f * g$ — exactly when it
is closed under the right translations $R_yf(x) = f(xy)$.

One direction comes from approximating $L_yf$ by $\psi * f$ for bumps $\psi$ concentrated near $y$;
the other from writing $g * f = \int g(y)\,L_yf\,dy$ as a limit of linear combinations of translates.
Both directions use that $I$ is a linear subspace and that it is closed.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $G$ is a locally compact topological group with its Borel structure, and $\mu$ is a **left** Haar measure. | ✅ `[IsTopologicalGroup G] [LocallyCompactSpace G] [BorelSpace G]`, `(μ : Measure G) [μ.IsHaarMeasure]`. |
| 2 | $I$ is a linear subspace over $\mathbb{C}$. | ✅ `I : Submodule ℂ (G → ℂ)`. |
| 3 | $I$ is closed for the $L^1$ distance: any $L^1$ function that can be approximated to within every $\varepsilon$ by members of $I$ is itself in $I$. | ✅ `hclosed : IsLpClosed 1 μ (I : Set (G → ℂ))`, with `IsLpClosed` spelled out in `Defs.lean`. |
| 4 | Every member of $I$ is an integrable function. | ✅ `hmem : ∀ f ∈ I, Integrable f μ`. |
| 5 | Both equivalences are asserted, and each is a genuine `↔`. | ✅ A conjunction of two `↔`. |
| 6 | "Left ideal" means closed under $g * f$ for arbitrary integrable $g$, with $g$ on the **left**. | ✅ `∀ g : G → ℂ, Integrable g μ → ∀ f ∈ I, groupConv μ g f ∈ I`. |
| 7 | "Closed under left translations" means $L_yf(x) = f(y^{-1}x)$ lands in $I$, for every $y$ and every $f \in I$. | ✅ `∀ (y : G), ∀ f ∈ I, leftTranslate y f ∈ I`. |
| 8 | "Right ideal" means closed under $f * g$, with the member of $I$ on the **left**. | ✅ `∀ g : G → ℂ, Integrable g μ → ∀ f ∈ I, groupConv μ f g ∈ I`. |
| 9 | "Closed under right translations" means $R_yf(x) = f(xy)$ lands in $I$. | ✅ `∀ (y : G), ∀ f ∈ I, rightTranslate y f ∈ I`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Keeping only the left-ideal equivalence. | The left/right asymmetry is the point of the theorem on a non-abelian group. Half the statement is missing. |
| 2 | Stating an implication instead of an equivalence. | Both directions are theorems and neither is formal. Either implication alone is strictly weaker. |
| 3 | Dropping the $L^1$-closedness hypothesis. | Both directions break. The passage from an ideal to translation invariance realises $L_yf$ as a limit of elements $\psi * f$ of $I$; the passage back realises $g*f$ as a limit of linear combinations of translates. Without closedness neither limit is in $I$. |
| 4 | Taking $I$ to be just a set rather than a linear subspace. | The converse direction needs to add up finitely many translates before taking the limit. A translation-invariant set that is not a subspace need not be an ideal. |
| 5 | Pairing "left ideal" with $f * g$ instead of $g * f$. | On a non-abelian group these are different conditions, and the theorem then matches the wrong translation side. |
| 6 | Writing the left translate as `fun x ↦ f (y * x)`. | Folland's $L_y$ inverts the group element. Writing $f(yx)$ gives the translation by $y^{-1}$; the family of all such maps is the same family, but any statement that fixes $y$ or relates $L_y$ to convolution by a bump near $y$ becomes wrong. |
| 7 | Omitting the hypothesis that members of $I$ are integrable. | `groupConv μ g f x` is the value `0` wherever its defining integral diverges. Without integrability the "ideal" conditions are conditions about a function that has been silently zeroed out. |

## Notes on the ground truth

- Mathlib has no $L^1(G)$ Banach algebra for a general locally compact group. The statement
  therefore works with honest functions: `Submodule ℂ (G → ℂ)` for the linear structure, and
  `IsLpClosed 1 μ` for closedness. This is faithful — the image in the $L^1$ quotient of an
  $L^1$-closed subspace of functions is a closed subspace, and conversely — but a candidate must
  supply *both* the linearity and the closedness, since either alone is strictly weaker.
- `IsLpClosed p μ I` is defined in `Defs.lean` as: every $f \in L^p$ that is within $\varepsilon$ of
  some member of $I$ for every $\varepsilon > 0$ belongs to $I$. Taking $\varepsilon$ small forces
  $I$ to contain every function almost everywhere equal to one of its members, which is exactly
  what a subspace of functions representing a closed subspace of $L^1$ should do.
- Mathlib's `Measure.IsHaarMeasure` is the left-invariant notion, which is what the whole statement
  is set against.
- Inside `IsLpClosed` the clause `MemLp g p μ` is redundant here given `hmem`; it is part of the
  general definition and costs nothing.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[folland_2_45_closed_ideals_are_translation_invariant.md](folland_2_45_closed_ideals_are_translation_invariant.md) and the background in [folland_2_45_closed_ideals_are_translation_invariant.context.md](folland_2_45_closed_ideals_are_translation_invariant.context.md),
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

- Requirement 3 with the closedness hypothesis dropped: the theorem is false for non-closed subspaces.
- Requirement 6 or 8 with the left/right pairing crossed (left ideals matched to right translations).
- Requirement 5 with either equivalence stated as a single implication.

### Domain-specific pitfalls for this problem

- Which side the arbitrary $L^1$ function multiplies on distinguishes left from right ideals; on a non-abelian group the two are genuinely different.
- Closedness is in the $L^1$ topology; a formalization has to say what it means for a set of functions (rather than of a.e. classes) to be $L^1$-closed.
- Left translation carries the inverse, $L_yf(x) = f(y^{-1}x)$.
- Membership in $I$ has to come with integrability, since the ambient object is $L^1$.
