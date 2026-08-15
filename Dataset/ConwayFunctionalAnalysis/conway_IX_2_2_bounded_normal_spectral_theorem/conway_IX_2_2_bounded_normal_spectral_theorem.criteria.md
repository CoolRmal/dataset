# Criteria: conway_IX_2_2_bounded_normal_spectral_theorem

**Statement:** [conway_IX_2_2_bounded_normal_spectral_theorem.md](conway_IX_2_2_bounded_normal_spectral_theorem.md) · **Lean:** [conway_IX_2_2_bounded_normal_spectral_theorem.lean](conway_IX_2_2_bounded_normal_spectral_theorem.lean) · **Context:** [conway_IX_2_2_bounded_normal_spectral_theorem.context.md](conway_IX_2_2_bounded_normal_spectral_theorem.context.md)

## What the theorem says

Let $N$ be a bounded normal operator on a complex Hilbert space. There is exactly one spectral
measure $E$ — an assignment of an orthogonal projection to each Borel subset of the spectrum
$\sigma(N)$, countably additive in the strong sense — with three properties. First, $N$ is recovered
by integrating the coordinate function against $E$: $N = \int z\,dE(z)$. Second, $E$ does not vanish
on any nonempty piece of $\sigma(N)$ that is open relative to $\sigma(N)$. Third, a bounded operator
$A$ commutes with $N$ and with $N^*$ exactly when it commutes with every projection $E(\Delta)$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The only hypothesis is that $N$ is a bounded normal operator on a complex Hilbert space — no separability, no self-adjointness, no compactness. | ✅ `hnormal : IsStarNormal T` over `[NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]`. |
| 2 | There is a projection-valued measure: each Borel set gets an orthogonal projection, the empty set gets $0$, disjoint sets get projections whose product is $0$, and countable disjoint unions add up in the strong topology. | ✅ The structure `ProjectionValuedMeasure H` from `Defs.lean` carries `empty`, `univ`, `projection`, `orthogonal` and `countablyAdditive`. |
| 3 | The measure is **unique**, not merely existent. | ✅ `∃! E : ProjectionValuedMeasure H, …`. |
| 4 | Uniqueness has to be made coherent: the value of $E$ on non-Borel sets must be pinned down, or two spectral measures could differ off the Borel sets and uniqueness would be false. | ✅ The `nonmeasurable : ∀ B, ¬MeasurableSet B → toFun B = 0` field of `ProjectionValuedMeasure`. |
| 5 | $E$ lives on $\sigma(N)$, i.e. the whole space is assigned to the spectrum. | ✅ `E.toFun (spectrum ℂ T) = ContinuousLinearMap.id ℂ H`. This is legitimate because $\sigma(N)$ is compact, hence Borel. Without it, uniqueness fails. |
| 6 | Property (a): $N = \int z\,dE(z)$, read weakly against the complex scalar measures $\langle E(\cdot)x, y\rangle$. | ✅ `∃ scalarMeasure : H → H → ComplexMeasure ℂ` with `scalarMeasure x y B = inner ℂ (E.toFun B x) y` and `inner ℂ (T x) y = ∫ᵛ z, star z ∂[…]`. |
| 7 | The scalar measures must be pinned on **every** measurable set, not just on a generating family. | ✅ `∀ x y : H, ∀ B : Set ℂ, MeasurableSet B → scalarMeasure x y B = …`. This is what keeps property (a) from being satisfiable by a badly behaved auxiliary measure (see Mistake 4). |
| 8 | Property (b): $E(G) \ne 0$ for every nonempty $G$ that is open *relative to* $\sigma(N)$. | ✅ `∀ G : Set ℂ, G.Nonempty → (∃ O : Set ℂ, IsOpen O ∧ G = O ∩ spectrum ℂ T) → E.toFun G ≠ 0`. |
| 9 | Property (c): the full two-way equivalence, with **both** commutation identities $AN = NA$ and $AN^* = N^*A$ on the left, quantified over all bounded $A$. | ✅ `∀ A : H →L[ℂ] H, (A.comp T = T.comp A ∧ A.comp T.adjoint = T.adjoint.comp A) ↔ ∀ Δ : Set ℂ, MeasurableSet Δ → A.comp (E.toFun Δ) = (E.toFun Δ).comp A`. |
| 10 | The three properties plus the support condition sit inside a single `∃!`, so the unique $E$ is the one satisfying all of them at once. | ✅ One `∃!` with a four-fold conjunction. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Writing the integral as `inner ℂ (T x) y = ∫ᵛ z, z ∂[…]` with `scalarMeasure x y B = inner ℂ (E.toFun B x) y`. | Mathlib's inner product is conjugate-linear in its **first** argument, so approximating $N$ by $\sum_k z_k E(B_k)$ gives $\langle Nx,y\rangle = \int \bar z\,dE_{x,y}$. The un-conjugated version therefore says $N = \int \bar z\,dE$, i.e. that $E$ is the spectral measure of $N^*$, supported on $\overline{\sigma(N)}$. Combined with the support condition it becomes unsatisfiable whenever $\sigma(N)$ is not closed under conjugation. Concretely, take $H = \mathbb{C}$ and $N = i\cdot\mathrm{id}$: the axioms force $E = \delta_{\{i\}}$ and the identity reduces to $-i\,\bar x y = i\,\bar x y$. |
| 2 | Defining a spectral measure as an arbitrary function `Set ℂ → H →L[ℂ] H` with conditions imposed only on measurable sets, and then claiming `∃!`. | Two such functions can differ on a non-Borel set while satisfying every condition, so the uniqueness claim is false as stated. |
| 3 | Dropping the support condition `E (σ(N)) = id` and keeping only `E univ = id`. | Uniqueness is lost: the measure could put mass outside the spectrum and still satisfy the rest. |
| 4 | Constraining `scalarMeasure` only on a convenient subfamily of sets. | Mathlib's vector-measure integral `∫ᵛ` returns $0$ when the integrand is not integrable. With `scalarMeasure` left free elsewhere, a candidate could pick a measure making $z$ non-integrable and satisfy property (a) for free. |
| 5 | Requiring `IsOpen G` in $\mathbb{C}$ in property (b). | Relatively open means open in $\sigma(N)$. A genuinely open subset of $\mathbb{C}$ meeting $\sigma(N)$ in a nonempty set is a different family, and the item as rewritten no longer says that the support of $E$ is all of $\sigma(N)$. |
| 6 | Writing property (c) with only $AN = NA$ on the left. | That version asserts Fuglede's theorem by accident: it would say that commuting with $N$ alone already forces commuting with $N^*$. That is true but is a separate, harder result and not what IX.2.2 states. |
| 7 | Keeping only one direction of the `↔` in property (c). | Half the item is lost; both implications are asserted in the text. |
| 8 | Splitting the theorem into three separate existence claims, one per property. | The text asserts a single $E$ satisfying (a), (b) and (c) simultaneously. |

## Notes on the ground truth

- Mathlib has no projection-valued-measure API, so `ProjectionValuedMeasure` is hand-rolled in
  `Defs.lean`. Its `nonmeasurable` field is not decoration — it is what makes the `∃!` defensible.
- "On the Borel subsets of $\sigma(N)$" is rendered as a measure on all of $\mathbb{C}$ plus the
  support condition of row 5. Indexing by `Set (spectrum ℂ T)` instead would be equally acceptable,
  with the `univ` field then playing the role of the support condition.
- The integrand `star z` in property (a) is deliberate and repairs an earlier version of this file
  that wrote `z`. See Mistake 1 for why the un-conjugated form is a false statement. An equally
  faithful alternative is to keep the integrand `z` and define
  `scalarMeasure x y B = inner ℂ x (E.toFun B y)` instead.
- Because the scalar measures are concentrated on the compact set $\sigma(N)$ and have finite
  variation, $z \mapsto z$ really is integrable here, so the junk value $0$ of `∫ᵛ` cannot be
  exploited.
- The same missing-conjugation pattern appears harmlessly in `conway_XI_2_3` item (g) and in
  `conway_X_5_6`, because there the spectral measure sits on the reals where $\bar z = z$. It is
  only fatal when the spectrum is genuinely complex, as here.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[conway_IX_2_2_bounded_normal_spectral_theorem.md](conway_IX_2_2_bounded_normal_spectral_theorem.md) and the background in [conway_IX_2_2_bounded_normal_spectral_theorem.context.md](conway_IX_2_2_bounded_normal_spectral_theorem.context.md),
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

- Requirement 3: existence only, without uniqueness.
- Requirement 8 with "open in $\mathbb{C}$" instead of "relatively open in $\sigma(N)$": a strictly weaker support condition.
- Requirement 9 with only one of the two commutation identities, or with the equivalence turned into a single implication.

### Domain-specific pitfalls for this problem

- Countable additivity of a projection-valued measure is in the *strong* topology (pointwise on vectors), not in operator norm.
- The projections must be orthogonal (self-adjoint idempotents), not merely idempotent.
- $\int z \, dE(z)$ is a weak integral against the complex measures $\langle E(\cdot)x,y\rangle$; those measures must be pinned on *every* measurable set, not merely on a generating family.
- Mathlib's inner product is conjugate-linear in the **first** argument, so transcribing $\langle E(\Delta)x,y\rangle$ or the integrand without accounting for the conjugation silently states the adjoint identity.
- Uniqueness requires the behaviour on non-Borel sets to be fixed; otherwise the `∃!` is comparing objects that are not determined by the stated conditions.
