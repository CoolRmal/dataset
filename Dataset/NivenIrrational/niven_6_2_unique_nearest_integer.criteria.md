# Criteria: niven_6_2_unique_nearest_integer

**Statement:** [niven_6_2_unique_nearest_integer.md](niven_6_2_unique_nearest_integer.md) · **Lean:** [niven_6_2_unique_nearest_integer.lean](niven_6_2_unique_nearest_integer.lean)

## What the theorem says

Given an irrational number $\alpha$, there is exactly one integer $m$ within distance less than
$\tfrac12$ of it: $-\tfrac12 < \alpha - m < \tfrac12$. Existence and uniqueness both matter. The
irrationality is there to avoid the half-integers: if $\alpha = n + \tfrac12$ then the two nearest
integers $n$ and $n+1$ are both at distance exactly $\tfrac12$, so with strict bounds neither of them
qualifies and no integer works at all. For every other real number the nearest integer exists and is
unique.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $\alpha$ is a real number assumed irrational. | ⚠️ `(a : ℝ) (ha : Irrational a)`. This is the book's hypothesis, but more than is needed: it would be enough that $\alpha$ is not a half-integer, i.e. $2\alpha \notin \mathbb{Z}$. |
| 2 | The conclusion asserts existence **and** uniqueness of the integer. | ✅ `∃! m : ℤ, …`. |
| 3 | The nearby object is an integer, not a natural number or a real. | ✅ `m : ℤ`, cast into `ℝ` inside the inequalities. |
| 4 | The lower bound $-\tfrac12 < \alpha - m$ is strict. | ✅ `-(1 / 2 : ℝ) < a - m`. |
| 5 | The upper bound $\alpha - m < \tfrac12$ is strict. | ✅ `a - m < 1 / 2`. |
| 6 | The two bounds are $\pm\tfrac12$ exactly, computed in the reals. | ✅ `(1 / 2 : ℝ)`, so the division is real division. |
| 7 | The quantity bounded is $\alpha - m$, in that order. | ✅ `a - m`. The interval is symmetric, so $m - a$ would say the same thing, but the printed form is $\alpha - m$. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Writing `∃ m : ℤ` instead of `∃! m : ℤ`. | Loses the theorem. Existence of a nearby integer is easy and holds even without the irrationality hypothesis in the non-strict form; uniqueness is Theorem 6.2's content. |
| 2 | Dropping the irrationality hypothesis. | The statement becomes false. At $\alpha = 1/2$ the candidates $m = 0$ and $m = 1$ give $\alpha - m = \tfrac12$ and $-\tfrac12$, neither of which is strictly inside, so no integer satisfies the condition and even existence fails. |
| 3 | Using non-strict bounds $-\tfrac12 \le \alpha - m \le \tfrac12$. | Then at half-integers two integers both qualify, so `∃!` is false there. The hypothesis excludes those points, so the statement would still be provable — but it is not the printed inequality, and it hides why irrationality is assumed. |
| 4 | Using a half-open interval such as $-\tfrac12 \le \alpha - m < \tfrac12$. | A different theorem: that version is true for every real number, so the irrationality hypothesis becomes decoration and Niven's point disappears. |
| 5 | Taking `m : ℕ`. | Fails for negative $\alpha$; there is no natural number within $\tfrac12$ of $-3.2$. |
| 6 | Writing the bound as `1 / 2` in a context where the division is on `ℤ` or `ℕ`. | That evaluates to $0$, so the condition becomes $0 < a - m < 0$, which nothing satisfies. |
| 7 | Stating the conclusion about a named witness, e.g. "`round a` satisfies the bounds". | That is existence with an explicit witness. It says nothing about uniqueness, and the theorem should not presuppose the rounding function. |

## Notes on the ground truth

- The witness is Mathlib's `round a`, but the statement deliberately does not mention it: Theorem 6.2
  is about what exists, not about how to compute it.
- `Irrational` is Mathlib's predicate. It is stronger than necessary, as noted in row 1, but it is
  the hypothesis the book states and keeps the formalization aligned with the text.
- The integer `m` is coerced to `ℝ` automatically in `a - m`; the subtraction happens in `ℝ`.
