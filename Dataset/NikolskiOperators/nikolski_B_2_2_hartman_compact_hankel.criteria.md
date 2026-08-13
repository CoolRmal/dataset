# Criteria: nikolski_B_2_2_hartman_compact_hankel

**Statement:** [nikolski_B_2_2_hartman_compact_hankel.md](nikolski_B_2_2_hartman_compact_hankel.md) · **Lean:** [nikolski_B_2_2_hartman_compact_hankel.lean](nikolski_B_2_2_hartman_compact_hankel.lean)

## What the theorem says

Hartman's theorem describes which Hankel operators are compact. A Hankel operator is compact
exactly when it has a symbol lying in $H^\infty + C$: a function on the circle that is the sum of
the boundary values of a bounded analytic function and a continuous function. Since a Hankel
operator has many symbols, differing by bounded analytic functions, the right reading is that
*some* symbol lies in that class. The book adds the equivalent phrasing that the symbol may then
even be taken continuous.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

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
