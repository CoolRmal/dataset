# Criteria: conway_VII_7_1_riesz_compact_operator_spectrum

**Statement:** [conway_VII_7_1_riesz_compact_operator_spectrum.md](conway_VII_7_1_riesz_compact_operator_spectrum.md) · **Lean:** [conway_VII_7_1_riesz_compact_operator_spectrum.lean](conway_VII_7_1_riesz_compact_operator_spectrum.lean) · **Context:** [conway_VII_7_1_riesz_compact_operator_spectrum.context.md](conway_VII_7_1_riesz_compact_operator_spectrum.context.md)

## What the theorem says

Let $A$ be a compact operator on an infinite-dimensional complex Banach space. Its spectrum then has
one of exactly three shapes. Either it is just $\{0\}$; or it is $\{0\}$ together with finitely many
nonzero numbers $\lambda_1, \dots, \lambda_n$; or it is $\{0\}$ together with an infinite sequence
$\lambda_1, \lambda_2, \dots$ that tends to $0$. In the last two cases every $\lambda_k$ is a genuine
eigenvalue and its eigenspace $\ker(A - \lambda_k)$ is finite dimensional. In all three cases $0$
belongs to the spectrum.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The space is a complex Banach space and is infinite dimensional. | ✅ `[NormedAddCommGroup E] [NormedSpace ℂ E] [CompleteSpace E]` and `hE : ¬FiniteDimensional ℂ E`. |
| 2 | The operator is compact. | ✅ `hT : IsCompactOperator T`, Mathlib's version of $\mathcal{B}_0(\mathcal{X})$. |
| 3 | The spectrum meant is the Banach-algebra spectrum of $A$ as an element of $\mathcal{B}(\mathcal{X})$ — the set of $\lambda$ for which $A - \lambda$ fails to be invertible. | ✅ `spectrum ℂ T` for `T : E →L[ℂ] E`. |
| 4 | Case (a): the spectrum is exactly $\{0\}$. | ✅ `spectrum ℂ T = {0}`. |
| 5 | Case (b): the spectrum is $\{0\}$ together with finitely many distinct nonzero eigenvalues, and there is at least one of them. | ✅ `∃ n : ℕ, 0 < n ∧ ∃ eig : Fin n → ℂ, Function.Injective eig ∧ (∀ i, eig i ≠ 0) ∧ spectrum ℂ T = insert 0 (range eig) ∧ …`. The `0 < n` is what keeps case (b) from silently collapsing into case (a). |
| 6 | Case (c): the spectrum is $\{0\}$ together with an infinite sequence of distinct nonzero eigenvalues tending to $0$. | ✅ `∃ eig : ℕ → ℂ, Function.Injective eig ∧ (∀ n, eig n ≠ 0) ∧ spectrum ℂ T = insert 0 (range eig) ∧ Tendsto eig atTop (𝓝 0) ∧ …`. |
| 7 | $0$ is in the spectrum in every case. | ✅ Built into the shape of the answer: `{0}` in case (a), `insert 0 (range eig)` in cases (b) and (c). |
| 8 | Each listed $\lambda_k$ is an eigenvalue, witnessed by a **nonzero** vector. | ✅ `∃ x : E, x ≠ 0 ∧ T x = eig i • x`, in both (b) and (c). |
| 9 | Each eigenspace $\ker(A - \lambda_k)$ is finite dimensional, for **every** index. | ✅ `FiniteDimensional ℂ (LinearMap.ker (T - eig i • ContinuousLinearMap.id ℂ E).toLinearMap)`, attached to every `i` inside the same `∀`. |
| 10 | The three cases are offered as alternatives covering all possibilities. | ✅ A three-way `∨`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Dropping `¬FiniteDimensional ℂ E` as harmless. | Every case asserts $0 \in \sigma(A)$. On a finite-dimensional space a compact operator can be invertible, e.g. the identity on $\mathbb{C}^2$, so the statement becomes false. |
| 2 | Writing "each $\lambda_k$ is an eigenvalue" as `T x = eig i • x` without `x ≠ 0`. | The vector $x = 0$ satisfies that equation for every scalar, so the clause is true for free and cases (b) and (c) lose their content. This is the most likely slip here. |
| 3 | Stating only `spectrum ℂ T \ {0} = range eig` and never asserting $0 \in \sigma(A)$. | The theorem says the spectrum *is* $\{0, \lambda_1, \dots\}$. Membership of $0$ is part of the conclusion, and it is exactly what infinite-dimensionality buys. |
| 4 | Omitting `Function.Injective eig`. | The book lists *distinct* eigenvalues. Without injectivity a finite list could repeat one value, and case (b) would no longer describe the spectrum's size. |
| 5 | Omitting `0 < n` in case (b). | With $n = 0$ case (b) reduces to $\sigma(A) = \{0\}$, so the three cases stop being genuinely different alternatives. |
| 6 | Keeping the eigenvalue list but dropping the finite-dimensionality of the eigenspaces, or dropping $\lim \lambda_k = 0$. | Both are printed conclusions. Without $\lambda_k \to 0$ case (c) would allow spectra that no compact operator has. |
| 7 | Using `Module.End.HasEigenvalue` or `Module.End.spectrum` on the underlying linear map. | That is the set of eigenvalues, which in infinite dimensions is strictly smaller than the Banach-algebra spectrum $\sigma(A)$. The theorem is about the latter. |

## Notes on the ground truth

- Conway says "one and only one of the following possibilities occurs"; the Lean uses an inclusive
  `∨`. Exclusivity does follow from the shapes — case (b) has `0 < n` with an injective
  `eig : Fin n → ℂ`, case (c) an injective `eig : ℕ → ℂ`, so the three descriptions of the spectrum
  have different sizes — but it is never asserted. An "exactly one" formulation would match the
  text more closely.
- Kernels are taken as `LinearMap.ker (… ).toLinearMap`. Mathlib also offers
  `(T - eig i • ContinuousLinearMap.id ℂ E).ker` directly, which is marginally more idiomatic; the
  two name the same subspace.
- `IsCompactOperator` and `spectrum ℂ` are reused from Mathlib rather than hand-rolled.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[conway_VII_7_1_riesz_compact_operator_spectrum.md](conway_VII_7_1_riesz_compact_operator_spectrum.md) and the background in [conway_VII_7_1_riesz_compact_operator_spectrum.context.md](conway_VII_7_1_riesz_compact_operator_spectrum.context.md),
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

- Requirement 1 with the infinite-dimensionality hypothesis dropped: in finite dimensions $0$ need not be in the spectrum and the trichotomy is false.
- Requirement 8: listing spectral values without asserting they are eigenvalues witnessed by a nonzero vector.
- Requirement 6 with the convergence $\lambda_k \to 0$ omitted.

### Domain-specific pitfalls for this problem

- The spectrum is the Banach-algebra spectrum, not the eigenvalue set; that nonzero spectral values are eigenvalues is a conclusion.
- An eigenvalue needs a *nonzero* eigenvector; `T x = λ • x` alone is satisfied by `x = 0`.
- Distinctness of the listed $\lambda_k$ (injectivity of the enumeration) and their nonvanishing are what make the three cases exclusive.
- "Finite dimensional eigenspace" is about $\ker(A - \lambda_k)$ as a subspace of $\mathcal{X}$; it must be asserted for every index.
- The three cases must be offered as covering all possibilities, not as three separate theorems.
