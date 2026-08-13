# Criteria: hayman_2_4_deficiency_relation

**Statement:** [hayman_2_4_deficiency_relation.md](hayman_2_4_deficiency_relation.md) · **Lean:** [hayman_2_4_deficiency_relation.lean](hayman_2_4_deficiency_relation.lean)

## What the theorem says

Nevanlinna attaches three numbers to each value $a$ of a meromorphic function $f$: the deficiency
$\delta(a)$, the ramification index $\theta(a)$, and $\Theta(a)$. Each measures, in a different way,
how much $f$ *fails* to take the value $a$; all three are between $0$ and $1$, and they are computed
by comparing a Nevanlinna function to the characteristic $T(r,f)$ as $r$ grows. The theorem says
that only countably many values have $\Theta(a) > 0$, and that when you add up over those values you
get $\sum_a\{\delta(a)+\theta(a)\} \le \sum_a \Theta(a) \le 2$. So a meromorphic function has a very
limited total budget of exceptional behaviour, and the budget is $2$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $f$ is meromorphic on the plane. | ✅ `hf : Meromorphic f`. |
| 2 | $f$ is admissible. In the plane this means $T(r,f) \to \infty$ as $r \to \infty$. | ✅ `hadm : Tendsto (characteristic f ⊤) atTop atTop`. |
| 3 | $\delta(a) = \liminf_{r\to\infty} m(r,a)/T(r,f)$, using a lower limit. | ✅ `deficiency`, defined in `Defs.lean` as `liminf (fun r ↦ proximity f a r / characteristic f ⊤ r) atTop`. |
| 4 | $\Theta(a) = 1 - \limsup_{r\to\infty} \bar N(r,a)/T(r,f)$, using the *reduced* counting function and an upper limit. | ✅ `nevanlinnaTheta`, built on `reducedLogCounting`. |
| 5 | $\theta(a) = \liminf_{r\to\infty}\bigl(N(r,a) - \bar N(r,a)\bigr)/T(r,f)$. | ✅ `ramificationIndex`, the difference of `logCounting` and `reducedLogCounting`. |
| 6 | $\bar N$ counts each $a$-point once, however high its multiplicity, and is $\int_0^r \frac{\bar n(t,a)-\bar n(0,a)}{t}\,dt + \bar n(0,a)\log r$. | ✅ `reducedLogCounting` in `Defs.lean`, built from `distinctCount`, the number of *distinct* roots in $\lVert z\rVert \le t$. |
| 7 | The set of $a$ with $\Theta(a) > 0$ is countable. | ✅ `{a : ℂ \| 0 < nevanlinnaTheta f a}.Countable`, the first conjunct. |
| 8 | The chain of two inequalities $\sum(\delta+\theta) \le \sum\Theta \le 2$, both parts asserted. | ✅ Two inequalities conjoined inside `∀ s : Finset ℂ`. |
| 9 | The sum ranges over a possibly infinite set of values, so it must be given a meaning that does not presuppose convergence. | ✅ Rendered as: *every* finite set `s` of values satisfies both inequalities. For nonnegative terms this is equivalent to the sum bound. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Keeping only $\sum_a \delta(a) \le 2$. | That is the older, weaker deficiency relation. The content of Theorem 2.4 is the stronger chain that includes $\theta$ and $\Theta$. |
| 2 | Omitting the countability claim. | It is one of the two things the theorem asserts, and it is what makes the sums meaningful in the first place. |
| 3 | Dropping the admissibility hypothesis $T(r,f)\to\infty$. | Every index is a ratio to $T(r,f)$. For a constant $f$, $T \equiv 0$, Lean's division by zero gives $0$, and the `liminf`/`limsup` become meaningless numbers rather than deficiencies. |
| 4 | Swapping a `liminf` for a `limsup` (or vice versa) in any of the three definitions. | $\delta$ and $\theta$ are lower limits and $\Theta$ is $1$ minus an upper limit. Swapping changes each quantity and can make the inequalities false. |
| 5 | Defining $\delta(a)$ as $1 - \limsup N(r,a)/T(r)$. | This equals $\liminf m(r,a)/T(r)$ only because of the first fundamental theorem, which is a separate result. Writing it this way assumes what the book proves elsewhere and is not the printed definition. |
| 6 | Using $N$ instead of $\bar N$ in $\Theta$. | With multiplicities counted, $1 - \limsup N/T$ is $\delta$-like, not $\Theta$. The whole point of $\Theta$ is that it ignores multiplicity, and $\Theta \ge \delta + \theta$ depends on that. |
| 7 | Writing the sum as a `tsum` without saying anything about summability. | `tsum` returns $0$ when the family is not summable, so an unsummable family would satisfy the bound for free. A `tsum` version is acceptable only if summability is part of the claim. |

## Notes on the ground truth

- Mathlib supplies $m$, $N$ and $T$ as `ValueDistribution.proximity`, `logCounting` and
  `characteristic`, with the target value living in `WithTop ℂ` and `⊤` playing the role of $\infty$.
  Only $\bar N$ had to be added, in `Defs.lean`; $\delta$, $\theta$ and $\Theta$ are then defined
  there in terms of it.
- Both sums range over `s : Finset ℂ`, so only finite values $a$ are summed. Hayman sums over all
  values, including $a = \infty$. Ours is therefore slightly weaker than the printed statement. A
  candidate that sums over `WithTop ℂ` is closer to the book and should not be penalised.
- The indices are `liminf`/`limsup` of real-valued families. In Lean, `limsup` of a family with no
  eventual upper bound falls back to a default value rather than $+\infty$. Similarly
  `distinctCount` is a `Set.ncard`, which is $0$ for an infinite set, and `reducedLogCounting` is a
  Bochner integral, which is $0$ when the integrand is not integrable. Admissibility plus the fact
  that a nonconstant meromorphic function has isolated $a$-points keep all of these in the intended
  range, but a candidate should not rely on that silently.
- `deficiency` takes its value argument in `WithTop ℂ` while `nevanlinnaTheta` and
  `ramificationIndex` take it in `ℂ`, so the statement has to insert the coercion
  `(a : WithTop ℂ)`. Making all three take `WithTop ℂ` would be tidier.
