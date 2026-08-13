# Criteria: hayman_2_7_fixpoints_of_entire_functions

**Statement:** [hayman_2_7_fixpoints_of_entire_functions.md](hayman_2_7_fixpoints_of_entire_functions.md) · **Lean:** [hayman_2_7_fixpoints_of_entire_functions.lean](hayman_2_7_fixpoints_of_entire_functions.lean)

## What the theorem says

Iterate an entire function: $f_1 = f$ and $f_{\nu+1} = f \circ f_\nu$. A solution of $f_n(z) = z$ is
a fix-point of order $n$; it has *exact* order $n$ if it is not already a fix-point of some smaller
order. Baker's theorem says that if $f$ is entire and not a polynomial, then for every order $n$
except at most one, $f$ has infinitely many fix-points of exact order $n$. The single exception is
real: $f(z) = z + e^{g(z)}$ has no fix-points of order one at all.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $f$ is entire — differentiable on all of $\mathbb{C}$. | ✅ `IsTranscendentalEntire f`, whose first component is `Differentiable ℂ f`. |
| 2 | $f$ is transcendental, i.e. not a polynomial. | ✅ The second component of `IsTranscendentalEntire`: `¬ ∃ p : Polynomial ℂ, ∀ z, f z = p.eval z`. |
| 3 | The iterates satisfy $f_1 = f$. | ✅ `h₁ : ∀ z, iter 1 z = f z`. |
| 4 | The iterates satisfy $f_{n+1} = f \circ f_n$, in that order. | ✅ `hstep : ∀ n z, iter (n + 1) z = f (iter n z)`. |
| 5 | A fix-point of order $n$ is a solution of $f_n(z) = z$. | ✅ `iter n z = z`. |
| 6 | *Exact* order $n$ additionally requires $f_m(z) \ne z$ for every $m$ with $1 \le m < n$. | ✅ `∀ m, 1 ≤ m → m < n → iter m z ≠ z`, conjoined with the previous condition. |
| 7 | "Infinitely many" means the set of such points is infinite. | ✅ `Set.Infinite` applied to that set, negated to form the bad set. |
| 8 | Only orders $n \ge 1$ are considered. | ✅ The bad set is `{n : ℕ \| 1 ≤ n ∧ …}`, which excludes `n = 0`. |
| 9 | The set of orders that fail has at most one element. | ✅ `Set.Subsingleton` applied to that set. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Dropping the minimality condition, so "fix-point of order $n$" replaces "fix-point of exact order $n$". | This is the highest-value trap. Fix-points of order $n$ include all fix-points of every divisor order, so the set is bigger and the claim is weaker. Exactness is what the theorem is about. |
| 2 | Requiring $f_m(z) \ne z$ for all $m \ne n$ rather than for $1 \le m < n$. | Wrong notion. A point of exact order $n$ is automatically a fix-point of order $2n$, $3n$, …, so the "all $m \ne n$" version describes the empty set. |
| 3 | Asserting the exceptional set of orders is empty. | False. $f(z) = z + e^{z}$ has no fix-point of order one, since $e^{z}$ never vanishes. |
| 4 | Allowing $f$ to be a polynomial. | False for $f(z) = z$, where every point is a fix-point of exact order one and there are none of any higher exact order — infinitely many orders fail. |
| 5 | Dropping entirety and allowing a merely meromorphic $f$. | The composition $f \circ f_n$ is not even well behaved as a meromorphic function in general; Baker's theorem is stated for integral functions. |
| 6 | Introducing an iterate function as a parameter without supplying both $f_1 = f$ and $f_{n+1} = f \circ f_n$. | An unconstrained `iter` makes the statement false: choose `iter n z = z` for every `n` and every order has infinitely many fix-points of order `n` but none of exact order `n ≥ 2`. |
| 7 | Including $n = 0$ in the set of orders. | $f_0$ is not defined by Hayman's recursion, so the $n = 0$ case is meaningless and could add a spurious exception. |

## Notes on the ground truth

- The iterates are passed in as an extra function `iter : ℕ → ℂ → ℂ` constrained by two hypotheses,
  rather than defined. Together `h₁` and `hstep` determine `iter n` for every `n ≥ 1`, which is all
  the conclusion uses; `iter 0` is left almost free and is irrelevant. Using `f^[n]`
  (`Function.iterate`) would be more idiomatic and would remove both hypotheses — a candidate that
  does so should be credited, provided it uses `f^[n]` with `n ≥ 1` so that `f^[1] = f`.
- `Set.Subsingleton` is the right rendering of "except for at most one value of $n$": it allows zero
  or one exception, never two.
- No integrals, suprema or coercions appear here, so there is no default-value hazard.
