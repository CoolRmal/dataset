# Criteria: krylov_4_5_1_variable_coefficient_global_solvability

**Statement:** [krylov_4_5_1_variable_coefficient_global_solvability.md](krylov_4_5_1_variable_coefficient_global_solvability.md) · **Lean:** [krylov_4_5_1_variable_coefficient_global_solvability.lean](krylov_4_5_1_variable_coefficient_global_solvability.lean) · **Context:** [krylov_4_5_1_variable_coefficient_global_solvability.context.md](krylov_4_5_1_variable_coefficient_global_solvability.context.md)

## What the theorem says

Let $L = \sum_{|\alpha| \le m} a^\alpha(x) D^\alpha$ be uniformly elliptic of order $m \ge 2$ on
$\mathbb{R}^d$, with complex coefficients lying in $C^{k+\delta}(\mathbb{R}^d)$ and satisfying
$|a^\alpha|_\delta \le K$. Chapter 4 attaches to $L$ the scaled family
$L_\lambda = \sum_{|\alpha| \le m} a^\alpha(x)\,\lambda^{m-|\alpha|} D^\alpha$, so that $L_1 = L$.
Theorem 4.1.2 furnishes constants $\lambda_0, N_0$ — depending only on $\kappa, m, \delta, d, K$ —
through its a priori estimate; Theorem 4.5.1 says that for that $\lambda_0$, every real $\lambda$
with $|\lambda| \ge \lambda_0$ (either sign), and every $f \in C^{k+\delta}$, the equation
$L_\lambda u = f$ has exactly one solution $u \in C^{k+m+\delta}$. The threshold is a fixed
number, chosen once and for all before $\lambda$ and before the datum.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The standing assumptions: $m \ge 2$, $k \ge 0$ an integer, $0 < \delta < 1$. | ✅ `hm : 2 ≤ m`, `k : ℕ` unconstrained, `hδ : 0 < δ ∧ δ < 1`. |
| 2 | The coefficients are complex functions $a^\alpha$ indexed by multi-indices, and the operator family is the scaled $L_\lambda u(x) = \sum_{\lvert\alpha\rvert \le m} a^\alpha(x)\,\lambda^{m-\lvert\alpha\rvert} D^\alpha u(x)$, applied pointwise, with $L_1 = L$. | ✅ `a : (Fin d → ℕ) → EuclideanSpace ℝ (Fin d) → ℂ`; `lambdaScaledOperator m a lam u x` is `∑ α ∈ multiIndicesLE d m, a α x * (lam : ℂ) ^ (m - ∑ i, α i) * multiDerivative α u x`. |
| 3 | Uniform ellipticity in the Chapter-4 sense: $\big\lvert\sum_{\lvert\alpha\rvert \le m} a^\alpha(x)\, i^{\lvert\alpha\rvert}\xi^\alpha\big\rvert \ge \kappa(1+\lvert\xi\rvert^m)$ for all $x, \xi \in \mathbb{R}^d$, with a single $\kappa > 0$. | ✅ `ha : UniformlyElliptic m κ a`, i.e. `0 < κ ∧ ∀ x ξ, κ * (1 + ‖ξ‖ ^ m) ≤ ‖characteristicPolynomial m a x ξ‖`, the polynomial carrying the factor `Complex.I ^ (∑ i, α i)`. |
| 4 | The named coefficient bound $\lvert a^\alpha\rvert_\delta \le K$ for all $\alpha$ — the $K$ through which Theorem 4.1.2's constants depend on the coefficients. | ✅ `haK : ∀ α, krylovHolderNorm 0 δ univ (a α) ≤ ENNReal.ofReal K`. |
| 5 | Coefficient regularity $a^\alpha \in C^{k+\delta}(\mathbb{R}^d)$ for every $\alpha$. | ✅ `hareg : ∀ α, MemHolderSpace k δ univ (a α)`. |
| 6 | $\lambda_0$ (with its companion $N_0$) is produced by the theorem, not supplied to it, and is fixed before $\lambda$ and before $f$; $\lambda_0 \ge 0$. | ✅ `∃ lam₀ N₀ : ℝ, 0 ≤ lam₀ ∧ 0 < N₀ ∧ … ∧ ∀ lam …, ∀ f, …`. |
| 7 | $\lambda_0$ is pinned as the constant of Theorem 4.1.2: together with $N_0$ it satisfies the a priori estimate $[u]_{m+\delta} + \lvert\lambda\rvert^{m+\delta}\lvert u\rvert_0 \le N_0([L_\lambda u]_\delta + \lvert\lambda\rvert^\delta \lvert L_\lambda u\rvert_0)$ for every $u \in C^{m+\delta}(\mathbb{R}^d)$ and every real $\lvert\lambda\rvert \ge \lambda_0$. | ✅ the first conjunct: `∀ lam : ℝ, lam₀ ≤ \|lam\| → ∀ u, MemHolderSpace m δ univ u → holderSeminorm m δ univ u + ENNReal.ofReal \|lam\| ^ ((m : ℝ) + δ) * supSeminorm 0 univ u ≤ ENNReal.ofReal N₀ * (holderSeminorm 0 δ univ (lambdaScaledOperator m a lam u) + ENNReal.ofReal \|lam\| ^ δ * supSeminorm 0 univ (lambdaScaledOperator m a lam u))`. |
| 8 | Solvability is claimed for **all** real $\lambda$ with $\lvert\lambda\rvert \ge \lambda_0$ — both signs. | ✅ `∀ lam : ℝ, lam₀ ≤ \|lam\| → …` in the solvability conjunct. |
| 9 | "$f \in C^{k+\delta}$" and "$u \in C^{k+m+\delta}$" are genuine membership: continuous derivatives plus a finite Krylov norm. | ✅ `MemHolderSpace k δ univ f` and `MemHolderSpace (k + m) δ univ u`, where `MemHolderSpace k δ Ω u` is `ContDiffOn ℝ k u Ω ∧ krylovHolderNorm k δ Ω u < ⊤`. |
| 10 | The conclusion asserts existence **and** uniqueness, with uniqueness relative to the same class $C^{k+m+\delta}$. | ✅ `∃! u, MemHolderSpace (k + m) δ univ u ∧ ∀ x, lambdaScaledOperator m a lam u x = f x`. |
| 11 | The equation is the classical pointwise one on all of $\mathbb{R}^d$: $L_\lambda u(x) = f(x)$ for every $x$. | ✅ `∀ x, lambdaScaledOperator m a lam u x = f x`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Writing `∀ f, ∃ lam₀, …`. | A threshold chosen after the datum is useless: the theorem says one threshold works for all data at once. |
| 2 | Taking $\lambda_0$ as an input of the theorem. | Then the claim would include arbitrarily small thresholds, in particular $\lambda$ near $0$, where the equation is not uniquely solvable (see mistake 6). |
| 3 | Producing a bare `∃ lam₀` with nothing pinning it to Theorem 4.1.2. | The text does not say "some threshold exists": it names the $\lambda_0$ of Theorem 4.1.2, determined together with $N_0$ by the a priori estimate and depending only on $\kappa, m, \delta, d, K$ — in particular not on $k$. An unpinned existential is a strictly weaker claim. |
| 4 | Writing the equation as a shift, $Lu - \lambda u = f$ or $Lu + \lambda u = f$, instead of the scaled family $L_\lambda = \sum a^\alpha \lambda^{m-\lvert\alpha\rvert} D^\alpha$. | Under a shift the two-sided claim is false. Take $d = 1$, $m = 2$, $Lu = u'' - u$ (uniformly elliptic, $\kappa = 1$), $f = 0$: for $Lu - \lambda u$ with $\lambda = -(\lambda_0 + 2)$, both $u \equiv 0$ and $u(x) = \sin(\sqrt{\lambda_0+1}\,x)$ lie in $C^{k+2+\delta}$ and solve the equation; the mirrored example with $\lambda = \lambda_0 + 2$ kills $Lu + \lambda u$. Any other $\lambda$-weighting (e.g. $\lambda^{\lvert\alpha\rvert}$) is likewise a different family — not this theorem. |
| 5 | Guarding by $\lambda_0 \le \lambda$ instead of $\lambda_0 \le \lvert\lambda\rvert$. | Drops the negative half-line. $L_{-\lambda}$ differs from $L_\lambda$ wherever $m - \lvert\alpha\rvert$ is odd, so the two half-lines are genuinely different claims and the book asserts both; the one-sided statement is strictly weaker. |
| 6 | Admitting all real $\lambda$ — no lower bound on $\lvert\lambda\rvert$ in the solvability clause. | False at small $\lambda$: for $d = 1$, $m = 2$, $Lu = u'' - u$, the family is $L_\lambda u = u'' - \lambda^2 u$, and at $\lambda = 0$ both $u \equiv 0$ and $u \equiv 1$ lie in $C^{k+2+\delta}$ and solve $L_0 u = 0$. |
| 7 | Rendering ellipticity as a principal-part bound $\sum_{\lvert\alpha\rvert = m} a^\alpha(x)\xi^\alpha \ge \kappa\lvert\xi\rvert^m$, or any condition on the top order only. | Chapter 4 bounds the **whole** symbol below by $\kappa(1+\lvert\xi\rvert^m)$, lower-order terms included (at $\xi = 0$ it already constrains $a^0$). Top-order-only ellipticity admits $d = 1$, $m = 2$, $Lu = u''$, for which $L_\lambda u = u''$ for every $\lambda$; then $u \equiv 0$ and $u \equiv 1$ both solve $L_\lambda u = 0$ in $C^{k+2+\delta}$, so no threshold works and the statement is false. |
| 8 | Taking the coefficients (or $f$ and $u$) real-valued. | Chapter 4's coefficients are complex functions and its ellipticity is a modulus bound on a complex symbol; the real-valued restriction covers a strictly smaller class of operators — a different, weaker theorem. |
| 9 | Assuming the coefficients merely bounded or continuous. | Hölder continuity of the coefficients is what the Schauder theory needs; with only continuity the solvability statement is false in general. |
| 10 | Asserting existence only. | Uniqueness is half the theorem and is exactly what the threshold buys. |
| 11 | Stating uniqueness for a competitor $v$ without re-imposing $v \in C^{k+m+\delta}$. | Uniqueness fails in a larger class: for $Lu = u'' - u$ and $\lambda \ge \max(\lambda_0, 1)$, the unbounded $v(x) = e^{\lambda x}$ also solves $u'' - \lambda^2 u = 0$. The regularity has to be part of the uniqueness clause. |
| 12 | Encoding the Hölder memberships as norm finiteness alone, without the differentiability. | The derivatives inside the norm are `fderiv`-based and return $0$ off the differentiability locus, so a bounded nowhere-differentiable function has a finite norm and would count as a solution. |

## Notes on the ground truth

- Krylov's $\lambda_0$ depends only on $\kappa$, $m$, $\delta$, $d$ and $K$. In the Lean statement
  `lam₀` and `N₀` are bound after the implicit `a` and `k`, so nothing formally forbids a
  dependence on them; what identifies the pair with the book's constants is the pinning conjunct —
  Theorem 4.1.2's a priori estimate, quantified over every `u` in $C^{m+\delta}$ and every real
  $\lvert\lambda\rvert \ge \lambda_0$, and mentioning neither `k` nor `f`. A more literal rendering
  would quantify `∃ lam₀ N₀, ∀ a, …` with the ellipticity and bound hypotheses inside; the
  placement relative to `lam` and `f`, which is where the mathematical content lies, is correct.
- All norms take values in `ℝ≥0∞` (`krylovHolderNorm`, `holderSeminorm`, `supSeminorm`), so no
  supremum is a junk real. `krylovHolderNorm` is Krylov's sum-form norm $\lvert u\rvert_{k+\delta}$
  verbatim: the sup seminorms through order $k$ plus the top Hölder seminorm. `ENNReal.ofReal` is
  applied only where the argument is nonnegative (`0 < N₀`, an absolute value); `ENNReal.ofReal K`
  clamps a negative `K` to `0`, which together with ellipticity merely makes the hypotheses
  unsatisfiable rather than the claim false.
- `0 < N₀` where the book prints $N_0 \ge 0$ is a harmless strengthening: the estimate with any
  $N_0 \ge 0$ also holds with every larger positive constant.
- `MemHolderSpace` couples `ContDiffOn` with finiteness of `krylovHolderNorm`, because
  `multiDerivative` is `fderiv`-based and returns `0` off the differentiability locus; finiteness
  alone would admit rough functions (mistake 12).
- `lambdaScaledOperator` sums over `multiIndicesLE d m`, so the natural subtraction in
  `lam ^ (m - ∑ i, α i)` never truncates; at `lam = 1` the operator is $L$ itself, matching
  $L_1 = L$.
- `a` is indexed by all multi-indices although only those with $\lvert\alpha\rvert \le m$ enter the
  operator; the hypotheses quantify over all of them, harmless since any book instance extends by
  zero coefficients.
- Because the domain is all of $\mathbb{R}^d$ (`univ`), `∃!` over global functions is the right
  notion of uniqueness. In the domain problems of this book it must instead be `Set.EqOn` on the
  closure.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[krylov_4_5_1_variable_coefficient_global_solvability.md](krylov_4_5_1_variable_coefficient_global_solvability.md) and the background in [krylov_4_5_1_variable_coefficient_global_solvability.context.md](krylov_4_5_1_variable_coefficient_global_solvability.context.md),
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

- Requirement 6 with $\lambda_0$ supplied as a hypothesis rather than produced, or allowed to depend on $f$.
- Requirement 8 with the solvability clause unguarded — $\lambda$ admitted with no lower bound on $\lvert\lambda\rvert$.
- Requirement 10 with existence only, or uniqueness only.

### Domain-specific pitfalls for this problem

- The threshold depends only on the structural data, and its quantifier position is what makes the theorem uniform; the pinning estimate is what ties it to Theorem 4.1.2.
- Ellipticity is uniform in $x$ with a single $\kappa$, and it bounds the whole symbol $\sum a^\alpha i^{\lvert\alpha\rvert}\xi^\alpha$ — lower-order terms included — not just the principal part.
- The coefficients are complex, and $C^{k+\delta}$ globally, which also bounds them.
- The $\lambda$-scaling of the lower-order terms, not a shift, is what makes both signs of $\lambda$ work.
- The regularity gain is exactly $m$ derivatives.
