# Criteria: krylov_3_7_2_constant_coefficient_holder_solvability

**Statement:** [krylov_3_7_2_constant_coefficient_holder_solvability.md](krylov_3_7_2_constant_coefficient_holder_solvability.md) · **Lean:** [krylov_3_7_2_constant_coefficient_holder_solvability.lean](krylov_3_7_2_constant_coefficient_holder_solvability.lean) · **Context:** [krylov_3_7_2_constant_coefficient_holder_solvability.context.md](krylov_3_7_2_constant_coefficient_holder_solvability.context.md)

## What the theorem says

Fix a uniformly elliptic operator $L$ of order $m \ge 1$ with constant coefficients, and shift it by
a parameter: $L_\lambda u = Lu - \lambda u$. The theorem says the shifted equation is uniquely
solvable on the whole of $\mathbb{R}^d$ in Hölder scale: for every datum $f$ in $C^{k+\delta}$ there
is exactly one $u$ in $C^{k+m+\delta}$ with $L_\lambda u = f$ everywhere. The gain is exactly $m$
derivatives, and the solution is unique only within that regularity class.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The operator has order $m \ge 1$, and $k \ge 0$ is an integer, $0 < \delta < 1$. | ✅ `hm : 0 < m`, `k : ℕ` unconstrained, `hδ : 0 < δ ∧ δ < 1`. |
| 2 | $L$ is a sum $\sum_{\lvert\alpha\rvert \le m} a^\alpha D^\alpha$ acting pointwise, with the multi-indices really of order at most $m$. | ✅ `EllipticOperatorData m L` carries `order_le` and `formula : ∀ u x, L u x = ∑ α ∈ terms, coefficient α x * multiDerivative α u x`. |
| 3 | $L$ is uniformly elliptic: $\sum_{\lvert\alpha\rvert = m} a^\alpha \xi^\alpha \ge \kappa\lVert\xi\rVert^m$ for all $\xi$, with $\kappa > 0$. | ✅ `principalSymbol` together with `ellipticityConstant_pos`, where `∏ i, (ξ i) ^ (α i)` is $\xi^\alpha$. |
| 4 | The coefficients are constant, on exactly the multi-indices the operator actually uses. | ✅ `ConstantCoefficientEllipticOperator m L` adds `∀ α ∈ data.terms, ∀ x y, data.coefficient α x = data.coefficient α y`. |
| 5 | $\lambda$ is restricted to the sign for which $L_\lambda$ is invertible; it cannot be an arbitrary nonzero real. | ⚠️ `hlam : 0 < lam` is the correct restriction for $m = 2$. With the ellipticity written as in the statement file, the admissible sign actually flips when $m$ is a multiple of $4$ — see the notes. |
| 6 | "$f \in C^{k+\delta}$" is genuine membership: $k$ continuous derivatives *plus* a finite Hölder gauge. | ✅ `HolderOn (k + δ) univ f`, which is `ContDiffOn ℝ k f univ ∧ holderGauge k δ univ f < ⊤`. |
| 7 | The Hölder gauge is exactly Krylov's data: sup of $\lvert D^\alpha u\rvert$ over all $\lvert\alpha\rvert \le k$, together with the $\delta$-difference quotient of the derivatives of order exactly $k$, both over the whole set. | ✅ `holderGauge k δ Ω u` joins `⨆ α : {α // ∑ i, α i ≤ k}, ⨆ x : Ω, ENNReal.ofReal \|multiDerivative α u x\|` with the top-order quotient supremum. |
| 8 | The conclusion asserts existence **and** uniqueness, with the solution required to lie in $C^{k+m+\delta}$ — a gain of exactly $m$ derivatives. | ✅ `∃! u, HolderOn (k + m + δ) univ u ∧ ShiftedEllipticEquation L lam u f`. |
| 9 | The equation is the classical pointwise one, everywhere on $\mathbb{R}^d$, with the shift subtracted. | ✅ `ShiftedEllipticEquation L lam u f : ∀ x, L u x - lam * u x = f x`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Assuming only $\lambda \ne 0$. | Uniqueness fails for the wrong sign. Take $d = 1$, $m = 2$, $Lu = u''$ (so $\kappa = 1$), $\lambda = -1$, $f = 0$. Both $u \equiv 0$ and $u = \sin$ satisfy the regularity and the equation, since all derivatives of $\sin$ are bounded and Lipschitz, so every gauge is finite. That contradicts the uniqueness claim. |
| 2 | Asserting existence only. | The uniqueness half is half the theorem, and it is what the restriction on $\lambda$ pays for. |
| 3 | Stating uniqueness for any competing $v$ without re-imposing $v \in C^{k+m+\delta}$. | Uniqueness is false in a larger class; the regularity hypothesis has to appear on both the solution and the competitor. |
| 4 | Encoding "$u \in C^{k+m+\delta}$" as finiteness of the Hölder gauge alone. | `multiDerivative` is built from `fderiv`, which is $0$ off the differentiability locus. A bounded nowhere-differentiable function then has a finite gauge and would be admitted as a solution. The `ContDiffOn` clause is what rules that out. |
| 5 | Building the gauge from a real-valued `sSup`. | A real supremum over an unbounded family returns $0$, so "finite norm" would be satisfied by every function. Landing in `ℝ≥0∞` makes `< ⊤` a real condition. |
| 6 | Writing the top-order difference quotient without excluding $x = y$. | Division by $\lVert x - y\rVert^\delta = 0$ at $x = y$; the guard `⨆ (_ : x ≠ y)` is required. |
| 7 | Getting the shift backwards and writing $Lu + \lambda u = f$. | That is a different operator, and it is invertible for the opposite sign of $\lambda$. |
| 8 | Working in `Fin d → ℝ` rather than `EuclideanSpace ℝ (Fin d)`. | `Fin d → ℝ` carries the sup norm, so both the ellipticity constant and the Hölder quotient refer to $\max_i\lvert\xi_i\rvert$ instead of the Euclidean length. The class of elliptic operators is unchanged, but the constants are not the printed ones. |

## Notes on the ground truth

- `hlam : 0 < lam` is honest for the second-order case but not for every order. With the ellipticity written literally as $\sum_{\lvert\alpha\rvert=m}a^\alpha\xi^\alpha \ge \kappa\lVert\xi\rVert^m$, the Fourier multiplier of the principal part is $i^m\sum a^\alpha\xi^\alpha$, so its sign alternates with $m \bmod 4$. For $d = 1$, $m = 4$, $Lu = u''''$ and $\lambda = 1$, both $u \equiv 0$ and $u = \cos$ solve $L_\lambda u = 0$ in $C^{k+4+\delta}$, so the statement is still false for those orders. A fully faithful hypothesis would tie the admissible half-line to the parity convention (or move to complex $\lambda$ in a resolvent sector).
- `holderGauge` takes a maximum where Krylov's $\lvert u\rvert_{k+\delta}$ takes a sum. The two differ by a factor depending only on $d$ and $k$. That is invisible here, since the statement asserts no constants, but it would matter for a sharp-constant result.
- `HolderOn r Ω u` looks for a decomposition $r = k' + \delta'$ with $0 \le \delta' < 1$. That decomposition is unique, so `HolderOn (k + δ)` unambiguously means $C^{k+\delta}$.
- For odd $m$ the ellipticity condition cannot hold over $\mathbb{R}$ (replace $\xi$ by $-\xi$), so those cases are empty. Harmless.
- The top-order quotient could be expressed with mathlib's `HolderOnWith`/`eHolderNorm`, as the companion definition `HolderOnReal` does, instead of a hand-rolled quotient.
- Because the domain is all of $\mathbb{R}^d$, plain `∃!` on global functions is the right notion of uniqueness here. In the domain problems of this book uniqueness must instead be stated as `Set.EqOn` on the closure.

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

- Requirement 5 with $\lambda$ unrestricted in sign: the equation is then not solvable for every $f$.
- Requirement 8 with existence only, or uniqueness only.
- Requirement 6 with membership replaced by finiteness of a gauge, without asserting the derivatives exist.

### Domain-specific pitfalls for this problem

- The shift is $Lu - \lambda u$; the sign of $\lambda$ decides invertibility.
- Ellipticity constrains only the principal part $|\alpha| = m$.
- Hölder membership bundles the lower-order sup norms as well as the top seminorm.
- The regularity gain is exactly $m$: from $C^{k+\delta}$ data to $C^{k+m+\delta}$ solutions.
- Junk value — `deriv`/`fderiv`: a Hölder gauge written with derivative operators is meaningless where the derivative does not exist, so differentiability must be asserted.
