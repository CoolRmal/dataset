# Criteria: folland_2_51_invariant_measure_on_quotient

**Statement:** [folland_2_51_invariant_measure_on_quotient.md](folland_2_51_invariant_measure_on_quotient.md) · **Lean:** [folland_2_51_invariant_measure_on_quotient.lean](folland_2_51_invariant_measure_on_quotient.lean) · **Context:** [folland_2_51_invariant_measure_on_quotient.context.md](folland_2_51_invariant_measure_on_quotient.context.md)

## What the theorem says

Let $G$ be a locally compact group and $H$ a closed subgroup. The coset space $G/H$ carries a left
action of $G$, and one may ask for a nonzero *Radon* measure on $G/H$ invariant under that action.
The theorem says such a measure exists exactly when the modular function of $G$, restricted to $H$,
agrees with the modular function of $H$ itself: $\Delta_G|_H = \Delta_H$. These are two different
functions on the same set $H$, computed in two different groups, and the condition is a real
restriction — for $G$ the $ax+b$ group and $H$ the $a$-axis it fails.

When the condition holds, the invariant Radon measure is unique up to a positive constant among
nonzero invariant Radon measures, and with the constant chosen correctly one has Weil's formula:
for continuous compactly supported $f$ on $G$,

$$\int_G f\,d\lambda = \int_{G/H}\Big(\int_H f(x\xi)\,d\xi\Big)\,d\mu(xH).$$

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $G$ is a locally compact topological group with its Borel structure, and $\mu$ is a left Haar measure on $G$. | ✅ `[IsTopologicalGroup G] [LocallyCompactSpace G] [BorelSpace G]`, `(μ : Measure G) [μ.IsHaarMeasure]`. |
| 2 | $H$ is a subgroup of $G$ and is **closed**. | ✅ `(H : Subgroup G)` with `hH : IsClosed (H : Set G)`. |
| 3 | $H$ carries its own left Haar measure, used in the inner integral of Weil's formula. | ✅ `(ν : Measure H) [ν.IsHaarMeasure]`. |
| 4 | The statement is an equivalence between "an invariant measure exists" and "the modular functions agree on $H$". | ✅ The whole conclusion is an `↔`. |
| 5 | The measure produced on the left side is nonzero. | ✅ `ρ ≠ 0`. |
| 6 | It is invariant under the natural left action of $G$ on the coset space. | ✅ `∀ g : G, ρ.map (fun q ↦ g • q) = ρ`. |
| 7 | Weil's formula (2.52) is part of the left side, not a separate afterthought. | ✅ `∫ x, f x ∂μ = ∫ q : G ⧸ H, (∫ y : H, f (Quotient.out q * y) ∂ν) ∂ρ`. |
| 8 | Weil's formula is asserted for $f$ continuous with compact support. | ✅ `∀ f : G → ℂ, Continuous f → HasCompactSupport f → …`. |
| 9 | The right side of the equivalence compares $\Delta_G$ evaluated at the image of $y$ in $G$ with $\Delta_H$ evaluated at $y$ in $H$ — two different groups. | ✅ `∀ y : H, ((Measure.modularCharacterFun (y : G) : ℝ≥0) : ℝ) = ((Measure.modularCharacterFun y : ℝ≥0) : ℝ)`. |
| 10 | The measure produced is a **Radon** measure. | ✅ `ρ.Regular` — Mathlib's `Measure.Regular` bundles finiteness on compact sets, outer regularity, and inner regularity on open sets, which is exactly Folland's Radon property. |
| 11 | Uniqueness up to a positive finite constant is asserted, quantified over nonzero invariant **Radon** measures only. | ✅ `∀ ρ' : Measure (G ⧸ H), ρ' ≠ 0 → ρ'.Regular → (∀ g : G, ρ'.map (fun q ↦ g • q) = ρ') → ∃ c : ℝ≥0∞, 0 < c ∧ c < ∞ ∧ ρ' = c • ρ`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Computing both modular functions in the same group, e.g. writing $\Delta_G(y) = \Delta_G(y)$ for $y \in H$. | That is a tautology, so the right side of the equivalence becomes vacuously true and the theorem degenerates into "an invariant measure always exists", which is false. This is the highest-value trap. |
| 2 | Stating only one direction, usually "if the modular functions agree then a measure exists". | The other direction — an invariant measure forces $\Delta_G\vert_H = \Delta_H$ — is half the theorem and is what makes the criterion a criterion. |
| 3 | Dropping Weil's formula and asserting only the existence of an invariant measure. | Folland's theorem pins down the measure by (2.52). Without it the forward direction produces an unusable object and the statement loses its computational content. |
| 4 | Omitting `ρ ≠ 0`. | The zero measure is invariant under every action. If Weil's formula were also dropped, the existence side would hold for every $G$ and $H$ and the equivalence would be false. |
| 5 | Assuming $H$ is normal so that $G/H$ can be treated as a quotient group. | Folland's $H$ is any closed subgroup, and $G/H$ is a homogeneous space. Assuming normality shrinks the theorem to a special case where the criterion is much easier. |
| 6 | Dropping the closedness of $H$. | If $H$ is not closed, $G/H$ is not Hausdorff, $H$ has no Haar measure of its own, and neither side of the equivalence makes sense. |
| 7 | Using right cosets $H\backslash G$ or the right action $q \mapsto q \cdot g$. | The invariance in the theorem is under left multiplication on left cosets; on a non-unimodular group the two sides are genuinely different. |
| 8 | Asserting Weil's formula for all $f \in L^1(G)$. | The printed formula is for $C_c(G)$. The $L^1$ version needs the a.e. existence of the inner integral, which is a further theorem. |
| 9 | Quantifying the uniqueness clause over **all** nonzero invariant measures, with no Radon restriction. | This makes the (condition → existence) direction of the iff provably false: already for $G = \mathbb{R}$ and $H$ trivial, counting measure on the quotient is a nonzero invariant measure that is no finite scalar multiple of Lebesgue measure, so no `ρ` can satisfy the clause. An earlier version of the ground truth had this defect; the current ground truth restricts the competitors to Radon measures. |
| 10 | Encoding "Radon" as inner regularity on all measurable sets plus outer regularity, or omitting finiteness on compacts. | Folland's Radon measure is outer regular, inner regular on *open* sets, and finite on *compact* sets. Inner regularity on all measurable sets is stronger than Radon, and dropping finiteness on compacts is weaker (it admits the invariant measure assigning $\infty$ to every nonempty set); either variant can flip the existence direction on non-$\sigma$-compact groups. An earlier version of the ground truth wrote `ρ.InnerRegular ∧ ρ.OuterRegular`; the current ground truth uses Mathlib's `Measure.Regular`, which matches Folland exactly. |

## Notes on the ground truth

- Uniqueness of $\mu$ up to a positive constant is part of the left-hand side: any other nonzero
  invariant **Radon** measure on the quotient is `c • ρ` for some `0 < c < ∞`. The restriction of
  the competitors to Radon measures is load-bearing: an unrestricted uniqueness clause is refutable
  (counting measure is invariant and nonzero) and would make the (condition → existence) direction
  of the iff provably false.
- The "suitably chosen constant factor" is absorbed into the existential over `ρ`: the statement
  asks for *some* nonzero invariant Radon measure that makes (2.52) hold, which is the honest
  reading.
- The inner integral uses `Quotient.out` to pick a coset representative. The value does not depend on
  the choice, since $\xi$ ranges over all of $H$ against a Haar measure on $H$, which is exactly why
  Weil's formula is well posed.
- "Radon" is rendered as Mathlib's `Measure.Regular` — finite on compact sets, outer regular, and
  inner regular on open sets — which is exactly Folland's definition of a Radon measure. It is
  asserted both of the measure produced and of the competitors in the uniqueness clause.
- The measurable space and Borel structure on `G ⧸ H` are instance arguments because Mathlib fixes no
  canonical measurable structure there; the topology is the quotient topology, taken from the
  canonical instance rather than as a free variable.
- $\Delta$ is `Measure.modularCharacterFun`, which is `ℝ≥0`-valued and takes no measure argument;
  both sides of the criterion are coerced to `ℝ` so they can be compared as printed.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[folland_2_51_invariant_measure_on_quotient.md](folland_2_51_invariant_measure_on_quotient.md) and the background in [folland_2_51_invariant_measure_on_quotient.context.md](folland_2_51_invariant_measure_on_quotient.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 11 rows, so each row is worth 4.5 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 2 with $H$ not required closed: $G/H$ is then not Hausdorff and the statement is not Folland's.
- Requirement 5 with the invariant measure allowed to be zero, which makes existence trivial.
- Requirement 9 comparing $\Delta_G$ with $\Delta_G$, or $\Delta_H$ extended to $G$: the condition compares two genuinely different modular functions on $H$.
- Requirement 11 with the uniqueness clause quantified over all nonzero invariant measures rather than invariant Radon measures: the (condition → existence) direction is then provably false.

### Domain-specific pitfalls for this problem

- The coset space must carry the *quotient* topology. Introducing a topology on `G ⧸ H` as a free instance variable quantifies over arbitrary topologies and states something else.
- $\Delta_G|_H$ and $\Delta_H$ are different functions; the equality is convention-independent as long as one convention is used throughout.
- The zero measure is invariant, so nonvanishing has to be asserted.
- Weil's formula is stated for continuous compactly supported $f$, and its inner integral is over $H$ against a Haar measure on $H$; the choice of coset representative is immaterial but must be handled explicitly.
- "Unique up to a constant factor" is a further assertion of the theorem beyond existence, and it
  ranges over nonzero invariant *Radon* measures only; unrestricted uniqueness is provably false.
- "Radon" is finite on compacts, outer regular, and inner regular on open sets — not inner
  regularity on all measurable sets, and not regularity without finiteness on compacts.
