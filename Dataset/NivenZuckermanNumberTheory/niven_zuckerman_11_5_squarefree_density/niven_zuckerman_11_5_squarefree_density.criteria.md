# Criteria: niven_zuckerman_11_5_squarefree_density

**Statement:** [niven_zuckerman_11_5_squarefree_density.md](niven_zuckerman_11_5_squarefree_density.md) · **Lean:** [niven_zuckerman_11_5_squarefree_density.lean](niven_zuckerman_11_5_squarefree_density.lean) · **Context:** [niven_zuckerman_11_5_squarefree_density.context.md](niven_zuckerman_11_5_squarefree_density.context.md)

## What the theorem says

Call an integer square-free if no perfect square bigger than $1$ divides it. Count how many
square-free integers there are between $1$ and $n$, divide by $n$, and let $n$ grow. The theorem
says this ratio has a limit and that the limit is $6/\pi^2 \approx 0.6079$: a shade over sixty
percent of the integers are square-free. This is the "natural" or "asymptotic" density of
Definition 11.1, which is a genuine limit.

Be careful: this chapter uses two different densities with similar names. The asymptotic density
$\delta(A) = \lim A(n)/n$ of Definition 11.1 is the one meant here. The Schnirelmann density
$d(A) = \inf_{n\ge1} A(n)/n$ of Definition 11.2 is an infimum, not a limit, and is generally
smaller. Choosing the wrong one is the characteristic error in this chapter.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The density used is the asymptotic one: a limit of $A(n)/n$ as $n \to \infty$, whose existence is part of the claim. | ✅ `HasNaturalDensity`, defined in `Defs.lean` as `Tendsto (fun n ↦ (countingFunction A n : ℝ) / n) atTop (𝓝 d)`. |
| 2 | $A(n)$ counts the members of $A$ in the range $1 \le a \le n$. | ✅ `countingFunction A n = Nat.card {a \| a ∈ A ∧ 1 ≤ a ∧ a ≤ n}`. |
| 3 | The set is the square-free naturals: those divisible by no square greater than $1$. | ✅ `{n : ℕ \| Squarefree n}`, mathlib's predicate. |
| 4 | The ratio is a real division, so the count is cast into $\mathbb{R}$. | ✅ `(countingFunction A n : ℝ) / n`. |
| 5 | The value is exactly $6/\pi^2$. | ✅ `HasNaturalDensity … (6 / Real.pi ^ 2)`. |
| 6 | The limit is along $n \to \infty$ through all naturals, not a subsequence. | ✅ `atTop` on `ℕ`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Using mathlib's `schnirelmannDensity` because it is the density mathlib provides. | This is the highest-value trap, and it produces a false statement. Schnirelmann density is the infimum of $A(n)/n$ over $n \ge 1$; for the square-free set that infimum is at most $106/176 \approx 0.6023$, strictly below $6/\pi^2 \approx 0.6079$. |
| 2 | Introducing a function `naturalDensity : Set ℕ → ℝ` that returns a default value when the limit does not exist, and asserting it equals $6/\pi^2$. | Hides the real content. Half the theorem is that the limit exists at all; a junk default would let a wrong definition satisfy the equation. |
| 3 | Stating the claim with `limsup` or `liminf` instead of a limit. | Strictly weaker: it no longer asserts that $A(n)/n$ converges. |
| 4 | Reading "square-free" as "not a perfect square". | A completely different set, of density $1$: almost every integer fails to be a perfect square. |
| 5 | Reading "square-free" as "not divisible by $4$" or only excluding $p^2$ for one prime. | Excluding all squares $a^2 > 1$ is the definition; excluding only some gives a set of larger density (for instance $3/4$ for the multiples-of-$4$ version). |
| 6 | Writing the value as $\pi^2/6$. | That is about $1.645$; a density cannot exceed $1$. |

## Notes on the ground truth

- Mathlib has no asymptotic-density API, so `HasNaturalDensity` and `countingFunction` are defined
  in `Defs.lean`. Writing the `Tendsto` statement out by hand is equally acceptable.
- Stating the density as a `Tendsto` rather than as the value of some function means no default
  value is ever produced: existence of the limit is asserted, not assumed.
- `Squarefree 0` is false and `Squarefree 1` is true in mathlib, matching the book. Since
  `countingFunction` only counts $a \ge 1$, the treatment of $0$ never matters.
- At $n = 0$ the ratio is $0/0$, which Lean evaluates to $0$. This is irrelevant because the limit
  is taken along `atTop`.
- The counting is done with `Nat.card` of a set that is finite for each `n`, so it is a genuine
  count and not the $0$ that `Nat.card` returns on infinite types.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[niven_zuckerman_11_5_squarefree_density.md](niven_zuckerman_11_5_squarefree_density.md) and the background in [niven_zuckerman_11_5_squarefree_density.context.md](niven_zuckerman_11_5_squarefree_density.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 6 rows, so each row is worth 8.3 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 1 with Schnirelmann density in place of natural density.
- Requirement 5 with a limsup or a subsequential limit rather than the existence of the limit.
- Requirement 3 with a definition of square-free that excludes $1$ or admits squares.

### Domain-specific pitfalls for this problem

- Natural and Schnirelmann density are different notions and both appear in this chapter.
- The counting function ranges over $1 \le a \le n$.
- The ratio is a real division, so the count must be cast.
- The value is $6/\pi^2$, the reciprocal of $\zeta(2)$.
