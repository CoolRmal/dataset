# Criteria: kallenberg_6_13_gaussian_variance_criteria

**Statement:** [kallenberg_6_13_gaussian_variance_criteria.md](kallenberg_6_13_gaussian_variance_criteria.md) · **Lean:** [kallenberg_6_13_gaussian_variance_criteria.lean](kallenberg_6_13_gaussian_variance_criteria.lean) · **Context:** [kallenberg_6_13_gaussian_variance_criteria.context.md](kallenberg_6_13_gaussian_variance_criteria.context.md)

## What the theorem says

Consider a triangular array $(\xi_{nj})$: for each $n$ a finite row of independent random variables,
each with mean $0$, whose variances add up to something tending to $1$. The Lindeberg–Feller theorem
says that the following two things are equivalent. First: the row sums converge in distribution to a
standard normal variable *and* the largest variance in row $n$ tends to $0$. Second: for every
$\varepsilon > 0$, the total contribution to the variance coming from the part of each variable
exceeding $\varepsilon$ in absolute value tends to $0$. The second condition is the Lindeberg
condition.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The array has a finite row for each $n$, of length varying with $n$. | ✅ `k : ℕ → ℕ` and `ξ : (n : ℕ) → Fin (k n + 1) → Ω → ℝ`. |
| 2 | The variables within each row are mutually independent. | ✅ `hindep : ∀ n, iIndepFun (ξ n) μ` — mutual independence per row, not across rows. |
| 3 | Every variable is square integrable. | ✅ `hξsq : ∀ n j, MemLp (ξ n j) 2 μ`. |
| 4 | Every variable has mean $0$. | ✅ `hcentered : ∀ n j, ∫ ω, ξ n j ω ∂μ = 0`. |
| 5 | The row variances sum to something tending to $1$, as a standing hypothesis above the equivalence. | ✅ `hvariance : Tendsto (fun n ↦ ∑ j, variance (ξ n j) μ) atTop (𝓝 1)`, stated as a binder rather than as part of either side. |
| 6 | The comparison variable is standard normal. | ✅ `hζ : HasLaw ζ (gaussianReal 0 1) μ'`; Mathlib's `gaussianReal m v` takes `v` to be the variance, so this is $N(0,1)$. |
| 7 | Side (i), first half: the row sums converge in distribution to that variable. | ✅ `TendstoInDistribution (fun n ω ↦ ∑ j, ξ n j ω) atTop ζ (fun _ ↦ μ) μ'`. |
| 8 | Side (i), second half: the largest variance in row $n$ tends to $0$. | ✅ `Tendsto (fun n ↦ Finset.univ.sup' _ fun j ↦ variance (ξ n j) μ) atTop (𝓝 0)`. |
| 9 | Side (ii): for every $\varepsilon > 0$, the summed tail second moments above the strict threshold $\varepsilon$ tend to $0$. | ✅ `∀ ε : ℝ, 0 < ε → Tendsto (fun n ↦ ∑ j, ∫ ω, (ξ n j ω) ^ 2 * Set.indicator {x : ℝ \| ε < \|x\|} (fun _ ↦ (1 : ℝ)) (ξ n j ω) ∂μ) atTop (𝓝 0)`, with the strict inequality as printed. |
| 10 | The two sides are asserted equivalent, with (i) being a conjunction of its two halves. | ✅ `(sumConverges ∧ maximalVarianceVanishes) ↔ lindeberg`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Omitting independence within rows. | The transcribed sentence never says "independent" — it is hidden in the phrase "triangular array" — so this omission is likely. Without it the theorem is false: put $\xi_{nj} = X/\sqrt{n}$ for $j = 1, \dots, n$, with $X$ of mean $0$ and variance $1$. The variances sum to $1$, the largest tends to $0$, and the Lindeberg condition holds, but the row sums are $\sqrt{n}\,X$ and do not converge at all. |
| 2 | Using pairwise `IndepFun` instead of `iIndepFun`. | Pairwise independence does not give a central limit theorem; mutual independence of the whole row is required. |
| 3 | Omitting the square-integrability hypothesis. | Mathlib's `variance X μ` is `(evariance X μ).toReal`, which is $0$ when the second moment is infinite, and a Bochner integral of a non-integrable function is also $0$. Without $L^2$, both the centring condition and "variances sum to $1$" can be satisfied by variables with infinite variance. |
| 4 | Formalizing only "Lindeberg condition implies the central limit theorem". | That is the usual quoted direction, but the theorem is an equivalence and the converse (Feller's half) is the harder content. |
| 5 | Dropping the condition that the largest variance in each row tends to $0$. | Without it the equivalence fails: the Lindeberg condition implies negligibility, but asymptotic normality alone does not. |
| 6 | Folding "the variances sum to $1$" into side (i). | It is a standing hypothesis in the text. Moving it inside changes which statements are being compared. |
| 7 | Truncating instead of restricting to the tail — writing $\mathbb{E}\,(\min(\lvert\xi\rvert,\varepsilon))^2$ or similar. | The Lindeberg condition is about the second moment *on the event* $\lvert\xi\rvert > \varepsilon$; a truncated moment is a different quantity that does not tend to $0$. |
| 8 | Passing a standard deviation where `gaussianReal` expects a variance. | Here both are $1$, so it happens to coincide, but the convention must be understood; a candidate writing `gaussianReal 0 (Real.sqrt 1)` for a general variance has the wrong parameter. |

## Notes on the ground truth

- **Deliberate departure.** The Lindeberg integrals are written as a Bochner integral of $\xi^2$ times an indicator
  composed with $\xi$. The idiomatic Mathlib spelling is a set integral,
  `∫ ω in {ω \| ε < \|ξ n j ω\|}, (ξ n j ω) ^ 2 ∂μ`. The two are equal; the indicator form is
  correct but roundabout.
- **Deliberate departure.** Rows have length `k n + 1` rather than `k n`. The `+ 1` exists only so that each row is
  nonempty and `Finset.sup'` can be applied. Using `Fin (k n)` with a supremum that tolerates empty
  rows would be marginally more faithful.
- `hξmeas : ∀ n j, AEMeasurable (ξ n j) μ` is redundant given `hξsq`, since `MemLp` already carries
  almost-everywhere strong measurability. It is harmless.
- `HasLaw ζ (gaussianReal 0 1) μ'` also supplies measurability of `ζ`, so no separate hypothesis is
  needed for the comparison variable.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[kallenberg_6_13_gaussian_variance_criteria.md](kallenberg_6_13_gaussian_variance_criteria.md) and the background in [kallenberg_6_13_gaussian_variance_criteria.context.md](kallenberg_6_13_gaussian_variance_criteria.context.md),
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

- Requirement 8 dropped, so condition (i) is only the distributional convergence: the equivalence is then false.
- Requirement 9 with $\mathbb{E}(Y;A)$ read as a conditional expectation rather than $\mathbb{E}[Y\mathbf{1}_A]$.
- Requirement 5 moved inside one side of the equivalence rather than kept as a standing hypothesis.

### Domain-specific pitfalls for this problem

- $\mathbb{E}(Y; A)$ is the integral of $Y$ over the event $A$ — an indicator, not a conditioning.
- Independence is within each row; nothing links different rows.
- The negligibility condition $\sup_j \operatorname{Var} \to 0$ is half of (i) and is essential.
- The row length varies with $n$, so the array cannot be indexed by a fixed finite type.
- The threshold in the Lindeberg sum is strict, and $\varepsilon$ is quantified outside the limit in $n$.
