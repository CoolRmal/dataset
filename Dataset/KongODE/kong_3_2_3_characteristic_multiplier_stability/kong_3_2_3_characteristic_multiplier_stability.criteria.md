# Criteria: kong_3_2_3_characteristic_multiplier_stability

**Statement:** [kong_3_2_3_characteristic_multiplier_stability.md](kong_3_2_3_characteristic_multiplier_stability.md) · **Lean:** [kong_3_2_3_characteristic_multiplier_stability.lean](kong_3_2_3_characteristic_multiplier_stability.lean) · **Context:** [kong_3_2_3_characteristic_multiplier_stability.context.md](kong_3_2_3_characteristic_multiplier_stability.context.md)

## What the theorem says

For the linear system $x' = A(t)x$ with $\omega$-periodic coefficients, all stability information is
carried by one constant matrix: the transition matrix $V = X(\omega)X^{-1}(0)$ built from any
fundamental matrix solution. Its eigenvalues $\mu_1,\dots,\mu_n$ are called the characteristic
multipliers. The system is uniformly stable exactly when every multiplier has modulus at most $1$
and each multiplier of modulus exactly $1$ is semisimple (its Jordan blocks are all $1\times 1$).
It is asymptotically stable exactly when every multiplier has modulus strictly less than $1$. It is
unstable exactly when some multiplier has modulus greater than $1$, or has modulus $1$ and is not
semisimple.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The period is positive and $A$ repeats with that period at every time. | ✅ `hω : 0 < ω` and `PeriodicLinearEquation ω A`. |
| 2 | Kong's system (H-p) also assumes $A$ continuous. | ✅ `hA : Continuous A`. It is not actually used — `hV` already hands over a fundamental matrix $X$, and for any trajectory $y$ the function $X^{-1}y$ has derivative $0$, so the solution set is $\{X(t)c\}$ whatever the regularity of $A$ — but the printed theorem states it, so the ground truth does too. |
| 3 | $V$ is the one-period transition matrix built from **some** fundamental matrix solution on all of $\mathbb{R}$, pushed into the complex matrices. | ✅ `IsPeriodTransitionMatrix ω A V`, which is `∃ X, FundamentalMatrixSolution univ A X ∧ V = (X ω * (X 0)⁻¹).map (algebraMap ℝ ℂ)`. |
| 4 | $\mu$ is a list of exactly $n$ complex numbers: all eigenvalues of $V$, each repeated as often as its algebraic multiplicity. | ✅ `CharacteristicMultipliers V μ`, which is `Matrix.charpoly V = ∏ i, (Polynomial.X - Polynomial.C (μ i))`. Since the characteristic polynomial is monic of degree $n$, this pins $\mu$ down as the multiset of its roots. |
| 5 | "In the diagonal Jordan block" means every Jordan block of $V$ for that eigenvalue is $1\times 1$, equivalently $\ker(V - \mu)^2 = \ker(V - \mu)$. | ✅ `InDiagonalJordanBlock V μ`, which is `∀ v, (V - μ • 1) *ᵥ ((V - μ • 1) *ᵥ v) = 0 → (V - μ • 1) *ᵥ v = 0`. |
| 6 | Uniform stability picks $\delta$ before the initial time $t_0$, and controls the solution forward in time. | ✅ `UniformlyStableZeroSolution F` is `∀ ε > 0, ∃ δ > 0, ∀ t₀ x, 0 ≤ t₀ → IsTrajectory F x → ‖x t₀‖ < δ → ∀ t, t₀ ≤ t → ‖x t‖ < ε` — the `δ` is bound before `t₀`. |
| 7 | Asymptotic stability is uniform stability **plus** a single attraction radius, also independent of $t_0$. | ✅ `AsymptoticallyStableZeroSolution F` is `UniformlyStableZeroSolution F ∧ ∃ δ > 0, ∀ t₀ x, 0 ≤ t₀ → IsTrajectory F x → ‖x t₀‖ < δ → Tendsto x atTop (𝓝 0)`. |
| 8 | All three statements are equivalences, not one-way implications. | ✅ Three conjoined `↔`s. |
| 9 | (a) reads: uniformly stable $\iff$ every $\lvert\mu_i\rvert \le 1$, and $\lvert\mu_i\rvert = 1$ only when $\mu_i$ is semisimple. | ✅ `∀ i, ‖μ i‖ ≤ 1 ∧ (‖μ i‖ = 1 → InDiagonalJordanBlock V (μ i))`. |
| 10 | (b) reads: asymptotically stable $\iff$ every $\lvert\mu_i\rvert < 1$. | ✅ `∀ i, ‖μ i‖ < 1`. |
| 11 | (c) reads: unstable $\iff$ some $\mu_i$ has modulus $> 1$, or modulus $1$ and is not semisimple. | ✅ `∃ i, 1 < ‖μ i‖ ∨ (‖μ i‖ = 1 ∧ ¬InDiagonalJordanBlock V (μ i))`. |
| 12 | The stability predicates are about the linear field $x \mapsto A(t)x$, and the solutions quantified over are genuine ones. | ✅ `UniformlyStableLinearEquation A := UniformlyStableZeroSolution fun t x ↦ A t *ᵥ x`, with `IsTrajectory F x := ∀ t, HasDerivAt x (F t (x t)) t`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Saying "each $\mu_i$ is an eigenvalue of $V$", e.g. `∀ i, μ i ∈ spectrum ℂ V`. | This loses multiplicity and, worse, does not force the list to contain *all* the eigenvalues. A system with one multiplier of modulus $3$ would then satisfy the right side of (a) by listing the harmless eigenvalues only. |
| 2 | Encoding "in the diagonal Jordan block" as `V.IsDiag`. | That asks the whole transition matrix to be diagonal, which is a condition on $V$, not on the single multiplier $\mu_i$, and is far too strong. |
| 3 | Encoding it as "$\mu_i$ is a simple root of the characteristic polynomial". | Too strong in the other direction: a repeated eigenvalue of modulus $1$ is allowed provided each of its Jordan blocks is $1\times 1$. |
| 4 | Writing uniform stability as $\forall t_0\ \exists \delta$. | That is plain Lyapunov stability. The two happen to coincide for periodic linear systems, but the statement being formalized is the uniform one, and the quantifier order is the only thing that distinguishes them. |
| 5 | Defining asymptotic stability as "solutions tend to $0$", dropping the uniform-stability half, or letting the attraction radius depend on $t_0$. | Kong's asymptotic stability includes stability. Convergence alone does not imply stability — trajectories may make a large excursion before returning. |
| 6 | Stating (a), (b), (c) as one-way implications. | The theorem is a complete classification; each direction is used. |
| 7 | Describing solutions with `deriv x t = A t *ᵥ x t`. | `deriv` is `0` where the function is not differentiable, so this would admit non-solutions whenever the right side vanishes. |
| 8 | Taking the multipliers to be real, or eigenvalues of a real matrix. | The transition matrix generally has complex eigenvalues, and the modulus in the statement is the complex modulus. |

## Notes on the ground truth

- The transition matrix is only pinned down up to the choice of fundamental matrix solution, but the choice does not matter: two fundamental matrices differ by a constant right factor, $\tilde X = XM$, and then $\tilde X(\omega)\tilde X(0)^{-1} = X(\omega)X(0)^{-1}$. Kong's $V$ comes from $X(t+\omega) = X(t)V$, i.e. $X^{-1}(0)X(\omega)$, which is conjugate to ours, so both the multipliers and the semisimplicity condition are unchanged.
- Because `UnstableLinearEquation A` is defined as `¬UniformlyStableLinearEquation A`, part (c) is literally the contrapositive of part (a) and carries no independent mathematical content. We keep it because the text lists it. Note also that Kong's "unstable" negates plain stability while ours negates uniform stability; for periodic linear systems these agree.
- Requiring trajectories to be defined on all of $\mathbb{R}$ is exactly right here: every maximal solution of a linear system is global.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[kong_3_2_3_characteristic_multiplier_stability.md](kong_3_2_3_characteristic_multiplier_stability.md) and the background in [kong_3_2_3_characteristic_multiplier_stability.context.md](kong_3_2_3_characteristic_multiplier_stability.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 12 rows, so each row is worth 4.2 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 5 with the semisimplicity condition dropped from (a) and (c): the characterisation is then false.
- Requirement 8 with any of the three stated as a one-way implication.
- Requirement 4 with the multipliers listed as a *set* of eigenvalues rather than with algebraic multiplicity.

### Domain-specific pitfalls for this problem

- "In the diagonal Jordan block" is semisimplicity of that eigenvalue, i.e. all its Jordan blocks are $1\times1$.
- The multipliers are the $n$ eigenvalues with algebraic multiplicity, so a family indexed by `Fin n` is the right shape.
- The transition matrix is built from *some* fundamental matrix solution; its eigenvalues do not depend on the choice.
- Junk value — matrix inverse: $X^{-1}(0)$ is meaningful only because $X$ is nonsingular.
- "Uniformly" stable means the radius is independent of the initial time.
