# Criteria: kallenberg_3_4_disintegration

**Statement:** [kallenberg_3_4_disintegration.md](kallenberg_3_4_disintegration.md) · **Lean:** [kallenberg_3_4_disintegration.lean](kallenberg_3_4_disintegration.lean) · **Context:** [kallenberg_3_4_disintegration.context.md](kallenberg_3_4_disintegration.context.md)

## What the theorem says

Let $\rho$ be a $\sigma$-finite measure on a product $S \times T$, where $T$ is a standard Borel
space. The theorem says $\rho$ can be split as $\rho = \nu \otimes \mu$: a measure $\nu$ on $S$ that
has the same null sets as the first marginal of $\rho$, together with a kernel $\mu$ assigning a
measure on $T$ to each point of $S$. The kernel is unique up to rescaling by a density on $S$. Its
fibres $\mu_s$ can be chosen to have finite total mass exactly when the first marginal of $\rho$ is
itself $\sigma$-finite, and in that case one can take $\nu$ to be the first marginal itself and every
$\mu_s$ to be a probability measure.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $\rho$ is $\sigma$-finite on $S \times T$; the standard Borel assumption is on the second factor only, and $S$ carries nothing but a measurable structure. | ✅ `[SigmaFinite ρ]`, `[MeasurableSpace T] [StandardBorelSpace T]`, `[MeasurableSpace S]` alone. |
| 2 | Part (i): there exist a $\sigma$-finite $\nu$ on $S$ and a kernel $\kappa$ with $\nu \otimes \kappa = \rho$. | ✅ First conjunct, `∃ (ν : Measure S) (κ : Kernel S T), SigmaFinite ν ∧ … ∧ ν ⊗ₘ κ = ρ`. |
| 3 | $\nu$ must have the same null sets as the first marginal — absolute continuity in both directions, not equality. | ✅ `ν ≪ ρ.fst ∧ ρ.fst ≪ ν`, present in every conjunct that mentions a supporting measure. |
| 4 | The kernel is $\sigma$-finite in Kallenberg's sense: there is one measurable $f > 0$ on $S \times T$ whose fibre integrals against $\kappa_s$ are all finite. | ✅ `IsSigmaFiniteKernel κ`, i.e. `∃ f : S × T → ℝ≥0∞, Measurable f ∧ (∀ s t, 0 < f (s, t)) ∧ ∀ s, ∫⁻ t, f (s, t) ∂κ s < ∞`. |
| 5 | The kernel is also s-finite, i.e. a countable sum of finite kernels. This must be stated wherever the product $\nu \otimes \kappa$ appears. | ✅ `IsSFiniteKernel κ` in the existence clause, on both kernels in the uniqueness clause, in the boundedness equivalence, and implied by `IsMarkovKernel` in part (iii). |
| 6 | Part (ii), uniqueness: any two disintegrations of $\rho$ differ by a density on $S$ — $\nu' = c\,\nu$ and $\kappa_s = c(s)\,\kappa'_s$ for $\nu$-almost every $s$. | ✅ `∃ c : S → ℝ≥0∞, Measurable c ∧ (∀ᵐ s ∂ν, 0 < c s ∧ c s < ∞) ∧ ν' = ν.withDensity c ∧ ∀ᵐ s ∂ν, κ s = c s • κ' s`, under hypotheses that both pairs disintegrate $\rho$. |
| 7 | Part (ii), boundedness: *some* disintegration has almost-everywhere finite fibres if and only if the first marginal of $\rho$ is $\sigma$-finite. | ✅ `(∃ ν κ, … ∧ IsAEBoundedKernel ν κ) ↔ SigmaFinite ρ.fst`, where `IsAEBoundedKernel ν κ` is `∀ᵐ s ∂ν, κ s univ < ∞`. |
| 8 | Part (iii): when the first marginal is $\sigma$-finite, one may take $\nu$ to be that marginal and every fibre to be a probability measure. | ✅ `SigmaFinite ρ.fst → ∃ κ : Kernel S T, IsMarkovKernel κ ∧ ρ.fst ⊗ₘ κ = ρ`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Omitting `IsSFiniteKernel κ` next to the identity `ν ⊗ₘ κ = ρ`. | Mathlib *defines* the composition-product to be the zero measure when the kernel is not s-finite. So `ν ⊗ₘ κ = ρ` could be satisfied by a wild kernel whenever $\rho = 0$, and in general the equation stops meaning "$\rho$ factors". |
| 2 | Writing `ν = ρ.fst` in part (i). | The whole point of part (i) is that a supporting measure exists even when the first marginal is not $\sigma$-finite. Forcing equality makes the claim false in exactly those cases. Equality is legitimate only in part (iii). |
| 3 | Keeping only one direction of absolute continuity. | "$\nu \sim \rho(\cdot \times T)$" is an equivalence of measures; one direction alone permits, for instance, $\nu = 0$. |
| 4 | Using Mathlib's `IsSFiniteKernel` as the translation of Kallenberg's "$\sigma$-finite kernel". | Those are different notions: Mathlib's `IsSFiniteKernel` is Kallenberg's *s-finite*. Dropping the custom `IsSigmaFiniteKernel` weakens part (i) to a claim about a kernel with no fibrewise finiteness control. |
| 5 | Stating part (ii)'s boundedness clause with a universal quantifier, `∀ ν κ, (disintegration) → IsAEBoundedKernel ν κ`. | False: part (ii) itself allows rescaling by any almost-everywhere positive density, and rescaling destroys finiteness of the fibres. Only *some* disintegration is bounded. |
| 6 | Formalizing part (i) alone. | Mathlib's disintegration API makes this the tempting minimal reading, but the theorem has four assertions and the other three carry most of the content. |
| 7 | Using `IsFiniteKernel` rather than `IsMarkovKernel` in part (iii), or reintroducing a free $\nu$ there. | Part (iii) asserts the fibres are *probability* measures and that the supporting measure is the first marginal itself; both weakenings lose that. |
| 8 | Adding `[StandardBorelSpace S]`, or a Polish assumption on $S \times T$. | The theorem holds for an arbitrary measurable $S$; adding structure narrows its scope for no reason. |

## Notes on the ground truth

- Kallenberg's "$T$ is Borel" means standard Borel, which is what `[StandardBorelSpace T]` says.
- The fibre integrals in `IsSigmaFiniteKernel` are lower Lebesgue integrals `∫⁻` valued in
  `ℝ≥0∞`, so no integrability side condition is needed and no default value can arise.
- The uniqueness clause concludes `∀ᵐ s ∂ν, 0 < c s ∧ c s < ∞` as well as the density identity, so
  the two disintegrations are genuinely proportional rather than related by a density that may
  vanish or blow up.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[kallenberg_3_4_disintegration.md](kallenberg_3_4_disintegration.md) and the background in [kallenberg_3_4_disintegration.context.md](kallenberg_3_4_disintegration.context.md),
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

- Requirement 3 with one-sided absolute continuity instead of equivalence of $\nu$ with the first marginal.
- Requirement 4 with $\sigma$-finiteness of the kernel read as a per-$s$ exhaustion rather than Kallenberg's single global witness $f>0$.
- Requirement 6 with uniqueness stated as literal equality rather than equality up to a density.

### Domain-specific pitfalls for this problem

- "Finite", "s-finite" and "$\sigma$-finite" are three different conditions on a kernel, and the theorem uses all three in different places.
- The standard Borel hypothesis is on the *second* factor $T$; imposing it on $S$ narrows the theorem.
- Part (ii)'s boundedness clause is an "iff", tying a.e.-finite fibres to $\sigma$-finiteness of the first marginal.
- Part (iii) is a separate assertion: when the marginal is $\sigma$-finite one may take the kernel to be a *probability* kernel.
- $\nu \otimes \mu$ is the composition-product of a measure with a kernel, not a product measure.
