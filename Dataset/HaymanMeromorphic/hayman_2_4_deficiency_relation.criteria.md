# Criteria: hayman_2_4_deficiency_relation

**Statement:** [hayman_2_4_deficiency_relation.md](hayman_2_4_deficiency_relation.md) · **Lean:** [hayman_2_4_deficiency_relation.lean](hayman_2_4_deficiency_relation.lean)

The theorem has two halves — countability of $\{\Theta > 0\}$ and the chain $\sum(\delta+\theta) \le \sum\Theta \le 2$ — and both must appear. The three indices are defined by a `liminf`/`limsup` of a *ratio to* $T(r)$, so the admissibility hypothesis $T(r)\to\infty$ is what stops the ratios from being junk. The sum over an infinite value set is expressed through arbitrary finite subsums, which is the standard junk-free rendering of a sum of nonnegative terms.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Conclusion completeness | Both the countability claim and the two inequalities are required; the second inequality $\sum\Theta\le2$ is the deep one. | ✅ A conjunction of `Countable` and the finite-subsum chain. ❗ Predicted error: keeping only $\sum\delta(a)\le2$. |
| 2 | Faithful encoding / summation | Summing over a possibly infinite set of values is rendered as: every finite subsum obeys the bound. This is equivalent for nonnegative summands and avoids `tsum` convergence side conditions. | ✅ `∀ s : Finset ℂ, …`. ⚠️ A `tsum` version would also be acceptable but needs summability. |
| 3 | Hypothesis completeness | Admissibility is what makes the indices meaningful; on the plane it amounts to $T(r,f)\to\infty$. | ✅ `hadm : Tendsto (characteristic f ⊤) atTop atTop`. ❗ Predicted error: omitting it, whereupon every ratio is a `0/0` junk value. |
| 4 | Faithful encoding / the indices | $\delta$ uses $m(r,a)/T(r)$ with a `liminf`; $\Theta$ uses $1 - \limsup \bar N/T$; $\theta$ uses $\liminf (N-\bar N)/T$. Swapping a `liminf` for a `limsup` changes each definition. | ✅ `deficiency`, `nevanlinnaTheta`, `ramificationIndex` follow the book. ❗ Predicted error: defining $\delta$ as $1-\limsup N/T$ without noticing it is the same only under the first fundamental theorem. |
| 5 | Junk values | `Filter.liminf`/`limsup` of an unbounded real family return junk; the reduced counting function is built from `Set.ncard`, which is `0` for an infinite set. | ⚠️ Both are controlled by admissibility and by the discreteness of the $a$-points of a nonconstant meromorphic function, but a candidate must not rely on either silently. |
| 6 | Mathlib conventions | $m$, $N$, $T$ are mathlib's `proximity`, `logCounting`, `characteristic`, with `a : WithTop ℂ` and `⊤` for $\infty$; only $\bar N$ is new. | ✅ Exactly one new counting function is introduced. |
