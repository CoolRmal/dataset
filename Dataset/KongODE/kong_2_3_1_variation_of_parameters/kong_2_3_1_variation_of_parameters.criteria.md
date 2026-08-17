# Criteria: kong_2_3_1_variation_of_parameters

**Statement:** [kong_2_3_1_variation_of_parameters.md](kong_2_3_1_variation_of_parameters.md) · **Lean:** [kong_2_3_1_variation_of_parameters.lean](kong_2_3_1_variation_of_parameters.lean) · **Context:** [kong_2_3_1_variation_of_parameters.context.md](kong_2_3_1_variation_of_parameters.context.md)

## What the theorem says

Take the linear system $x' = A(t)x + f(t)$ on an interval, with $A$ and $f$ continuous, and suppose
$X(t)$ is a fundamental matrix solution of the homogeneous system $x' = A(t)x$ — a matrix-valued
solution that is invertible at every point of the interval. Then a function is a solution of the
inhomogeneous system exactly when it has the form
$X(t)c + \int_{t_0}^{t} X(t)X^{-1}(s)f(s)\,ds$ for some constant vector $c$. Choosing
$c = X^{-1}(t_0)x_0$ picks out the unique solution with $x(t_0) = x_0$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | Everything happens on an interval, and the base point $t_0$ lies in it. | ✅ `hI : I.OrdConnected` and `ht₀ : t₀ ∈ I`. |
| 2 | The coefficient matrix $A$ and the forcing term $f$ are continuous on that interval. | ✅ `hA : ContinuousOn A I` and `hf : ContinuousOn f I`. |
| 3 | $X$ is a fundamental matrix solution: it solves $X' = A(t)X$ on the interval **and** is invertible at every point of it. | ✅ `FundamentalMatrixSolution I A X`, which is `(∀ t ∈ I, HasDerivAt X (A t * X t) t) ∧ ∀ t ∈ I, IsUnit (X t)`. |
| 4 | "The general solution is …" is an equivalence: for every function $y$, solving the inhomogeneous system on $I$ is the same as having the stated form. | ✅ `∀ y, IsTrajectoryOn I (fun t x ↦ A t *ᵥ x + f t) y ↔ ∃ c, ∀ t ∈ I, y t = …`. |
| 5 | The constant vector $c$ is quantified inside, after $y$: each solution has its own $c$. | ✅ `∃ c : Fin n → ℝ` sits on the right of the `↔`, under the `∀ y`. |
| 6 | The formula is $X(t)c$ plus $\int_{t_0}^{t} X(t)X^{-1}(s)f(s)\,ds$, with $X(t)$ on the left of $X^{-1}(s)$ and the matrix acting on the vector last. | ✅ `X t *ᵥ c + ∫ s in t₀..t, (X t * (X s)⁻¹) *ᵥ f s`. |
| 7 | The integral must be the oriented one, so that $t$ may lie on either side of $t_0$. | ✅ `∫ s in t₀..t, …`, mathlib's `intervalIntegral`. |
| 8 | Second claim: for every $x_0$ there is a solution with $y(t_0) = x_0$. | ✅ `∀ x₀, ∃ y, y t₀ = x₀ ∧ IsTrajectoryOn …`. |
| 9 | That solution is given in closed form as $X(t)X^{-1}(t_0)x_0 + \int_{t_0}^{t}X(t)X^{-1}(s)f(s)\,ds$. | ✅ `∀ t ∈ I, y t = (X t * (X t₀)⁻¹) *ᵥ x₀ + ∫ s in t₀..t, (X t * (X s)⁻¹) *ᵥ f s`. |
| 10 | That solution is the only one with that initial value. | ✅ `∀ z, z t₀ = x₀ → IsTrajectoryOn … z → Set.EqOn z y I`. |
| 11 | Solving the system means having a genuine derivative on the interval at every point of it. | ✅ `IsTrajectoryOn I F y`, i.e. `∀ t ∈ I, HasDerivWithinAt y (F t (y t)) I t`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Requiring the two-sided `HasDerivAt` at every point of an interval that may be closed. | The equivalence then fails from right to left. Take $n = 1$, $I = [0,1]$, $A = 0$, $f = 0$, $X = 1$, $t_0 = 0$; all hypotheses hold. Let $y = 1$ on $[0,1]$ and $y = 0$ elsewhere. The right side holds with $c = 1$, but $y$ is discontinuous at $0$, so `HasDerivAt y 0 0` fails. The cure is either to assume $I$ open, as Kong's $(a,b)$ is, or to use the within-interval derivative. |
| 2 | Asking for $X$ to be nonsingular at a single point only. | For matrix solutions of $X' = AX$ this is equivalent to nonsingularity everywhere, but only via Liouville's formula, which is not part of the statement. Written as a hypothesis, the single-point version is weaker and does not license the inverses appearing at every $s$ in the integral. |
| 3 | Dropping the interval hypothesis (`OrdConnected`) or the continuity of $f$. | Both are load-bearing against Lean's default values. `(X s)⁻¹` is `Matrix.inv`, which is `0` at a singular matrix; without `OrdConnected` the integration variable $s$ can leave $I$, where nothing says $X(s)$ is invertible. And an interval integral of a non-integrable function is `0`, so without continuity of $f$ the formula can hold with both sides silently degenerate. |
| 4 | Stating only "every solution has this form" and not the converse. | That is strictly weaker. "General solution" means the two classes coincide. |
| 5 | Writing `∃ c, ∀ y, …`. | That says one constant works for all solutions, which is false as soon as the solution space has dimension at least one. |
| 6 | Giving the closed formula for the initial value problem but not asserting uniqueness, or omitting the condition $y(t_0) = x_0$. | Both are asserted by "the solution of the IVP … is". Without uniqueness the second half of the theorem carries no more information than the first. |
| 7 | Using a set integral $\int_{[t_0,t]}$ instead of the oriented one. | For $t < t_0$ the set $[t_0,t]$ is empty, so the integral is $0$ and the formula is wrong. The oriented integral supplies the sign. |
| 8 | Writing $X^{-1}(s)X(t)$, or applying the matrix to the vector in the wrong order. | Matrices do not commute; the product order is part of the formula. |

## Notes on the ground truth

- Kong works on the open interval $(a,b)$. We allow any order-connected set $I$ and, for solutions (`IsTrajectoryOn`), use the derivative taken within $I$, which specialises correctly to the open case and also makes the statement true on a closed interval. The fundamental-matrix hypothesis `FundamentalMatrixSolution` instead asks for the ambient two-sided `HasDerivAt` of $X$ at each $t \in I$; on a non-open $I$ that is stronger than the textbook notion, but it sits on the hypothesis side, so the statement stays true — it merely applies to slightly fewer $X$ (and to exactly the textbook ones when $I$ is open).
- `IsUnit (X t)` and `(X t).det ≠ 0` are interchangeable over $\mathbb{R}$ (`Matrix.isUnit_iff_isUnit_det`); either is a fine encoding of "nonsingular".
- The hypotheses are exactly what keeps the two Lean default values out of the statement: continuity of $A$, $f$ and invertibility of $X$ on the interval make the integrand continuous on the compact segment between $t_0$ and $t$, so it is genuinely integrable, and `OrdConnected` puts that whole segment inside $I$ where $X$ is invertible.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[kong_2_3_1_variation_of_parameters.md](kong_2_3_1_variation_of_parameters.md) and the background in [kong_2_3_1_variation_of_parameters.context.md](kong_2_3_1_variation_of_parameters.context.md),
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

- Requirement 3 with the invertibility of $X$ dropped: $X^{-1}(s)$ is then a junk value.
- Requirement 4 with only one direction of the equivalence, so the formula is not shown to capture *all* solutions.
- Requirement 7 with a set-integral over $[t_0,t]$, which loses the orientation when $t < t_0$.

### Domain-specific pitfalls for this problem

- Junk value — matrix inverse: in Lean the inverse of a singular matrix is $0$, so nonsingularity of $X(t)$ must be part of the hypothesis.
- Matrix multiplication is not commutative; $X(t)X^{-1}(s)f(s)$ is a specific product with $X(t)$ outside the $s$-integral.
- The oriented interval integral is needed for $t$ on either side of $t_0$.
- "General solution" is a biconditional characterisation of the solution set.
- The constant $c$ is quantified per solution.
