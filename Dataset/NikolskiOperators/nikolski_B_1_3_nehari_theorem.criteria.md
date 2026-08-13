# Criteria: nikolski_B_1_3_nehari_theorem

**Statement:** [nikolski_B_1_3_nehari_theorem.md](nikolski_B_1_3_nehari_theorem.md) · **Lean:** [nikolski_B_1_3_nehari_theorem.lean](nikolski_B_1_3_nehari_theorem.lean)

## What the theorem says

A Hankel operator is given by a matrix whose entry in position $(i,j)$ depends only on $i+j$.
Nehari's theorem says that if such an operator is bounded, then it has a symbol: an essentially
bounded function $\varphi$ on the unit circle whose Fourier coefficient at $-n-1$ is the $n$-th
entry of the matrix. Moreover the symbol can be chosen so that its essential supremum norm equals
the operator norm, and that number is also the distance in $L^\infty$ from $\varphi$ to the
bounded analytic functions.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The data is a sequence $a$, and the operator is the Hankel form $\sum_{i,j<N} x_i a_{i+j} y_j$. | ✅ `BoundedHankelForm a` and `hankelFormNorm a` both use `∑ i ∈ range N, ∑ j ∈ range N, x i * a (i + j) * y j`. |
| 2 | Boundedness means a single constant works for all finite sections and all coefficient vectors. | ✅ `∃ C : ℝ, 0 ≤ C ∧ ∀ N x y, …` in `BoundedHankelForm`. |
| 3 | The symbol lies in $L^\infty$: it is almost-everywhere measurable and its essential supremum is finite. | ✅ First two conjuncts of `HasBoundedHankelSymbol a φ`. |
| 4 | The symbol realizes the matrix with the correct index shift: $a_n = \hat\varphi(-n-1)$. | ✅ `∀ n : ℕ, circleFourierCoefficient φ (-((n : ℤ) + 1)) = a n`, with the $\tfrac{1}{2\pi}\int\varphi e^{-ikt}$ normalization built into `circleFourierCoefficient`. |
| 5 | The essential supremum norm of the symbol equals the operator norm. | ✅ `eLpNorm (fun t ↦ φ (unitCirclePoint t)) ∞ … = hankelFormNorm a`. |
| 6 | The distance from the symbol to the bounded analytic functions also equals the operator norm. | ✅ `symbolDistanceToHInfinity φ = hankelFormNorm a`. |
| 7 | All three claims are about one and the same $\varphi$. | ✅ A single `∃ φ` carrying all three conjuncts. |
| 8 | The two norms are infima taken in $[0,\infty]$, so an unbounded form gets the value $\infty$. | ✅ `hankelFormNorm` and `symbolDistanceToHInfinity` are both `sInf` over subsets of `ℝ≥0∞`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Splitting the two norm identities into separate existentials, so that a different symbol serves each. | The theorem's content is that one *extremal* symbol does both jobs. Separate existentials are much weaker: a symbol always exists with $\lVert H\rVert \le \lVert\varphi\rVert_\infty$. |
| 2 | Writing $\le$ instead of $=$ in either norm identity. | $\lVert H_\varphi\rVert \le \lVert\varphi\rVert_\infty$ is the trivial direction and holds for every symbol; the equality is Nehari's theorem. |
| 3 | Taking the infimum defining the operator norm over a set of real numbers. | Lean sets the infimum of the empty set of reals to $0$. An unbounded form would then be assigned norm $0$ and both equalities could be met for free. |
| 4 | Dropping the $-1$ and writing $a_n = \hat\varphi(-n)$ or $\hat\varphi(n)$. | That is a different matrix. The Hankel operator from $H^2$ to $H^2_-$ has entries $\hat\varphi(-i-j-1)$, and the statement becomes false with any other shift. |
| 5 | Omitting measurability of $\varphi$. | The Fourier coefficients are Bochner integrals, which Lean gives the value $0$ when the integrand is not integrable. A non-measurable $\varphi$ could then "realize" the matrix $a = 0$ regardless. |
| 6 | Dropping the `C < ∞` guard from the set defining the operator norm. | The definition converts `C` to a real number, and Lean sends $\infty$ to $0$ under that conversion. Without the guard, $\infty$ would satisfy an absurd bound and the infimum would be wrong. |
| 7 | Defining the distance to the bounded analytic functions as an infimum over a set that can be empty. | An empty infimum is the wrong degenerate value. It must be visible that $h = 0$ is always an admissible competitor. |

## Notes on the ground truth

- The printed theorem asserts one direction (bounded operator implies an extremal $L^\infty$ symbol
  exists). The ground truth states an `↔`. The converse is true and easy: the right-hand side gives
  `hankelFormNorm a = eLpNorm φ ∞ < ∞`, and an infimum in $[0,\infty]$ that is finite forces the
  defining set to be nonempty, hence the form is bounded. A candidate stating only the forward
  implication should not be penalized.
- The book speaks of a bounded operator $H : H^2 \to H^2_-$. The ground truth never builds an
  operator; it uses boundedness of the associated bilinear form on finite sections. That is
  equivalent, since the supremum over finite sections is the operator norm, but it is not the
  book's object. Mathlib supports the direct route — `ℓ²(ℕ, ℂ) →L[ℂ] ℓ²(ℕ, ℂ)` with `‖T‖`, as
  `RepresentsToeplitzOperator` does elsewhere in this book — and that would be closer and more
  reusable.
- `BoundedHankelForm` states its bound in squared form with `C ^ 2`, while `hankelFormNorm` states
  the unsquared bound with `C.toReal`. The two describe the same notion (square roots of
  nonnegative reals), but the duplication is a wart: `BoundedHankelForm a ↔ hankelFormNorm a < ∞`
  would be cleaner and would remove the risk of the two definitions drifting apart.
- The set defining `symbolDistanceToHInfinity` always contains $\infty$, and $h = 0$ contributes
  $\lVert\varphi\rVert_\infty$, so it is never empty.
- `HardyClass ⊤ h` does not itself assert that $h$ has radial boundary values, so
  `symbolDistanceToHInfinity` leans on Fatou's theorem implicitly. This is harmless: the junk value
  of `boundaryValue` lives on a null set, and an essential supremum ignores null sets.
