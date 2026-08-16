# Criteria: krylov_4_2_1_better_regular_data_better_regular_solution

**Statement:** [krylov_4_2_1_better_regular_data_better_regular_solution.md](krylov_4_2_1_better_regular_data_better_regular_solution.md) · **Lean:** [krylov_4_2_1_better_regular_data_better_regular_solution.lean](krylov_4_2_1_better_regular_data_better_regular_solution.lean) · **Context:** [krylov_4_2_1_better_regular_data_better_regular_solution.context.md](krylov_4_2_1_better_regular_data_better_regular_solution.context.md)

## What the theorem says

Two separate claims about a uniformly elliptic operator $L$ of order $m$ whose coefficients are
Hölder of order $k+\delta$ with norms bounded by $K_1$. First, a regularity gain valid for *every*
$\lambda$: if $u$ is in $C^{m+\delta}$ and $L_\lambda u = Lu - \lambda u$ happens to be in
$C^{k+\delta}$, then $u$ is in $C^{k+m+\delta}$. Second, for all $\lambda$ past a threshold
$\lambda_0$, a quantitative estimate with $\lambda$-weighted terms,

$$\lvert u\rvert_{k+m+\delta} + \lvert\lambda\rvert^{(k+m+\delta)/m}\lvert u\rvert_0 \le N\bigl(\lvert L_\lambda u\rvert_{k+\delta} + \lvert\lambda\rvert^{(k+\delta)/m}\lvert L_\lambda u\rvert_0\bigr),$$

where $N$ is one constant serving every $\lambda$, every $u$ and every datum.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The order satisfies $m \ge 1$, $k \ge 0$ is an integer, $0 < \delta < 1$, and $K_1 \ge 1$. | ✅ `hm : 0 < m`, `k : ℕ`, `hδ : 0 < δ ∧ δ < 1`, `hK₁ : 1 ≤ K₁`. |
| 2 | $L$ is a uniformly elliptic operator of order $m$, written as a sum of coefficient times derivative. | ✅ `hL : VariableCoefficientEllipticOperator m L`, which supplies an `EllipticOperatorData m L` with `order_le`, `formula`, `principalSymbol` and a positive ellipticity constant. |
| 3 | The coefficients lie in $C^{k+\delta}(\mathbb{R}^d)$. | ✅ `hcoeff : OperatorCoefficientsHolder m (k + δ) L`. |
| 4 | Every coefficient's Hölder gauge is bounded by the single constant $K_1$. | ✅ `hcoeffBound : OperatorCoefficientGaugeLE m k δ (ENNReal.ofReal K₁) L`. |
| 5 | The regularity gain is asserted for **every** $\lambda$, with no threshold attached. | ✅ The conjunct `HolderOn (k + m + δ) univ u` sits outside the `lam₀ ≤ lam →` guard, under `∀ (lam : ℝ) (u f), …`. |
| 6 | The threshold $\lambda_0$ is produced by the theorem, is strictly positive, and is fixed before $\lambda$, $u$ and $f$. | ✅ `∃ lam₀ : ℝ, 0 < lam₀ ∧ …`, with `∀ (lam : ℝ) (u f), …` coming afterwards. |
| 7 | The constant $N$ is finite and is chosen before $\lambda$, $u$ and $f$. | ✅ `∃ C : ℝ≥0∞, C < ∞ ∧ ∀ (lam : ℝ) (u f), …`. |
| 8 | The estimate is guarded by the threshold, applying only when $\lambda \ge \lambda_0$. | ✅ `lam₀ ≤ lam → …`. |
| 9 | The estimate has both weighted terms with the exponents $(k+m+\delta)/m$ on the left and $(k+\delta)/m$ on the right, multiplying the sup norms of $u$ and of $f$. | ✅ `ENNReal.rpow (ENNReal.ofReal \|lam\|) ((((k + m : ℕ) : ℝ) + δ) / m) * functionSupNorm univ u` and the matching term with exponent `(((k : ℕ) : ℝ) + δ) / m` on `f`. |
| 10 | $f$ is $L_\lambda u$, and both $u \in C^{m+\delta}$ and $f \in C^{k+\delta}$ are hypotheses. | ✅ `ShiftedEllipticEquation L lam u f`, `HolderOn (m + δ) univ u`, `HolderOn (k + δ) univ f`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Writing `∀ u, ∃ C, …` instead of `∃ C, ∀ u, …`. | A constant chosen after $u$ always exists, so the estimate becomes empty. The uniformity of $N$ over $u$, $f$ and $\lambda$ is the whole content of the second claim. |
| 2 | Taking $\lambda_0$ as an input of the theorem rather than something the theorem produces, or allowing $\lambda_0 = 0$. | The estimate would then be asserted down to $\lambda = 0$, where it is false: with $L = D^2$ on $\mathbb{R}$ and $u_n(x) = \sin(x/n)$ we get $Lu_n = -n^{-2}\sin(x/n)$, so the left side stays at least $1$ while the right side tends to $0$. |
| 3 | Guarding the estimate by $\lambda_0 \le \lvert\lambda\rvert$ instead of $\lambda_0 \le \lambda$. | That admits large negative $\lambda$, where the estimate fails. Take $d = 1$, $m = 2$, $Lu = u''$, $u = \sin(nx)$ and $\lambda = -n^2$ with $n^2 \ge \lambda_0$. Then $f = L_\lambda u = 0$, so the right side is $0$ while the left side is strictly positive. |
| 4 | Putting the regularity gain under the threshold guard. | The text asserts the gain "for any $\lambda$"; guarding it loses the part of the theorem that has no constants in it. |
| 5 | Dropping the hypothesis $f \in C^{k+\delta}$. | Both sides are `ℝ≥0∞`-valued, so if $f$ is not $C^{k+\delta}$ the right side is $\infty$ and the estimate holds for free. The hypothesis is what makes the inequality say something. |
| 6 | Swapping the two exponents, or attaching the $\lambda$-weight to the Hölder gauge rather than to the sup norm. | The weights encode the parabolic-style scaling of the problem. Placed wrongly, the inequality is a different and false claim. |
| 7 | Encoding the Hölder memberships as finiteness of a gauge only, without the `ContDiffOn` clause. | `multiDerivative` is built from `fderiv`, which is $0$ off the differentiability locus, so a bounded nowhere-differentiable function has a finite gauge and would slip through. |

## Notes on the ground truth

- Krylov's $N$ depends only on $\kappa, k, m, \delta, K_1, d$ — not on the individual operator. In the Lean statement `L` is an implicit variable of the theorem, so `C` and `lam₀` are chosen after `L` is fixed and may depend on all of it. That is strictly weaker than the printed theorem, though still non-trivial. A faithful version would read `∀ κ K₁, ∃ lam₀ C, ∀ L, …`, which also requires naming $\kappa$ instead of hiding it inside `VariableCoefficientEllipticOperator`.
- The weights are written with `\|lam\|`, but under the guard `lam₀ ≤ lam` with `lam₀ > 0` this is just `lam`. Harmless.
- With the ellipticity written as $\sum_{\lvert\alpha\rvert=m}a^\alpha\xi^\alpha \ge \kappa\lVert\xi\rVert^m$, the admissible half-line for $\lambda$ actually depends on $m \bmod 4$: the Fourier multiplier of the principal part is $i^m\sum a^\alpha\xi^\alpha$. For $d = 1$, $m = 4$, $Lu = u''''$ and $\lambda = n^4 \ge \lambda_0$, the function $u = \cos(nx)$ gives $f = 0$ with a strictly positive left side, so the estimate still fails at those orders. `0 < lam₀` fixes the second-order case only.
- The three hypotheses on $L$ each open their own `∃ data : EllipticOperatorData m L`. This is harmless — `formula` holds for all input functions, so testing on monomials shows any two representations agree on the multi-indices they use — but bundling one `data` and stating all three conditions about it would be clearer.
- `holderGauge` is a maximum where Krylov's $\lvert\cdot\rvert_{k+\delta}$ is a sum, so `hcoeffBound` bounds a slightly smaller quantity than the text does. Given that `C` may already depend on `L`, this changes nothing.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[krylov_4_2_1_better_regular_data_better_regular_solution.md](krylov_4_2_1_better_regular_data_better_regular_solution.md) and the background in [krylov_4_2_1_better_regular_data_better_regular_solution.context.md](krylov_4_2_1_better_regular_data_better_regular_solution.context.md),
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

- Requirement 5 with the regularity gain restricted to $|\lambda| \ge \lambda_0$: part 1 holds for every $\lambda$.
- Requirement 7 with $N$ quantified after $\lambda$ or $u$.
- Requirement 9 with either weighted term dropped or the two exponents interchanged.

### Domain-specific pitfalls for this problem

- The two parts have different $\lambda$-ranges: part 1 is unconditional, part 2 is above the threshold.
- The exponents $(k+m+\delta)/m$ and $(k+\delta)/m$ come from the scaling of the operator and are not symmetric.
- $|u|_0$ is the sup norm, distinct from the full Hölder norm $|u|_{k+\delta}$.
- $K_1 \ge 1$ bounds all coefficient norms with a single constant.
- The constant $N$ is chosen before everything it is claimed independent of.
