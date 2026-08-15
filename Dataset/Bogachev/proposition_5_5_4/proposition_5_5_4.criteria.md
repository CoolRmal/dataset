# Criteria: proposition_5_5_4

**Statement:** [proposition_5_5_4.md](proposition_5_5_4.md) · **Lean:** [proposition_5_5_4.lean](proposition_5_5_4.lean) · **Context:** [proposition_5_5_4.context.md](proposition_5_5_4.context.md)

## What the theorem says

Let $f$ be any function on the real line and let $E$ be a measurable set at every point of which $f$
is differentiable. Then the measure of the image $f(E)$ is at most the integral of $\lvert f'\rvert$
over $E$. Two consequences follow. First, $f$ has Lusin's property (N) on $E$: null subsets of $E$
have null images. Second, if $\lvert f'\rvert \le L$ throughout $E$, then $f$ can expand $E$ by at
most the factor $L$, so $\lambda(f(E)) \le L\,\lambda(E)$. Neither $f(E)$ nor $\lvert f'\rvert$ is
assumed to be well behaved: the image may fail to be measurable and the integral may be infinite.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $E$ is a Lebesgue measurable subset of $\mathbb{R}$. | ✅ `hE : NullMeasurableSet E volume`. |
| 2 | $f$ is differentiable at each point of $E$, in the ordinary two-sided sense on the line. | ✅ `hf : ∀ x ∈ E, DifferentiableAt ℝ f x`. |
| 3 | Nothing else is assumed about $f$ — no measurability, no continuity off $E$. | ✅ `f : ℝ → ℝ` with only `hf`. |
| 4 | First conclusion: $\lambda(f(E)) \le \int_E \lvert f'\rvert$. | ✅ `volume (f '' E) ≤ ∫⁻ x in E, ENNReal.ofReal (abs (deriv f x)) ∂volume`. |
| 5 | The left side measures a set that need not be measurable. | ✅ `volume (f '' E)` — Mathlib measures are outer measures defined on every set, which is the textbook reading. |
| 6 | The right side stays meaningful when $\lvert f'\rvert$ is not integrable over $E$. | ✅ The lower Lebesgue integral `∫⁻ … ∂volume` valued in `ℝ≥0∞`. |
| 7 | The derivative is only ever used at points of $E$. | ✅ Every occurrence of `deriv f` sits inside the integral restricted to `E`, or under the hypothesis `∀ x ∈ E`. |
| 8 | Second conclusion: $f$ has Lusin's property (N) *on* $E$, i.e. for null $A \subseteq E$ the image $f(A)$ is null. | ✅ `HasLusinPropertyNOn f E volume volume`, which quantifies over `A ⊆ E`. |
| 9 | Third conclusion: for every $L$ with $\lvert f'(x)\rvert \le L$ on $E$, one gets $\lambda(f(E)) \le L\,\lambda(E)$. | ✅ `∀ L : ℝ, (∀ x ∈ E, abs (deriv f x) ≤ L) → volume (f '' E) ≤ ENNReal.ofReal L * volume E`. |
| 10 | All three conclusions are asserted together. | ✅ A three-way conjunction. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Writing the hypothesis as `DifferentiableOn ℝ f E`. | That is differentiability *within* $E$, which is strictly weaker whenever $E$ has empty interior — at an isolated point of $E$ every function qualifies. Combined with `deriv f` in the integrand it is unsound: at points where $f$ is not differentiable as a function on the line, `deriv f x` is Lean's default $0$, so the right-hand side can collapse to $0$ while the hypothesis still holds. The book means differentiability of $f$ as a function on the line. |
| 2 | Writing the right-hand side as a Bochner integral `∫ x in E, \|deriv f x\|`. | When $\lvert f'\rvert$ is not integrable over $E$, Lean gives that integral the value $0$, and the inequality then claims $f(E)$ is null — false, and precisely in the cases where the bound matters most. |
| 3 | Adding a hypothesis that $f(E)$ is measurable, or wrapping it in a completion. | The proposition asserts an outer-measure bound with no measurability of the image. Adding the assumption weakens the statement. |
| 4 | Using Borel `MeasurableSet E` instead of Lebesgue measurability. | The book's "measurable set" on the line is Lebesgue measurable. |
| 5 | Dropping the property (N) clause or the $L$-bound clause. | These are the "in particular" sentences and are the parts models most often omit; both are asserted by the proposition. |
| 6 | Stating property (N) globally for $f$ rather than relative to $E$. | Outside $E$ nothing is assumed about $f$, so global property (N) is false in general. The claim is only about null subsets of $E$. |
| 7 | Fixing one particular $L$ in the theorem's hypotheses instead of quantifying over all $L$ inside the conclusion. | The book's third assertion is conditional on a bound holding; it must be stated for every $L$ that satisfies the bound. |
| 8 | Integrating `deriv f` over a set larger than $E$. | Off $E$ the value of `deriv f` is Lean's default and carries no meaning, so such an integral asserts nothing about $f$. |

## Notes on the ground truth

- `deriv f x` returns $0$ at points where $f$ is not differentiable. That default value never
  matters here because every use is guarded by $x \in E$, where `hf` supplies differentiability.
- The $L$-bound conclusion is stated in `ℝ≥0∞` as `ENNReal.ofReal L * volume E`. The corner cases
  behave: if $E$ is nonempty then the hypothesis forces $L \ge 0$; if $L$ is negative then $E$ must
  be empty and both sides are $0$; if $\lambda(E) = \infty$ and $L = 0$ the product is $0$ in
  `ℝ≥0∞`, and indeed $f' = 0$ on $E$ then forces $f(E)$ to be null.
- `HasLusinPropertyNOn f E μ ν` is defined in `Defs.lean` as the relative version of Definition
  3.6.8: null subsets *of $E$* have null images. Using global property (N) of `Set.restrict f E`
  would change which sets are being imaged.
- The lower Lebesgue integral in Lean is defined for any function as the supremum of the integrals
  of measurable simple functions beneath it. Since $f$ itself is not assumed measurable,
  `deriv f` need not be measurable on $E$ either, so this value can be smaller than the upper
  integral the book has in mind — meaning the Lean statement is, if anything, slightly stronger than
  the printed one. A candidate that writes the same `∫⁻` is on equal footing.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[proposition_5_5_4.md](proposition_5_5_4.md) and the background in [proposition_5_5_4.context.md](proposition_5_5_4.context.md),
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

- Requirement 2 weakened to `DifferentiableOn ℝ f E` (differentiability within $E$): the hypothesis becomes vacuous on sets with empty interior and the proposition is false.
- Requirement 6: writing the right-hand side as a Bochner integral, which is `0` for a non-integrable $|f'|$ and would then assert that $f(E)$ is null.
- Requirement 8 stated globally rather than relative to $E$: global property (N) does not follow, since $f$ is unconstrained off $E$.

### Domain-specific pitfalls for this problem

- Junk value — Bochner integral: `∫ x in E, |deriv f x|` is `0` when $|f'|$ is not integrable over $E$, turning the inequality into the false claim $\lambda(f(E)) = 0$. Use the lower Lebesgue integral into `ℝ≥0∞`.
- Junk value — `deriv`: `deriv f x` is `0` wherever $f$ is not differentiable, so any occurrence outside $E$ is meaningless. Every use must sit under `x ∈ E`.
- `DifferentiableAt ℝ f x` for `x ∈ E` versus `DifferentiableOn ℝ f E` is the concept confusion of this problem: the latter is `DifferentiableWithinAt` and is much weaker.
- $\lambda(f(E))$ is an outer measure of a possibly non-measurable set; Mathlib measures already apply to every set, so no completion or measurability hypothesis is needed or wanted.
- "Measurable set $E$" on the line means Lebesgue measurable (`NullMeasurableSet E volume`), not Borel.
- The constant $L$ is universally quantified *inside* the third conclusion, with the bound as its hypothesis; hoisting $L$ into the proposition's binders states something weaker.
