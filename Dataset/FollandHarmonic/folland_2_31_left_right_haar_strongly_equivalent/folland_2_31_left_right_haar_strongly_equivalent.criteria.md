# Criteria: folland_2_31_left_right_haar_strongly_equivalent

**Statement:** [folland_2_31_left_right_haar_strongly_equivalent.md](folland_2_31_left_right_haar_strongly_equivalent.md) · **Lean:** [folland_2_31_left_right_haar_strongly_equivalent.lean](folland_2_31_left_right_haar_strongly_equivalent.lean) · **Context:** [folland_2_31_left_right_haar_strongly_equivalent.context.md](folland_2_31_left_right_haar_strongly_equivalent.context.md)

## What the theorem says

Fix a left Haar measure $\lambda$ on a locally compact group $G$, and let $\Delta$ be the modular
function, defined by $\lambda(Ex) = \Delta(x)\lambda(E)$. To $\lambda$ is associated the specific
right Haar measure $\rho(E) = \lambda(E^{-1})$. The proposition makes two assertions.

First, $\lambda$ and $\rho$ are *strongly equivalent* in the sense of Folland's Proposition 2.23:
there is a **continuous, strictly positive** density $f$ with
$\int\varphi\,d\rho = \int\varphi f\,d\lambda$ for every $\varphi \in C_c(G)$. This is strictly
stronger than mutual absolute continuity. Second, the density is identified:
$d\rho(x) = \Delta(x^{-1})\,d\lambda(x)$, i.e. $\rho(E) = \int_E \Delta(x^{-1})\,d\lambda(x)$ for
every Borel set $E$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $G$ is a locally compact topological group carrying its Borel structure. | ✅ `[IsTopologicalGroup G] [LocallyCompactSpace G] [MeasurableSpace G] [BorelSpace G]`. |
| 2 | $\lambda$ is a **left** Haar measure. | ✅ `(lam : Measure G) [lam.IsHaarMeasure]`; Mathlib's `IsHaarMeasure` is the left-invariant notion. |
| 3 | $\rho$ is the specific right Haar measure $\rho(E) = \lambda(E^{-1})$ associated to $\lambda$, not an arbitrary right Haar measure. | ✅ `lam.map (·⁻¹)`: inversion is an involutive measurable equivalence, so `(lam.map (·⁻¹)) E = lam E⁻¹`. |
| 4 | Strong equivalence of $\lambda$ and $\rho$ is asserted, in the 2.23 sense: a **continuous, strictly positive** density relating the two against all of $C_c(G)$. | ✅ `StronglyEquivalent lam (lam.map (·⁻¹))`, defined in `Defs.lean` as `∃ f : X → ℝ, Continuous f ∧ (∀ x, 0 < f x) ∧ ∀ φ, Continuous φ → HasCompactSupport φ → ∫ x, φ x ∂ν = ∫ x, φ x * f x ∂μ`. |
| 5 | The density identity $d\rho(x) = \Delta(x^{-1})\,d\lambda(x)$ is asserted setwise: $\rho(E) = \int_E \Delta(x^{-1})\,d\lambda$ for measurable $E$. | ✅ `∀ E : Set G, MeasurableSet E → (lam.map (·⁻¹)) E = ∫⁻ x in E, ((Measure.modularCharacterFun x : ℝ≥0) : ℝ≥0∞) ∂lam`. |
| 6 | The weight is Folland's $\Delta(x^{-1})$. | ✅ `Measure.modularCharacterFun x` — Mathlib's `modularCharacterFun x` *is* Folland's $\Delta(x^{-1})$; see the notes. |
| 7 | The set identity holds for **all** measurable sets, with no finiteness restriction. | ✅ Only `MeasurableSet E` is assumed; both sides live in `ℝ≥0∞` via the lower integral `∫⁻`, so no integrability caveat is needed. |
| 8 | Both conjuncts are asserted: the strong equivalence and the identification of the density. | ✅ A conjunction of the two. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Writing `Measure.modularCharacterFun x⁻¹` as the weight. | In Mathlib's convention that expression is Folland's $\Delta(x)$, the reciprocal of the correct weight. The two agree on every unimodular group, so this error is invisible on all abelian and all compact examples; the $ax+b$ group separates them. This is the highest-value trap in this problem. |
| 2 | Omitting the weight altogether, asserting $\rho = \lambda$ or $\lambda(E^{-1}) = \lambda(E)$. | That says inversion preserves left Haar measure, which is true only when $G$ is unimodular. |
| 3 | Rendering "strongly equivalent" as mutual absolute continuity, `lam ≪ ρ ∧ ρ ≪ lam`. | Folland's strong equivalence (2.23) demands a *continuous, strictly positive* density; mutual absolute continuity supplies only a measurable Radon–Nikodym derivative and is explicitly the weaker notion the `.md` warns about. |
| 4 | Dropping continuity or strict positivity from the density in the strong-equivalence clause. | Either omission collapses the notion toward plain absolute continuity; strict positivity is what makes the relation symmetric in the two measures. |
| 5 | Stating the density identity with a Bochner integral of a real-valued weight over arbitrary measurable $E$. | For $E$ of infinite $\rho$-measure the weight is not integrable on $E$, and Lean's Bochner integral junk-defaults to `0`, so the identity would be false there. The comparison must happen in `ℝ≥0∞` (a lower integral), as the ground truth does, or be restricted to sets where both sides are finite. |
| 6 | Using an arbitrary right Haar measure in place of $\rho(E) = \lambda(E^{-1})$. | An arbitrary right Haar measure agrees with $\rho$ only up to a positive constant, so the density identity as printed is then false (off by that constant). |
| 7 | Asserting only one conjunct — strong equivalence without identifying the density, or the density formula without strong equivalence. | Each is half the proposition. Its content is that the *specific* weight $\Delta(x^{-1})$, which is continuous and strictly positive, realises the strong equivalence. |

## Notes on the ground truth

- **Convention.** Mathlib's `Measure.modularCharacterFun` satisfies
  `map (· * g) μ = modularCharacterFun g • μ`, i.e. $\mu(Ag^{-1}) = \Delta_M(g)\,\mu(A)$. Folland's
  $\Delta$ satisfies $\lambda(Ex) = \Delta(x)\lambda(E)$, so $\Delta_M(g) = \Delta_{\text{Folland}}(g)^{-1}$
  and therefore Folland's $\Delta(x^{-1})$ is Mathlib's `modularCharacterFun x`. The Lean statement
  writes `modularCharacterFun x` for this reason.
- `StronglyEquivalent` is defined in `Defs.lean`, transcribing the hypothesis of Folland's
  Proposition 2.23: a continuous, everywhere-positive real density tested against every continuous
  compactly supported function. Mathlib has no such notion, so defining it is warranted.
- The associated right Haar measure is the pushforward `lam.map (·⁻¹)`; since inversion is its own
  inverse, this is exactly $E \mapsto \lambda(E^{-1})$.
- The density identity is stated with the lower integral `∫⁻` and the `ℝ≥0`-valued
  `modularCharacterFun` coerced into `ℝ≥0∞`, so both sides live in `ℝ≥0∞`: the identity needs no
  integrability hypothesis, remains meaningful where both sides are infinite, and involves no junk
  value.
- The measure `lam` is an arbitrary left Haar measure, not a distinguished one; both conjuncts are
  insensitive to rescaling `lam`, so this is the right level of generality.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[folland_2_31_left_right_haar_strongly_equivalent.md](folland_2_31_left_right_haar_strongly_equivalent.md) and the background in [folland_2_31_left_right_haar_strongly_equivalent.context.md](folland_2_31_left_right_haar_strongly_equivalent.context.md),
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

- Requirement 6 with the weight taken at the wrong point (`modularCharacterFun x⁻¹`), so that the density identity asserted is the reciprocal one: false on any non-unimodular group.
- Requirement 4 with strong equivalence weakened to mutual absolute continuity, or with the continuity or strict positivity of the density dropped.
- Requirement 3 with $\rho$ not the inversion pushforward of $\lambda$ — e.g. an arbitrary right Haar measure, for which the identity is off by a constant.

### Domain-specific pitfalls for this problem

- The modular-function convention decides whether the weight is written $\Delta(x)$ or $\Delta(x^{-1})$. Mathlib's `Measure.modularCharacterFun` satisfies `map (· * g) μ = modularCharacterFun g • μ`, i.e. $\mu(Eg^{-1}) = \Delta_M(g)\mu(E)$, so Folland's $\Delta(x^{-1})$ **is** Mathlib's `modularCharacterFun x`. Writing `modularCharacterFun x⁻¹` states the reciprocal identity, which is false in the non-unimodular case.
- `IsHaarMeasure` in Mathlib is the *left* Haar condition for a multiplicative group; the right Haar measure enters only as the pushforward of `lam` under inversion.
- Strong equivalence is strictly stronger than mutual absolute continuity: the density must be continuous and strictly positive, and it is tested against $C_c(G)$.
- The setwise identity ranges over sets of possibly infinite measure, so it must be stated in `ℝ≥0∞` with a lower integral; a Bochner integral would junk-default to `0` there.
- The modular function is `ℝ≥0`-valued and must be coerced (here into `ℝ≥0∞`); the coercion is where an inversion or reciprocal error hides.
