# Criteria: conway_VIII_3_6_positive_element_characterizations

**Statement:** [conway_VIII_3_6_positive_element_characterizations.md](conway_VIII_3_6_positive_element_characterizations.md) · **Lean:** [conway_VIII_3_6_positive_element_characterizations.lean](conway_VIII_3_6_positive_element_characterizations.lean) · **Context:** [conway_VIII_3_6_positive_element_characterizations.context.md](conway_VIII_3_6_positive_element_characterizations.context.md)

## What the theorem says

Let $\mathcal{A}$ be a $C^*$-algebra and $a$ an element of it. Five conditions on $a$ are all
equivalent: $a$ is positive; $a$ is the square of a self-adjoint element; $a$ has the form $x^*x$;
$a$ is self-adjoint and $\lVert t - a\rVert \le t$ for every real $t \ge \lVert a\rVert$; and $a$ is
self-adjoint and $\lVert t - a\rVert \le t$ for at least one such $t$. The last two are the sharp
pair: "for all $t$" and "for some $t$" turn out to say the same thing.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The algebra is a *unital* $C^*$-algebra. Items (d) and (e) subtract a scalar from $a$, so a unit must exist. | ✅ `[CStarAlgebra A]`, which is Mathlib's unital class (`NonUnitalCStarAlgebra` is the other one), and the scalar enters as `algebraMap ℂ A (t : ℂ)`. |
| 2 | Item (a) is positivity in the $C^*$-order, which Conway defines spectrally: $a = a^*$ and $\sigma(a) \subseteq [0,\infty)$. | ✅ `0 ≤ a` with respect to `[PartialOrder A] [StarOrderedRing A]`, Mathlib's interface for that order (it is not an instance on `CStarAlgebra`, to avoid diamonds; `CStarAlgebra.spectralOrder`/`spectralOrderedRing` build it). `StarOrderedRing.nonneg_iff_spectrum_nonneg` shows it agrees with Conway's definition. |
| 3 | Item (b): $a = b^2$ for some $b$ in the self-adjoint part $\operatorname{Re}\mathcal{A}$ — both the self-adjointness of $b$ and the equation are needed. | ✅ `∃ b : A, IsSelfAdjoint b ∧ a = b ^ 2`. |
| 4 | Item (c): $a = x^*x$ for some $x$, with no condition on $x$. | ✅ `∃ x : A, a = star x * x`. |
| 5 | Item (d): $a$ self-adjoint **and** $\lVert t - a\rVert \le t$ for **all** real $t \ge \lVert a\rVert$. | ✅ `IsSelfAdjoint a ∧ ∀ t : ℝ, ‖a‖ ≤ t → ‖algebraMap ℂ A (t : ℂ) - a‖ ≤ t`. |
| 6 | Item (e): $a$ self-adjoint **and** $\lVert t - a\rVert \le t$ for **some** real $t \ge \lVert a\rVert$. | ✅ `IsSelfAdjoint a ∧ ∃ t : ℝ, ‖a‖ ≤ t ∧ ‖algebraMap ℂ A (t : ℂ) - a‖ ≤ t`. |
| 7 | The self-adjointness clause appears in **both** (d) and (e), not just in (d). | ✅ Both `let`s open with `IsSelfAdjoint a ∧ …`. |
| 8 | All five items form one equivalence, with (d) and (e) kept apart. | ✅ `List.TFAE [0 ≤ a, hermitianSquare, starSquare, normBoundForAll, normBoundForSome]` — a list of length 5. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Avoiding `StarOrderedRing` by *defining* item (a) as `∃ x, a = star x * x`. | Items (a) and (c) become the same proposition, so their equivalence is a tautology — and (a) ⟹ (c) is the hardest implication in Conway's proof. The theorem is gutted. |
| 2 | Defining item (a) as `∀ z ∈ spectrum ℂ a, 0 ≤ z.re`, with no self-adjointness clause. | Spectrum in the right half-plane does not imply positivity; the self-adjointness is part of the definition. |
| 3 | Writing item (b) as `∃ b, a = b * b` without `IsSelfAdjoint b`. | A different and false characterization: a non-self-adjoint $b$ can have $b^2$ non-positive, even non-self-adjoint. Conway writes $b \in \operatorname{Re}\mathcal{A}$ deliberately. |
| 4 | Writing item (b) as `∃ b, a = star b * b`. | That is item (c) again, so (b) and (c) collapse into one and the equivalence loses content. |
| 5 | Merging (d) and (e) into one item, or keeping only (d). | The implication (e) ⟹ (a) is the strongest one in the theorem; a single all-quantified item removes it. |
| 6 | Keeping `a = a*` in (d) but dropping it from (e). | Without self-adjointness (e) is not a characterization of positivity — a suitable non-self-adjoint $a$ satisfies the norm inequality. |
| 7 | Working in a non-unital $C^*$-algebra, or writing the scalar as a bare coercion `(t : A)`. | In the non-unital setting $t - a$ cannot be formed, so items (d) and (e) do not even typecheck; and there is no coercion `ℝ → A` to make `(t : A)` mean $t\cdot 1$. |

## Notes on the ground truth

- Using the abstract `StarOrderedRing` order keeps the theorem non-trivial. That class's axiom only
  gives `0 ≤ a ↔ a ∈ AddSubmonoid.closure (Set.range fun s ↦ star s * s)`, i.e. $a$ is a finite
  *sum* of terms $s^*s$. Item (c) asks for a *single* such term, so (a) ⟺ (c) still has real
  content.
- A spectral spelling of item (a) — `IsSelfAdjoint a ∧ ∀ z ∈ spectrum ℝ a, 0 ≤ z` — is equally
  faithful to Conway and should be accepted in a candidate.
- The scalar in (d) and (e) is `(t : ℝ) • (1 : A)`: a real multiple of the unit, which is what
  `t - a` means in the text.
- The items are `let`-bound propositions combined with `List.TFAE`, matching how the other
  multi-part equivalences in this book's files are written.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[conway_VIII_3_6_positive_element_characterizations.md](conway_VIII_3_6_positive_element_characterizations.md) and the background in [conway_VIII_3_6_positive_element_characterizations.context.md](conway_VIII_3_6_positive_element_characterizations.context.md),
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

- Requirement 7: dropping the self-adjointness clause from (d) or from (e).
- Requirement 8 with (d) and (e) merged, or with a proper subset of the five items.
- Requirement 1: dropping unitality, which makes (d) and (e) meaningless.

### Domain-specific pitfalls for this problem

- $\operatorname{Re}\mathcal{A}$ is the self-adjoint part of the algebra, not a real part of a scalar; item (b) requires $b$ self-adjoint *and* $a = b^2$.
- $t$ is a real scalar acting through the unit: $t - a$ is $t \cdot 1 - a$, so the statement needs the algebra map from the scalars.
- (d) quantifies over all $t \ge \lVert a\rVert$ and (e) over some such $t$; collapsing them loses the theorem's point.
- Which partial order `0 ≤ a` refers to matters. In Mathlib the order on a $C^*$-algebra comes from `StarOrderedRing`, whose defining property already relates positivity to sums of elements $x^*x$; a candidate should not be scored as having proved (a) ⇔ (c) for free, but nor is using that order an error.
- Item (c) puts no condition on $x$ at all.
