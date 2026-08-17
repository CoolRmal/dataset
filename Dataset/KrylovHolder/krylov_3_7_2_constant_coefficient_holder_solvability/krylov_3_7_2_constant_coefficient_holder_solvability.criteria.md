# Criteria: krylov_3_7_2_constant_coefficient_holder_solvability

**Statement:** [krylov_3_7_2_constant_coefficient_holder_solvability.md](krylov_3_7_2_constant_coefficient_holder_solvability.md) · **Lean:** [krylov_3_7_2_constant_coefficient_holder_solvability.lean](krylov_3_7_2_constant_coefficient_holder_solvability.lean) · **Context:** [krylov_3_7_2_constant_coefficient_holder_solvability.context.md](krylov_3_7_2_constant_coefficient_holder_solvability.context.md)

## What the theorem says

Fix an operator $L = \sum_{\lvert\alpha\rvert \le m} a^\alpha D^\alpha$ of order $m \ge 2$ with
constant *complex* coefficients, elliptic in the sense of Krylov's Definition 1.1.1: the principal
part $\sum_{\lvert\alpha\rvert = m} a^\alpha \xi^\alpha$ does not vanish for $\xi \ne 0$, **and**
the characteristic polynomial $p(\xi) = \sum_{\lvert\alpha\rvert \le m} a^\alpha
i^{\lvert\alpha\rvert} \xi^\alpha$ does not vanish for any $\xi \in \mathbb{R}^d$. Attach to it the
$\lambda$-scaled family $L_\lambda = \sum_{\lvert\alpha\rvert \le m} a^\alpha
\lambda^{m-\lvert\alpha\rvert} D^\alpha$, so that $L_1 = L$. The theorem says that for every
nonzero real $\lambda$ — of either sign — the equation $L_\lambda u = f$ is uniquely solvable on
the whole of $\mathbb{R}^d$ in Hölder scale: for every datum $f$ in $C^{k+\delta}$ there is exactly
one $u$ in $C^{k+m+\delta}$ with $L_\lambda u = f$ everywhere. The gain is exactly $m$ derivatives,
and the solution is unique only within that regularity class.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The operator obeys the book's standing assumption $m \ge 2$, and $k \ge 0$ is an integer, $0 < \delta < 1$. | ✅ `hm : 2 ≤ m`, `k : ℕ` unconstrained, `hδ : 0 < δ ∧ δ < 1`. |
| 2 | $\lambda$ is an arbitrary nonzero real: both signs are admitted, with no positivity or threshold restriction. | ✅ `lam : ℝ` with `hlam : lam ≠ 0` and no other hypothesis on `lam` anywhere in the statement. |
| 3 | The coefficients are constant complex numbers indexed by multi-indices, and the data and solution are complex-valued functions on $\mathbb{R}^d$. | ✅ `a : (Fin d → ℕ) → ℂ` is a bare function of the multi-index — constancy is structural — and `f u : EuclideanSpace ℝ (Fin d) → ℂ`. |
| 4 | The operator applied is Krylov's $\lambda$-scaled family $L_\lambda = \sum_{\lvert\alpha\rvert \le m} a^\alpha \lambda^{m-\lvert\alpha\rvert} D^\alpha$, acting pointwise through the classical mixed partials, with the multi-indices really of order at most $m$. | ✅ `lambdaScaledOperator m (fun α _ ↦ a α) lam u x`, which unfolds to `∑ α ∈ multiIndicesLE d m, a α * (lam : ℂ) ^ (m - ∑ i, α i) * multiDerivative α u x`; `multiDerivative α` is the classical $D^\alpha$. |
| 5 | Ellipticity is Krylov's Definition 1.1.1, both halves: the principal part is nonzero for $\xi \ne 0$, **and** the characteristic polynomial $\sum_{\lvert\alpha\rvert \le m} a^\alpha i^{\lvert\alpha\rvert}\xi^\alpha$ is nonzero for **all** $\xi \in \mathbb{R}^d$, including $\xi = 0$. | ✅ `ha : IsElliptic m a`, whose conjuncts are `∀ ξ, ξ ≠ 0 → ∑ α ∈ multiIndicesLE d m with ∑ i, α i = m, a α * ∏ i, (ξ i : ℂ) ^ α i ≠ 0` and `∀ ξ, characteristicPolynomial m (fun α _ ↦ a α) 0 ξ ≠ 0`, the latter sum carrying the factor `Complex.I ^ (∑ i, α i)`. |
| 6 | "$f \in C^{k+\delta}$" is genuine membership: $k$ continuous derivatives *plus* a finite Hölder norm. | ✅ `MemHolderSpace k δ univ f`, which is `ContDiffOn ℝ k f univ ∧ krylovHolderNorm k δ univ f < ⊤`. |
| 7 | The norm is exactly Krylov's data: sup of $\lVert D^\alpha u\rVert$ for every order $j \le k$, together with the $\delta$-difference quotient of the derivatives of order exactly $k$, both over the whole set. | ✅ `krylovHolderNorm k δ Ω u = ∑ j ∈ Finset.range (k + 1), supSeminorm j Ω u + holderSeminorm k δ Ω u`, valued in `ℝ≥0∞`, the quotient guarded by `⨆ _ : x ≠ y`. |
| 8 | The conclusion asserts existence **and** uniqueness, with the solution required to lie in $C^{k+m+\delta}$ — a gain of exactly $m$ derivatives — and the same class re-imposed on any competitor. | ✅ `∃! u, MemHolderSpace (k + m) δ univ u ∧ ∀ x, lambdaScaledOperator m (fun α _ ↦ a α) lam u x = f x`; `∃!` re-imposes the full conjunction on competitors. |
| 9 | The equation is the classical pointwise one, everywhere on $\mathbb{R}^d$. | ✅ `∀ x, lambdaScaledOperator m (fun α _ ↦ a α) lam u x = f x`, with both memberships taken over `univ`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Reading $L_\lambda$ as the resolvent shift $Lu - \lambda u$ (or $Lu + \lambda u$). | That is not Krylov's operator: $L_\lambda$ multiplies the order-$\lvert\alpha\rvert$ coefficient by $\lambda^{m-\lvert\alpha\rvert}$, so $L_1 = L$ and the zeroth-order coefficient is $\lambda^m a^0$. Under the shift reading the statement is **false**, since $\lambda$ ranges over both signs: take $d = 1$, $m = 2$, $Lu = u''$, $\lambda = -1$ (resp. $+1$ for the $+$ form), $f = 0$; the equation becomes $u'' + u = 0$, and both $u \equiv 0$ and $u = \sin$ lie in $C^{k+2+\delta}$ — every derivative of $\sin$ is bounded and Lipschitz, so every seminorm is finite — killing uniqueness. |
| 2 | Restricting $\lambda$ to a sign or past a threshold ($0 < \lambda$, $\lambda_0 \le \lambda$, $\lambda_0 \le \lvert\lambda\rvert$) — typically to patch row 1. | Theorem 3.7.2 holds for *every* nonzero real $\lambda$, of either sign; that is exactly what the $\lambda$-scaling buys (the characteristic polynomial of $L_\lambda$ is $\lambda^m p(\xi/\lambda)$, nonvanishing whenever $p$ is). A half-line version is a strictly weaker theorem — the Chapter-4 shape, not this one. |
| 3 | Rendering ellipticity as positivity of a real principal symbol, $\sum_{\lvert\alpha\rvert = m} a^\alpha \xi^\alpha \ge \kappa\lVert\xi\rVert^m$ with $\kappa > 0$. | Definition 1.1.1 is a pair of *nonvanishing* conditions on *complex* coefficients, not a positivity. The positivity form silently forces real coefficients, excludes genuinely complex elliptic operators such as $\Delta + i$, and says nothing about the characteristic polynomial — without which the theorem fails (row 4). |
| 4 | Dropping the characteristic-polynomial half of ellipticity, or requiring it only for $\xi \ne 0$. | The condition is for **all** $\xi \in \mathbb{R}^d$; at $\xi = 0$ it says $a^0 \ne 0$. Either weakening admits $L = \Delta$, whose principal part $\lVert\xi\rVert^2$ is fine but whose characteristic polynomial $-\lvert\xi\rvert^2$ vanishes exactly at $0$. But $\Delta$ has no lower-order terms, so $L_\lambda = \Delta$ for *every* $\lambda$, and $\Delta u = 0$ has the two solutions $u \equiv 0$ and $u \equiv 1$ in $C^{k+2+\delta}$: uniqueness fails, so the statement is false. |
| 5 | Real coefficients, or real-valued data and solutions. | The book's Hölder spaces here consist of complex-valued functions and the coefficients are complex constants. A real rendering shrinks the operator class — $\Delta + i$ is elliptic in the sense of Definition 1.1.1 and has no real form — and weakens uniqueness to uniqueness among real solutions: a strictly weaker theorem. |
| 6 | Omitting the standing assumption $m \ge 2$ (allowing $m = 0$ or $m = 1$). | The order bound is part of the book's standing hypotheses for this chapter; dropping it asserts cases the text does not claim (at $m = 0$ the "theorem" degenerates to dividing by $a^0$). Half credit at most on requirement 1. |
| 7 | Asserting existence only. | The uniqueness half is half the theorem; it is exactly what the nonvanishing characteristic polynomial of every $L_\lambda$ pays for. |
| 8 | Stating uniqueness for any competing $v$ without re-imposing $v \in C^{k+m+\delta}$. | Uniqueness is false in a larger class; the regularity hypothesis has to appear on both the solution and the competitor. |
| 9 | Encoding "$u \in C^{k+m+\delta}$" as finiteness of the Hölder norm alone. | The norm's `multiDerivative` is built from `fderiv`, which is $0$ off the differentiability locus. A bounded nowhere-differentiable function then has a finite norm and would be admitted as a solution. The `ContDiffOn` clause is what rules that out. |
| 10 | Building the norm from a real-valued `sSup`. | A real supremum over an unbounded family returns $0$, so "finite norm" would be satisfied by every function. Landing in `ℝ≥0∞` makes `< ⊤` a real condition. |
| 11 | Writing the top-order difference quotient without excluding $x = y$. | Division by $\lVert x - y\rVert^\delta = 0$ at $x = y$; the guard `⨆ (_ : x ≠ y)` is required. |
| 12 | Working in `Fin d → ℝ` rather than `EuclideanSpace ℝ (Fin d)`. | `Fin d → ℝ` carries the sup norm, so the Hölder quotients refer to $\max_i\lvert x_i - y_i\rvert$ instead of the Euclidean distance. The class $C^{k+\delta}$ is unchanged as a set, but the seminorms are not the printed ones. |

## Notes on the ground truth

- The $\lambda$-scaling is the substance of the repair. An earlier version of the ground truth
  misread $L_\lambda$ as the shift $Lu - \lambda u$, restricted $\lambda > 0$, and used a
  parity-normalised real ellipticity; the book's actual conventions are the scaled family
  $\sum_{\lvert\alpha\rvert \le m} a^\alpha \lambda^{m-\lvert\alpha\rvert} D^\alpha$ with complex
  coefficients and nonzero $\lambda$ of either sign. The old shift-and-sign form is false under the
  book's hypotheses (mistake 1) and is now the primary trap, not the ground truth.
- Under Definition 1.1.1 the Laplacian itself is **not** elliptic — $p(\xi) = -\lvert\xi\rvert^2$
  vanishes at $0$ — while $\Delta - 1$ is. A candidate whose ellipticity admits $\Delta$ has the
  wrong definition (mistakes 3–4). With complex coefficients the odd orders are not vacuous either
  (for $d = 1$, $m = 3$: $a^{(3)} = i$, $a^0 = i$ gives $p(\xi) = \xi^3 + i \ne 0$), unlike under a
  real-symbol convention.
- `lambdaScaledOperator` is defined for variable coefficients `a : (Fin d → ℕ) →
  EuclideanSpace ℝ (Fin d) → ℂ`; the theorem instantiates it at `fun α _ ↦ a α`. Constancy is
  therefore structural rather than hypothesised; a candidate that quantifies over variable
  coefficients and adds a constancy side condition is equivalent.
- The exponent `m - ∑ i, α i` is `ℕ`-subtraction, but no truncation junk arises: the sum ranges
  over `multiIndicesLE d m`, which only contains multi-indices with $\sum_i \alpha_i \le m$.
- `IsElliptic` evaluates `characteristicPolynomial` at the base point `0`; for constant
  coefficients the base point is irrelevant.
- `krylovHolderNorm` is literally Krylov's $\lvert u\rvert_{k+\delta}$ (3.1.2): the sum over
  $j \le k$ of the sup-seminorms plus the top-order Hölder seminorm, in `ℝ≥0∞`. The seminorms take
  a supremum over the finitely many multi-indices of each order where the book writes a max —
  identical values.
- `MemHolderSpace` conjoins `ContDiffOn ℝ k` with norm-finiteness; the first conjunct is what
  blocks the junk value of `fderiv` (mistake 9).
- `hδ : 0 < δ ∧ δ < 1` is one conjunction; two separate hypotheses are equivalent.
- Because the domain is all of $\mathbb{R}^d$, plain `∃!` on global functions is the right notion
  of uniqueness here. In the domain problems of this book uniqueness must instead be stated as
  `Set.EqOn` on the closure.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[krylov_3_7_2_constant_coefficient_holder_solvability.md](krylov_3_7_2_constant_coefficient_holder_solvability.md) and the background in [krylov_3_7_2_constant_coefficient_holder_solvability.context.md](krylov_3_7_2_constant_coefficient_holder_solvability.context.md),
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

- Requirement 4 with the operator rendered as a zeroth-order shift $Lu - \lambda u$ or
  $Lu + \lambda u$: under the book's hypotheses ($\lambda \ne 0$ of either sign) that statement is
  false.
- Requirement 5 without the characteristic-polynomial condition, or with $\xi = 0$ exempted from
  it: the statement is then false ($L = \Delta$).
- Requirement 8 with existence only, or uniqueness only.
- Requirement 6 with membership replaced by finiteness of a norm, without asserting the
  derivatives exist.

### Domain-specific pitfalls for this problem

- $L_\lambda$ multiplies the order-$\lvert\alpha\rvert$ coefficient by
  $\lambda^{m-\lvert\alpha\rvert}$; it is not $Lu - \lambda u$. $L_1 = L$, and the zeroth-order
  coefficient of $L_\lambda$ is $\lambda^m a^0$.
- Ellipticity (Definition 1.1.1) has two halves; at $\xi = 0$ the characteristic-polynomial half
  forces $a^0 \ne 0$, and $\Delta$ is not elliptic in this sense.
- $\lambda$ is any nonzero real, of either sign — no positivity, no threshold.
- Coefficients and function spaces are complex.
- Hölder membership bundles the lower-order sup norms as well as the top seminorm.
- The regularity gain is exactly $m$: from $C^{k+\delta}$ data to $C^{k+m+\delta}$ solutions.
- Junk value — `deriv`/`fderiv`: a Hölder norm written with derivative operators is meaningless where the derivative does not exist, so differentiability must be asserted.
