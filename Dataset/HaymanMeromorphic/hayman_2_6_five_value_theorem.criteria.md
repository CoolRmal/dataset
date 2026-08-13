# Criteria: hayman_2_6_five_value_theorem

**Statement:** [hayman_2_6_five_value_theorem.md](hayman_2_6_five_value_theorem.md) · **Lean:** [hayman_2_6_five_value_theorem.lean](hayman_2_6_five_value_theorem.lean)

## What the theorem says

Let $f_1$ and $f_2$ be meromorphic on the whole plane. For a value $a$, write $E_j(a)$ for the set
of points where $f_j$ equals $a$. Nevanlinna's five-value theorem says that if $E_1(a) = E_2(a)$ for
five different values of $a$, then either $f_1$ and $f_2$ are the same function, or they are both
constant. The sets are compared as plain sets of points, so multiplicities are ignored. Five is
sharp: $f_1 = e^{z}$ and $f_2 = e^{-z}$ share the four values $0$, $1$, $-1$ and $\infty$ but are
different functions.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | Both functions are meromorphic on the whole plane. | ✅ `h₁ : Meromorphic f₁` and `h₂ : Meromorphic f₂`, each unfolding to `∀ x, MeromorphicAt _ x`. |
| 2 | There are five values, and they are pairwise different. | ✅ `a : Fin 5 → ℂ` together with `ha : Function.Injective a`. |
| 3 | $E_j(a)$ is the *set* of solutions of $f_j(z) = a$, with no multiplicity data. | ✅ `{z : ℂ \| f₁ z = a ν}` and the same for `f₂`. |
| 4 | The shared-value hypothesis is set equality, for each of the five values. | ✅ `hE : ∀ ν, {z : ℂ \| f₁ z = a ν} = {z : ℂ \| f₂ z = a ν}`. |
| 5 | The conclusion is a disjunction: the functions are equal, or both are constant. | ✅ `f₁ = f₂ ∨ ((∃ c₁, ∀ z, f₁ z = c₁) ∧ ∃ c₂, ∀ z, f₂ z = c₂)`. |
| 6 | In the second branch, *both* functions must be constant, not just one. | ✅ The second branch is a conjunction of two constancy statements. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Using four shared values instead of five. | False. $e^{z}$ and $e^{-z}$ share $0,1,-1,\infty$ and are not equal, so the four-value version of this conclusion fails. |
| 2 | Taking the values from an arbitrary `Set ℂ` with no distinctness condition, or an unindexed family with repeats. | Repeated values give fewer than five genuine conditions, so the hypothesis is weaker than intended and the theorem is no longer true. |
| 3 | Comparing counting functions, divisors, or zero multiplicities instead of point sets. | Sharing values *with multiplicity* is a much stronger hypothesis (four values then suffice). The difficulty of Theorem 2.6 comes precisely from ignoring multiplicity. |
| 4 | Dropping the "both constant" branch and concluding only $f_1 = f_2$. | False: two different constants $c_1 \ne c_2$, neither equal to any $a_\nu$, have $E_1(a_\nu) = E_2(a_\nu) = \emptyset$ for all five values. |
| 5 | Weakening the second branch to "$f_1$ is constant or $f_2$ is constant". | If only one is constant, the empty-set coincidences cannot happen; the honest statement requires both. |
| 6 | Assuming $f_1, f_2$ are only meromorphic on a disk, with no admissibility hypothesis. | Hayman notes right after the proof that the finite-disk version needs admissibility. Without a growth hypothesis the disk version is false. |

## Notes on the ground truth

- The constancy branches are written `∃ c, ∀ z, f z = c` rather than `∃ c, f = Function.const ℂ c`.
  These say the same thing; either is fine in a candidate.
- The five values are taken from `ℂ`, so all five are finite. Hayman lets them range over the sphere,
  where one of the five may be $\infty$ — meaning the two functions share their poles. Ours is
  therefore a special case of the printed statement, and a candidate that allows $\infty$ (values in
  `WithTop ℂ`, with $E_j(\infty)$ the pole set) is at least as strong.
- Mathlib models a meromorphic function as an ordinary `f : ℂ → ℂ` that is `MeromorphicAt` at every
  point, so `f` still has a value at each pole. The set `{z \| f z = a}` can therefore include a
  point where the analytic part is not really equal to $a$. Hayman means $a$-points of the analytic
  part. This is the standing modelling hazard for every set of the form `{z \| f z = a}` in this
  book.
- No integrals, suprema or coercions appear, so there is no default-value hazard beyond the pole
  convention above.
