# Criteria: bogachev_gaussian_4_2_1_ehrhard_inequality

**Statement:** [bogachev_gaussian_4_2_1_ehrhard_inequality.md](bogachev_gaussian_4_2_1_ehrhard_inequality.md) · **Lean:** [bogachev_gaussian_4_2_1_ehrhard_inequality.lean](bogachev_gaussian_4_2_1_ehrhard_inequality.lean)

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
row is incomplete.

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
