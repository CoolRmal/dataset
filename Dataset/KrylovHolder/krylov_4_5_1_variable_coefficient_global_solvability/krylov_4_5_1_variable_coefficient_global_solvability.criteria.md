# Criteria: krylov_4_5_1_variable_coefficient_global_solvability

**Statement:** [krylov_4_5_1_variable_coefficient_global_solvability.md](krylov_4_5_1_variable_coefficient_global_solvability.md) · **Lean:** [krylov_4_5_1_variable_coefficient_global_solvability.lean](krylov_4_5_1_variable_coefficient_global_solvability.lean) · **Context:** [krylov_4_5_1_variable_coefficient_global_solvability.context.md](krylov_4_5_1_variable_coefficient_global_solvability.context.md)

## What the theorem says

Let $L$ be a uniformly elliptic operator of order $m$ on $\mathbb{R}^d$ whose coefficients are
Hölder of order $k+\delta$. The theorem produces a threshold $\lambda_0$ such that, once the shift
parameter is past that threshold, the equation $Lu - \lambda u = f$ is uniquely solvable in Hölder
scale: for every $f$ in $C^{k+\delta}$ there is exactly one $u$ in $C^{k+m+\delta}$ solving it. The
threshold is a fixed number, chosen once and for all before $\lambda$ and before the datum.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $m \ge 1$, $k \ge 0$ an integer, $0 < \delta < 1$. | ✅ `hm : 0 < m`, `k : ℕ` unconstrained, `hδ : 0 < δ ∧ δ < 1`. |
| 2 | $L$ is a sum $\sum_{\lvert\alpha\rvert \le m} a^\alpha(x) D^\alpha$, applied pointwise, with the multi-indices of order at most $m$. | ✅ `EllipticOperatorData m L` carries `order_le` and `formula`. |
| 3 | $L$ is uniformly elliptic: $\sum_{\lvert\alpha\rvert = m}a^\alpha(x)\xi^\alpha \ge \kappa\lVert\xi\rVert^m$ for all $x$ and $\xi$, with $\kappa > 0$. | ✅ `principalSymbol` plus `ellipticityConstant_pos`, inside `hL : VariableCoefficientEllipticOperator m L`, with the sign normalised by the parity factor $(-1)^{m/2+1}$ (see row 6 and the notes). |
| 4 | The coefficients are $C^{k+\delta}$ on all of $\mathbb{R}^d$ — which in particular makes them bounded. | ✅ `hcoeff : OperatorCoefficientsHolder m (k + δ) L`, i.e. `HolderOn (k + δ) univ` for each coefficient used by `formula`. |
| 5 | The threshold $\lambda_0$ is produced by the theorem, not supplied to it, and is fixed before both $\lambda$ and $f$. | ✅ `∃ lam₀ : ℝ, 0 < lam₀ ∧ ∀ lam : ℝ, lam₀ ≤ lam → ∀ f, …`. |
| 6 | $\lambda$ is restricted to the half-line on which $L_\lambda$ is actually invertible. | ✅ `lam₀ ≤ lam` with `0 < lam₀`. The parity-normalised ellipticity makes this the right restriction at every order $m$; the text's two-sided $\lvert\lambda\rvert \ge \lambda_0$ is not available under any single sign convention, so the ground truth states the one-sided form. |
| 7 | "$f \in C^{k+\delta}$" and "$u \in C^{k+m+\delta}$" are genuine membership: $\lfloor r\rfloor$ continuous derivatives plus a finite Hölder gauge. | ✅ `HolderOn r univ ·` is `ContDiffOn ℝ k' · univ ∧ holderGauge k' δ' univ · < ⊤`, and the decomposition $r = k' + \delta'$ is unique. |
| 8 | The conclusion asserts existence **and** uniqueness, with uniqueness relative to the same class $C^{k+m+\delta}$. | ✅ `∃! u, HolderOn (k + m + δ) univ u ∧ ShiftedEllipticEquation L lam u f`. |
| 9 | The equation is the classical pointwise one on all of $\mathbb{R}^d$, with the shift subtracted. | ✅ `ShiftedEllipticEquation L lam u f : ∀ x, L u x - lam * u x = f x`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Writing `∀ f, ∃ lam₀, …`. | A threshold chosen after the datum is useless: the theorem says one threshold works for all data at once. |
| 2 | Guarding by $\lambda_0 \le \lvert\lambda\rvert$ instead of $\lambda_0 \le \lambda$. | Large negative $\lambda$ would be admitted and uniqueness fails there. Take $d = 1$, $m = 2$, $Lu = u''$, $\lambda = -(\lambda_0+1)$ and $f = 0$: both $u \equiv 0$ and $u(x) = \sin(\sqrt{\lambda_0+1}\,x)$ lie in $C^{k+2+\delta}$ and solve the equation. |
| 3 | Taking $\lambda_0$ as an input of the theorem. | Then the claim would include arbitrarily small thresholds, in particular $\lambda$ near $0$, where the equation is not uniquely solvable. |
| 4 | Asserting existence only. | Uniqueness is half the theorem and is exactly what the threshold buys. |
| 5 | Stating uniqueness for a competitor $v$ without re-imposing $v \in C^{k+m+\delta}$. | Uniqueness fails in a larger class; the regularity has to be part of the uniqueness clause. |
| 6 | Encoding the Hölder memberships as gauge finiteness alone. | The gauge's `multiDerivativeWithin` is `fderivWithin`-based, returning $0$ off the differentiability locus, so a bounded nowhere-differentiable function would have a finite gauge and count as a solution. |
| 7 | Assuming the coefficients merely bounded or continuous. | Hölder continuity of the coefficients is what the Schauder theory needs; with only continuity the solvability statement is false in general. |
| 8 | Writing $Lu + \lambda u = f$ for the shifted equation. | The opposite sign convention. It is invertible for the opposite sign of $\lambda$, so the threshold condition would be pointing the wrong way. |

## Notes on the ground truth

- Krylov's $\lambda_0$ depends only on $\kappa$, $m$, $\delta$, $d$ and $\max_\alpha\lvert a^\alpha\rvert_\delta$. Here `L` is an implicit variable of the theorem, so `lam₀` is chosen after `L` and may depend on all of it. Worse, `VariableCoefficientEllipticOperator m L = Nonempty (EllipticOperatorData m L)` hides $\kappa$ inside an existential, so the intended dependence cannot even be written down. A faithful version would take $\kappa$ and a coefficient bound as explicit parameters and quantify `∃ lam₀, ∀ L, …`. The placement relative to `f` is at least correct.
- Krylov prints the ellipticity as $\sum_{\lvert\alpha\rvert=m}a^\alpha\xi^\alpha \ge \kappa\lVert\xi\rVert^m$ and the restriction as the two-sided $\lvert\lambda\rvert \ge \lambda_0$. Under that raw convention the principal Fourier multiplier carries a sign of $i^m$, so the invertible half-line would flip whenever $m$ is a multiple of $4$ (for $d = 1$, $Lu = u''''$ and $\lambda = n^4$, both $u \equiv 0$ and $u = \cos(nx)$ solve $L_\lambda u = 0$ in $C^{k+4+\delta}$). The ground truth instead normalises the sign inside `EllipticOperatorData` with the parity factor $(-1)^{m/2+1}$, making $\lambda \ge \lambda_0 > 0$ the correct restriction at every order — see row 6. No single sign convention supports the printed two-sided form, which is why the one-sided guard is the recorded modelling choice.
- `hL` and `hcoeff` each introduce their own `EllipticOperatorData m L`. Benign, since `formula` is quantified over all input functions and therefore determines the coefficients from `L`, but a single bundled `data` would be cleaner and would let $\kappa$ be named.
- Because the domain is all of $\mathbb{R}^d$, `∃!` on global functions is the right notion of uniqueness. In the domain problems of this book it must instead be `Set.EqOn` on the closure.
- `holderGauge` uses a maximum where Krylov's norm uses a sum; the two are equivalent up to a factor depending on $d$ and $k$, invisible in a statement that asserts no constants.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[krylov_4_5_1_variable_coefficient_global_solvability.md](krylov_4_5_1_variable_coefficient_global_solvability.md) and the background in [krylov_4_5_1_variable_coefficient_global_solvability.context.md](krylov_4_5_1_variable_coefficient_global_solvability.context.md),
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

- Requirement 5 with $\lambda_0$ supplied as a hypothesis rather than produced, or allowed to depend on $f$.
- Requirement 6 with $\lambda$ unrestricted in sign.
- Requirement 8 with existence only, or uniqueness only.

### Domain-specific pitfalls for this problem

- The threshold depends only on the structural data, and its quantifier position is what makes the theorem uniform.
- Ellipticity is uniform in $x$ with a single $\kappa$.
- The coefficients are $C^{k+\delta}$ globally, which also bounds them.
- The shift's sign decides invertibility.
- The regularity gain is exactly $m$ derivatives.
