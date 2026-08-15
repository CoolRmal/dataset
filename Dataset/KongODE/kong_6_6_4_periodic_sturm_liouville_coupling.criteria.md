# Criteria: kong_6_6_4_periodic_sturm_liouville_coupling

**Statement:** [kong_6_6_4_periodic_sturm_liouville_coupling.md](kong_6_6_4_periodic_sturm_liouville_coupling.md) · **Lean:** [kong_6_6_4_periodic_sturm_liouville_coupling.lean](kong_6_6_4_periodic_sturm_liouville_coupling.lean) · **Context:** [kong_6_6_4_periodic_sturm_liouville_coupling.context.md](kong_6_6_4_periodic_sturm_liouville_coupling.context.md)

## What the theorem says

Consider the Sturm–Liouville equation $(p y')' = (q - \lambda w)y$ on $[a,b]$ with $p, q, w$
continuous and $p, w$ positive. Three boundary value problems can be posed on it: periodic, Dirichlet
and Neumann. Each has an infinite increasing sequence of real eigenvalues — call them $\lambda_n$,
$\mu_n$ and $\nu_n$. The theorem says these three sequences interlace in a precise pattern, with the
inequalities alternating between strict and non-strict in a period-four rhythm:
$\nu_0 \le \lambda_0 < \{\mu_0,\nu_1\} < \lambda_1 \le \{\mu_1,\nu_2\} \le \lambda_2 < \cdots$. It
adds two refinements: the lowest periodic eigenvalue is always simple, and a higher one has a
two-dimensional eigenspace exactly when it is simultaneously a Dirichlet and a Neumann eigenvalue;
and the eigenfunctions have a prescribed number of zeros — none for $\lambda_0$, and exactly $2n+2$
in $[a,b)$ for both $\lambda_{2n+1}$ and $\lambda_{2n+2}$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The coefficient data: $a < b$; $p$, $q$, $w$ continuous on $[a,b]$; $p > 0$ and $w > 0$ there. | ✅ `PeriodicSturmLiouvilleData p q w a b`. |
| 2 | The three sequences are **produced** by the theorem, not given to it. | ✅ `∃ lam μ ν : ℕ → ℝ, …`. |
| 3 | The periodic eigenvalues are nondecreasing, bounded below and unbounded above. | ✅ `∀ n, lam n ≤ lam (n + 1)` and `Tendsto lam atTop atTop`; boundedness below follows from monotonicity, and there are infinitely many distinct values because of the strict inequalities `lam (2n) < lam (2n+1)`. |
| 4 | Each sequence really lists the eigenvalues of its own problem — periodic for $\lambda$, Dirichlet for $\mu$, Neumann for $\nu$ — with nothing left out and nothing extra. | ✅ Three equivalences of the shape `∀ eigVal, (∃ y, IsSturmLiouvilleEigenfunction p q w a b eigVal (…boundary…) y) ↔ ∃ n, lam n = eigVal`. |
| 5 | The equation is in quasi-derivative form: $y$ has a derivative $y'$ on $[a,b]$ and $p y'$ has derivative $(q - \lambda w)y$ there. | ✅ `∃ y', … (∀ x ∈ Icc a b, HasDerivWithinAt y (y' x) (Icc a b) x) ∧ ∀ x ∈ Icc a b, HasDerivWithinAt (fun t ↦ p t * y' t) ((q x - eigVal * w x) * y x) (Icc a b) x`. |
| 6 | An eigenfunction must be nontrivial **on $[a,b]$**, the interval where the equation is imposed. | ✅ `∃ x ∈ Set.Icc a b, y x ≠ 0` is the first conjunct of `IsSturmLiouvilleEigenfunction`. |
| 7 | The three sets of boundary conditions, all expressed with the same $y'$ that solves the equation. | ✅ `periodicBoundary p a b y y' := y a = y b ∧ p a * y' a = p b * y' b`, `dirichletBoundary a b y _ := y a = 0 ∧ y b = 0`, `neumannBoundary a b _ y' := y' a = 0 ∧ y' b = 0`. |
| 8 | The interlacing chain transcribed index by index, with the exact alternation of $<$ and $\le$, and the opening $\nu_0 \le \lambda_0$. | ✅ `ν 0 ≤ lam 0` plus, for every $n$, the eight relations `lam (2n) < μ (2n)`, `lam (2n) < ν (2n+1)`, `μ (2n) < lam (2n+1)`, `ν (2n+1) < lam (2n+1)`, `lam (2n+1) ≤ μ (2n+1)`, `lam (2n+1) ≤ ν (2n+2)`, `μ (2n+1) ≤ lam (2n+2)`, `ν (2n+2) ≤ lam (2n+2)`. |
| 9 | (a) $\lambda_0$ is geometrically simple: any two eigenfunctions for it are proportional on $[a,b]$. | ✅ `∀ y₁ y₂, … → ∃ c : ℝ, Set.EqOn y₂ (c • y₁) (Set.Icc a b)`. |
| 10 | (a) $\lambda_n$ has a two-dimensional eigenspace **exactly when** $\lambda_n = \mu_i = \nu_j$ for some $i, j$. | ✅ `∀ n, (∃ i j, lam n = μ i ∧ lam n = ν j) ↔ ∃ y₁ y₂, … ∧ ¬∃ c : ℝ, Set.EqOn y₂ (c • y₁) (Set.Icc a b)` — two non-proportional eigenfunctions. |
| 11 | (b) Every eigenfunction for $\lambda_0$ is zero-free on the **closed** interval $[a,b]$. | ✅ `{x ∈ Set.Icc a b \| y x = 0} = ∅`. |
| 12 | (b) Every eigenfunction for $\lambda_{2n+1}$ and every one for $\lambda_{2n+2}$ has exactly $2n+2$ zeros in the **half-open** interval $[a,b)$. | ✅ `{x ∈ Set.Ico a b \| y x = 0}.ncard = 2 * n + 2`, stated separately for the two indices. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Taking the three sequences as (implicit) variables of the theorem instead of existentially quantifying them. | Implicit variables are universally quantified, so the statement would claim the conclusion for *every* triple of sequences. With $p = w = 1$, $q = 0$, $a = 0$, $b = 1$ and $\lambda = \mu = \nu \equiv 0$ the hypotheses hold and the clause `Tendsto lam atTop atTop` already fails. |
| 2 | Defining "eigenfunction" by a global $y \ne 0$. | The equation and the boundary conditions only constrain $y$ on $[a,b]$, so a function that vanishes on $(-\infty, b]$ and equals $e^{-1/(x-b)^2}$ beyond $b$ qualifies, with $y' \equiv 0$: it is nonzero as a function, every equation clause reads $0 = 0$, and the periodic conditions hold. It would then be an eigenfunction for *every* real number, so the enumeration clause would force every real to be some $\lambda_n$, and the "no zeros" claim for $\lambda_0$ would fail outright. |
| 3 | Using $<$ throughout the chain, or $\le$ throughout. | The alternation is the content of the theorem. A uniform relation is either false (the strict places) or strictly weaker (the non-strict places). This is the single most likely transcription error. |
| 4 | Asserting the interlacing without any clause saying what $\mu$ and $\nu$ are. | The chain then constrains three arbitrary sequences and says nothing about the Dirichlet and Neumann problems. |
| 5 | Writing the equation as $p y'' + p' y' = (q - \lambda w)y$, or using `deriv`. | $p$ is only assumed continuous, so $p'$ need not exist and the product rule is unavailable — the quasi-derivative form is essential. And `deriv` returns `0` where a function is not differentiable, so it can hide the failure of differentiability. |
| 6 | Counting the zeros of the higher eigenfunctions in the closed interval $[a,b]$. | Periodic eigenfunctions take the same value at $a$ and at $b$, so a zero at $a$ is matched by one at $b$ and the closed-interval count is one too many. The half-open interval is what makes the count $2n+2$ correct. |
| 7 | Stating the $\lambda_0$ zero claim as `ncard = 0` rather than as "the zero set is empty". | `Set.ncard` is `0` for infinite sets, so a function vanishing on a whole subinterval would satisfy the count. Writing the set equal to `∅` has no such loophole. |
| 8 | Demanding two-sided derivatives at the endpoints $a$ and $b$. | A boundary value problem on $[a,b]$ says nothing about $y$ outside $[a,b]$; a two-sided derivative at an endpoint imposes conditions there and rules out genuine eigenfunctions that happen to be extended arbitrarily. |

## Notes on the ground truth

- The text's "may be geometrically simple or double" also contains the bound "at most double". That bound is not stated separately here. It is automatic for a second-order equation, but it is part of what the sentence asserts.
- Simplicity and doubleness are phrased through proportionality of eigenfunctions on $[a,b]$ rather than through the dimension of an eigenspace, which avoids having to build the eigenspace as a subspace. For a nonzero $y_1$ the two are the same condition.
- The boundary conditions take the derivative witness $y'$ carried by the eigenfunction predicate, rather than Lean's `deriv y`. This matters: `deriv` would be `0` at points of non-differentiability, and the mismatch between the two is exactly what let the junk eigenfunction of mistake 2 slip past an earlier version of the definition.
- All the derivatives are taken within $[a,b]$, which is the literal reading of a boundary value problem on a closed interval.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[kong_6_6_4_periodic_sturm_liouville_coupling.md](kong_6_6_4_periodic_sturm_liouville_coupling.md) and the background in [kong_6_6_4_periodic_sturm_liouville_coupling.context.md](kong_6_6_4_periodic_sturm_liouville_coupling.context.md),
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

- Requirement 8 with the interlacing chain's pattern of strict and non-strict inequalities altered, or with an order asserted between $\mu_i$ and $\nu_j$.
- Requirement 12 with the zero count taken on the closed interval $[a,b]$ rather than $[a,b)$.
- Requirement 5 with the equation written as $py''+p'y' = \dots$, which presupposes $p$ differentiable.

### Domain-specific pitfalls for this problem

- The equation is in quasi-derivative form: $y'$ exists and $p y'$ is differentiable; $p$ itself is only continuous.
- $\{\mu_i,\nu_j\}$ means "each of them separately", with no comparison between the two.
- An eigenfunction must be nontrivial on $[a,b]$; the zero function satisfies every boundary condition.
- Part (b)'s zero counts are on $[a,b)$ for $n \ge 1$ and on the closed $[a,b]$ for the zero-free statement about $\lambda_0$.
- Geometric simplicity is about the dimension of the eigenspace, not about algebraic multiplicity.
- The three sequences are conclusions of the theorem, not inputs.
