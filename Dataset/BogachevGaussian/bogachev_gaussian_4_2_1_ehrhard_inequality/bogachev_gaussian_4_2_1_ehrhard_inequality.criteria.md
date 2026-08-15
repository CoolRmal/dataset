# Criteria: bogachev_gaussian_4_2_1_ehrhard_inequality

**Statement:** [bogachev_gaussian_4_2_1_ehrhard_inequality.md](bogachev_gaussian_4_2_1_ehrhard_inequality.md) · **Lean:** [bogachev_gaussian_4_2_1_ehrhard_inequality.lean](bogachev_gaussian_4_2_1_ehrhard_inequality.lean) · **Context:** [bogachev_gaussian_4_2_1_ehrhard_inequality.context.md](bogachev_gaussian_4_2_1_ehrhard_inequality.context.md)

## What the theorem says

Write $\gamma_n$ for the standard Gaussian measure on $\mathbb{R}^n$ and $\Phi^{-1}$ for the inverse
of the standard normal distribution function, with the conventions $\Phi^{-1}(0) = -\infty$ and
$\Phi^{-1}(1) = +\infty$. Ehrhard's inequality says that the quantity $\Phi^{-1}(\gamma_n(A))$
behaves like a concave function of the convex set $A$: for convex sets $A$ and $B$ and any
$\lambda \in [0,1]$, the value at the Minkowski combination $\lambda A + (1-\lambda)B$ is at least
the corresponding combination $\lambda\Phi^{-1}(\gamma_n(A)) + (1-\lambda)\Phi^{-1}(\gamma_n(B))$.
This is the Gaussian analogue of the Brunn–Minkowski inequality.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The measure is the standard Gaussian on $\mathbb{R}^n$, with the Euclidean structure. | ✅ `stdGaussian (EuclideanSpace ℝ (Fin n))`. |
| 2 | $\Phi^{-1}$ takes values in $[-\infty,+\infty]$, with $-\infty$ at $0$ and $+\infty$ at $1$. | ✅ `quantile (gaussianReal 0 1) : ℝ → EReal`, defined as `sInf` of the coerced set `{y \| t ≤ cdf μ y}`; that infimum is `⊥` when the set is everything and `⊤` when it is empty. |
| 3 | Both $A$ and $B$ are convex. | ✅ `hA : Convex ℝ A` and `hB : Convex ℝ B`. |
| 4 | Both $A$ and $B$ are nonempty. | ✅ `hA' : A.Nonempty` and `hB' : B.Nonempty`. This is a genuine hypothesis, not a convenience; see mistake row 4. |
| 5 | $\lambda$ ranges over the closed interval $[0,1]$. | ✅ `hlam : lam ∈ Icc (0 : ℝ) 1`. |
| 6 | $\lambda A + (1-\lambda)B$ is the Minkowski combination $\{\lambda x + (1-\lambda)y : x \in A,\ y \in B\}$. | ✅ `lam • A + (1 - lam) • B`, using the pointwise scalar action and pointwise set addition. |
| 7 | The inequality relates the combination of the quantiles to the quantile of the combination, in that direction. | ✅ `(lam : EReal) * Φinv (γ A).toReal + (1 - lam : ℝ) * Φinv (γ B).toReal ≤ Φinv (γ (lam • A + (1 - lam) • B)).toReal`. |
| 8 | The weights are $\lambda$ and $1-\lambda$, matched to the same sets on both sides. | ✅ `lam` with `A`, `1 - lam` with `B`, on both sides. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Using a real-valued quantile function. | A real-valued inverse has to return some finite number at $0$ and at $1$, typically $0$ by Lean's default. Sets of Gaussian measure $0$ or $1$ are exactly the interesting boundary cases, and there the inequality would become a finite claim that is simply false. This is the highest-value trap here. |
| 2 | Reading $\lambda A + (1-\lambda)B$ as a union $\lambda A \cup (1-\lambda)B$, or an intersection, or the scaled convex hull of $A \cup B$. | These are different sets. The Minkowski combination is generally much larger than the union and much smaller than the hull, so the inequality asserted is a different one. |
| 3 | Dropping convexity and stating it for arbitrary measurable sets. | Bogachev records that the measurable case is open. A candidate that drops convexity is formalizing an unproved conjecture, not this theorem. |
| 4 | Omitting nonemptiness of $A$ and $B$. | The empty set is convex, so `Convex ℝ A` alone does not rule it out. `EReal` arithmetic has $0 \cdot \bot = 0$. Take $A = \emptyset$ and $\lambda = 0$: the combination $0 \cdot \emptyset + 1 \cdot B$ is empty, so the right side is $\Phi^{-1}(0) = -\infty$, while the left side is $0 + \Phi^{-1}(\gamma_n(B))$, a finite number when $B$ has positive measure. The inequality fails. |
| 5 | Restricting $\lambda$ to the open interval $(0,1)$. | The printed statement includes the endpoints; excluding them weakens it. |
| 6 | Flipping the inequality so that the quantile of the combination is on the small side. | That reversed statement is false — it would say the Gaussian measure of a Minkowski combination is at most a combination of measures, which fails already for $A = B$ a half-space translate. |
| 7 | Working on `Fin n → ℝ` with the sup norm instead of `EuclideanSpace ℝ (Fin n)`. | For this particular statement the Minkowski combinations and the standard Gaussian are unaffected, but the choice matters for the companion isoperimetric statement, where the unit ball changes shape. Consistency with `EuclideanSpace` is expected. |

## Notes on the ground truth

- The inequality is printed with `≥`. We write it with the smaller side on the left, which is the Mathlib orientation; the content is unchanged.
- `(γ A).toReal` converts the measure value from `ℝ≥0∞` to `ℝ` before feeding it to the quantile. This is safe because `stdGaussian` is a probability measure, so the value is in $[0,1]$ and never hits the `∞ ↦ 0` truncation.
- Bogachev notes that convexity of only one of the two sets already suffices. Our statement assumes both, which is the printed form.
- `quantile` is defined once in `Defs.lean` and shared with the isoperimetric problem.
- Convex subsets of $\mathbb{R}^n$ are Lebesgue measurable, so no measurability hypothesis is needed on $A$, $B$, or their combination.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[bogachev_gaussian_4_2_1_ehrhard_inequality.md](bogachev_gaussian_4_2_1_ehrhard_inequality.md) and the background in [bogachev_gaussian_4_2_1_ehrhard_inequality.context.md](bogachev_gaussian_4_2_1_ehrhard_inequality.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 8 rows, so each row is worth 6.2 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 2 with a real-valued quantile: $\Phi^{-1}$ must reach $\pm\infty$, since measure $0$ and measure $1$ are exactly the extreme cases.
- Requirement 3 dropped: without convexity the statement is an open conjecture, not the theorem.
- Requirement 6 read as a union, an intersection, or a convex hull instead of the Minkowski combination.

### Domain-specific pitfalls for this problem

- Junk value — quantile: a real-valued inverse of $\Phi$ has to return some finite default at $0$ and $1$, and those are precisely the interesting cases. The target type must be `EReal` (or `ℝ≥0∞`-like).
- Arithmetic in `EReal` is not arithmetic in `ℝ`: $0 \cdot (-\infty) = 0$ and $(+\infty) + (-\infty) = -\infty$ by convention. At the endpoints $\lambda \in \{0,1\}$ and for sets of measure $0$ or $1$ these conventions decide what the inequality asserts, which is why nonemptiness of $A$ and $B$ is worth stating explicitly.
- $\lambda A$ is the pointwise scalar multiple of a set and $+$ is pointwise set addition; both are `Pointwise`-scoped operations, not the lattice ones.
- The Euclidean structure matters for the standard Gaussian; a sup-norm model of $\mathbb{R}^n$ is a different normed space, even where it does not change this particular statement.
- $\lambda$ ranges over the *closed* interval $[0,1]$.
