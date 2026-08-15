# Criteria: folland_2_51_invariant_measure_on_quotient

**Statement:** [folland_2_51_invariant_measure_on_quotient.md](folland_2_51_invariant_measure_on_quotient.md) · **Lean:** [folland_2_51_invariant_measure_on_quotient.lean](folland_2_51_invariant_measure_on_quotient.lean) · **Context:** [folland_2_51_invariant_measure_on_quotient.context.md](folland_2_51_invariant_measure_on_quotient.context.md)

## What the theorem says

Let $G$ be a locally compact group and $H$ a closed subgroup. The coset space $G/H$ carries a left
action of $G$, and one may ask for a nonzero measure on $G/H$ invariant under that action. The
theorem says such a measure exists exactly when the modular function of $G$, restricted to $H$,
agrees with the modular function of $H$ itself: $\Delta_G|_H = \Delta_H$. These are two different
functions on the same set $H$, computed in two different groups, and the condition is a real
restriction — for $G$ the $ax+b$ group and $H$ the $a$-axis it fails.

When the condition holds, the invariant measure is unique up to a positive constant, and with the
constant chosen correctly one has Weil's formula: for continuous compactly supported $f$ on $G$,

$$\int_G f\,d\lambda = \int_{G/H}\Big(\int_H f(x\xi)\,d\xi\Big)\,d\mu(xH).$$

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

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

## Notes on the ground truth

- ⚠️ Uniqueness of $\mu$ up to a positive constant is part of Folland's statement and is **not**
  formalized here. A candidate that adds it is closer to the printed theorem.
- The "suitably chosen constant factor" is absorbed into the existential over `ρ`: the statement
  asks for *some* nonzero invariant measure that makes (2.52) hold, which is the honest reading.
- ⚠️ The inner integral is written `∫ y : H, f (Quotient.out q * y) ∂ν`, using `Quotient.out` to
  pick a representative of the coset $q$. The value does not depend on the choice, because $\nu$ is
  left invariant on $H$, but `Quotient.out` is not a measurable section in general, so this is a
  place where a formulation built on Mathlib's quotient-measure machinery would be cleaner.
- ⚠️ "Radon" in Folland's statement means inner and outer regular. The Lean statement asks only for
  a nonzero invariant Borel measure satisfying (2.52); regularity is not imposed.
- ⚠️ The topology, measurable space and Borel structure on `G ⧸ H` are taken as instance arguments
  rather than being the quotient structures. A cleaner version would use Mathlib's quotient topology
  instance directly.
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
| A. Completeness | 50 | The requirement table above has 9 rows, so each row is worth 5.6 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 2 with $H$ not required closed: $G/H$ is then not Hausdorff and the statement is not Folland's.
- Requirement 5 with the invariant measure allowed to be zero, which makes existence trivial.
- Requirement 9 comparing $\Delta_G$ with $\Delta_G$, or $\Delta_H$ extended to $G$: the condition compares two genuinely different modular functions on $H$.

### Domain-specific pitfalls for this problem

- The coset space must carry the *quotient* topology. Introducing a topology on `G ⧸ H` as a free instance variable quantifies over arbitrary topologies and states something else.
- $\Delta_G|_H$ and $\Delta_H$ are different functions; the equality is convention-independent as long as one convention is used throughout.
- The zero measure is invariant, so nonvanishing has to be asserted.
- Weil's formula is stated for continuous compactly supported $f$, and its inner integral is over $H$ against a Haar measure on $H$; the choice of coset representative is immaterial but must be handled explicitly.
- "Unique up to a constant factor" is a further assertion of the theorem beyond existence.
