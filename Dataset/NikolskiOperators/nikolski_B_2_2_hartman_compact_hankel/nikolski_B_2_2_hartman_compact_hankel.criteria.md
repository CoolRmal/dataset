# Criteria: nikolski_B_2_2_hartman_compact_hankel

**Statement:** [nikolski_B_2_2_hartman_compact_hankel.md](nikolski_B_2_2_hartman_compact_hankel.md) · **Lean:** [nikolski_B_2_2_hartman_compact_hankel.lean](nikolski_B_2_2_hartman_compact_hankel.lean) · **Context:** [nikolski_B_2_2_hartman_compact_hankel.context.md](nikolski_B_2_2_hartman_compact_hankel.context.md)

## What the theorem says

Hartman's theorem describes which Hankel operators are compact. A Hankel operator is compact
exactly when it has a symbol lying in $H^\infty + C$: a function on the circle that is the sum of
the boundary values of a bounded analytic function and a continuous function. Since a Hankel
operator has many symbols, differing by bounded analytic functions, the right reading is that
*some* symbol lies in that class. The book adds the equivalent phrasing that the symbol may then
even be taken continuous.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The operator side is a statement about the matrix data $a$ alone, with no symbol assumed. | ✅ The left-hand side of the `↔` is `CompactHankel a`, which mentions only `a`. |
| 2 | Compactness is encoded by the tail blocks having small norm: for every $\varepsilon > 0$ there is an index $N$ beyond which the whole corner has norm at most $\varepsilon$. | ✅ `CompactHankel a` contains `∀ ε > 0, ∃ N, ∀ M x y, ‖∑ i ∈ Icc N M, ∑ j ∈ Icc N M, x i * a (i + j) * y j‖ ≤ ε * (∑ ‖x i‖²)^{1/2} * (∑ ‖y j‖²)^{1/2}`. |
| 3 | The tail bound holds for every window `Icc N M` and every pair of coefficient vectors, so it really is a supremum over the tail. | ✅ `∀ M : ℕ, ∀ x y : ℕ → ℂ`. |
| 4 | The symbol is existentially quantified on the other side of the equivalence. | ✅ `∃ φ, HasBoundedHankelSymbol a φ ∧ InHInfinityPlusContinuous φ`. |
| 5 | That $\varphi$ is a genuine symbol for $a$: essentially bounded, measurable, with $\hat\varphi(-n-1) = a_n$. | ✅ `HasBoundedHankelSymbol a φ`. |
| 6 | $H^\infty + C$ is an algebraic sum: $\varphi = $ boundary values of some bounded analytic $h$, plus a continuous $c$. | ✅ `InHInfinityPlusContinuous φ` = `∃ h c, HardyClass ⊤ h ∧ Continuous c ∧ ∀ ζ, φ ζ = boundaryValue h ζ + c ζ`. |
| 7 | The continuous summand is continuous on the circle. | ✅ `c : {z : ℂ // ‖z‖ = 1} → ℂ` with `Continuous c`, i.e. continuity in the subspace topology of the circle. |
| 8 | Both directions are asserted. | ✅ A single `↔`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Replacing compactness by "the matrix entries tend to $0$". | Far weaker. The Hilbert matrix $a_n = 1/(n+1)$ has entries tending to $0$ and is bounded, but the corresponding Hankel operator is not compact. |
| 2 | Replacing compactness by boundedness of the form. | Then the equivalence would say that every bounded Hankel operator has a symbol in $H^\infty + C$, which is false — Nehari gives an $L^\infty$ symbol, not one in $H^\infty + C$. |
| 3 | Requiring only that `fun t : ℝ ↦ c (unitCirclePoint t)` is continuous. | That permits a jump between $t = 0$ and $t = 2\pi$, so the class of admissible $c$ is strictly larger than $C(\mathbb{T})$ and the equivalence fails. |
| 4 | Assuming an $L^\infty$ symbol as a hypothesis of the whole theorem. | The existence of a bounded symbol for a bounded Hankel operator is itself Nehari's theorem, so assuming it gives away half the content. |
| 5 | Fixing $\varphi$ outside the equivalence and writing "compact $\leftrightarrow$ $\varphi \in H^\infty + C$" without saying $\varphi$ is a symbol of $a$. | The two sides would then be about unrelated objects and the statement would be false. |
| 6 | Stating only one direction. | Both directions carry content: compactness produces a symbol in the class, and a symbol in the class forces compactness. |

## Notes on the ground truth

- Compactness is encoded by the tail-block criterion instead of building an operator. This is
  equivalent for a bounded form: if $P_N$ is the projection onto the first $N$ coordinates and
  $Q_N$ the complementary one, then $\Gamma - Q_N\Gamma Q_N = P_N\Gamma + Q_N\Gamma P_N$ has rank
  at most $2N$, and conversely $\lVert \Gamma Q_N\rVert \to 0$ for a compact $\Gamma$. Mathlib does
  have `IsCompactOperator` and `ℓ²(ℕ, ℂ) →L[ℂ] ℓ²(ℕ, ℂ)` — the sibling Devinatz–Widom file builds a
  Toeplitz operator that way — so a candidate that constructs the operator and asserts compactness
  literally should be scored at least as highly.
- The `BoundedHankelForm a` conjunct inside `CompactHankel` is redundant: the $\varepsilon$-tail
  clause together with the finite corner already gives boundedness. It is harmless, arguably
  clarifying, but a reader may mistake it for extra content.
- `Finset.Icc N M` is empty when $M < N$, so the `∀ M` quantifier genuinely sweeps the tail.
- `InHInfinityPlusContinuous φ` demands the identity $\varphi(\zeta) = \mathrm{bv}\,h(\zeta) +
  c(\zeta)$ at *every* $\zeta$, and `boundaryValue` returns an arbitrary value on the null set
  where the radial limit fails. This is harmless in this position only because $\varphi$ is
  existentially quantified and all its other constraints are almost-everywhere or integral notions,
  so $\varphi$ can be taken to be that sum literally. An almost-everywhere version would be the
  correct general form, and would matter if $\varphi$ were universally quantified.
- The book's second phrasing — a Hankel operator is compact if and only if it equals $H_g$ for some
  continuous $g$ — is not stated. It is an "in other words" (adding a bounded analytic part does
  not change the Hankel operator), so the omission is minor, but a formalization carrying both
  clauses is strictly better.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[nikolski_B_2_2_hartman_compact_hankel.md](nikolski_B_2_2_hartman_compact_hankel.md) and the background in [nikolski_B_2_2_hartman_compact_hankel.context.md](nikolski_B_2_2_hartman_compact_hankel.context.md),
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

- Requirement 6 with $H^\infty + C$ read as an intersection, or with the continuous summand dropped.
- Requirement 8 with only one direction.
- Requirement 5 with the symbol not tied to the matrix data by the correct Fourier-coefficient relation.

### Domain-specific pitfalls for this problem

- $H^\infty + C$ is an algebraic sum of two spaces of functions on the circle.
- The continuous summand is continuous on $\mathbb{T}$, a compact space, so it is automatically bounded.
- Compactness of a Hankel operator is symbol-independent modulo $H^\infty$, which is why the "continuous symbol" reformulation is equivalent.
- The index conventions relating symbol and matrix must match those of Nehari's theorem.
