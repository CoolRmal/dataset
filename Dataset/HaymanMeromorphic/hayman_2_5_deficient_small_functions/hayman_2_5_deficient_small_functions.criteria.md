# Criteria: hayman_2_5_deficient_small_functions

**Statement:** [hayman_2_5_deficient_small_functions.md](hayman_2_5_deficient_small_functions.md) · **Lean:** [hayman_2_5_deficient_small_functions.lean](hayman_2_5_deficient_small_functions.lean) · **Context:** [hayman_2_5_deficient_small_functions.context.md](hayman_2_5_deficient_small_functions.context.md)

## What the theorem says

The second fundamental theorem is usually stated for three fixed values $a_1,a_2,a_3$. This version
replaces the three constants by three *functions* $a_1(z),a_2(z),a_3(z)$, provided they grow much
more slowly than $f$, in the sense that $T(r,a_\nu)/T(r,f)\to 0$. The conclusion is
$\{1+o(1)\}\,T(r,f) \le \sum_{\nu=1}^3 \bar N\!\left(r,\frac{1}{f-a_\nu}\right) + S(r,f)$: the places
where $f$ meets the three slow functions, counted once each regardless of multiplicity, already
account for essentially the whole characteristic of $f$. In particular no three such functions can
all be deficient.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $f$ is meromorphic on the plane. | ✅ `hf : Meromorphic f`. |
| 2 | $f$ is admissible, i.e. $T(r,f) \to \infty$. | ✅ `hadm : Tendsto (characteristic f ⊤) atTop atTop`. |
| 3 | There are exactly three comparison objects, and they are meromorphic *functions*, not constants. | ✅ `a : Fin 3 → ℂ → ℂ` with `ha : ∀ ν, Meromorphic (a ν)`. |
| 4 | The three functions are pairwise distinct. | ✅ `hdistinct : ∀ ν μ, ν ≠ μ → a ν ≠ a μ`, distinctness as functions. |
| 5 | Each $a_\nu$ is small compared with $f$: condition (2.10), $T(r,a_\nu) = o(T(r,f))$. | ✅ `hsmall`, stated as `characteristic (a ν) ⊤ r / characteristic f ⊤ r → 0`. |
| 6 | The right-hand side uses the *reduced* counting function of the zeros of $f - a_\nu$, i.e. $\bar N(r, 1/(f-a_\nu))$. | ✅ `reducedLogCounting (fun z ↦ f z - a ν z) 0 r`, the reduced counting function at the value $0$ of $f - a_\nu$. |
| 7 | The sum has all three terms. | ✅ `∑ ν : Fin 3, …`. |
| 8 | The left-hand coefficient is $1 + o(1)$ and the right-hand side carries an error term $S(r,f)$ that is $o(T(r,f))$. | ✅ Both are absorbed into a single $\varepsilon$: for each `ε > 0`, eventually `(1 - ε) * T r ≤ ∑ N̄ + ε * T r`. |
| 9 | The inequality is asymptotic — it holds for all large $r$, not for every $r$. | ✅ `∀ᶠ r in atTop`, sitting inside `∀ ε, 0 < ε → …`, so the threshold on $r$ may depend on $\varepsilon$. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Taking the $a_\nu$ to be constants, `a : Fin 3 → ℂ`. | That is the classical three-value second fundamental theorem, a much easier result. Allowing slowly growing functions is the entire content of Theorem 2.5. |
| 2 | Dropping the smallness condition (2.10). | The statement then fails: take $a_\nu = f + \nu$, so $f - a_\nu$ is a nonzero constant, every reduced counting function is $0$, and the inequality would force $T(r,f) \le 0$. |
| 3 | Dropping distinctness of the three functions. | With $a_1 = a_2 = a_3$ the three terms coincide and the bound is the one-function estimate, which is false in general. |
| 4 | Using `logCounting` (multiplicities counted) instead of the reduced version. | That makes the right-hand side larger, so the inequality asserted is weaker than the printed one. The strength of the theorem is that multiple intersections are counted once. |
| 5 | Counting the $a_\nu$-points of $f$ as $\bar N(r, a_\nu)$ for a fixed value $a_\nu$. | Only correct when $a_\nu$ is constant. For a moving target the object is the zero set of $f - a_\nu$. |
| 6 | Asserting the inequality for every $r > 0$ rather than for all large $r$. | The $o(1)$ and $S(r,f)$ terms are only controlled asymptotically; a claim at every radius is false. |
| 7 | Quantifying $\varepsilon$ inside the "eventually", as `∀ᶠ r, ∀ ε > 0, …`. | That would demand one radius threshold serving all $\varepsilon$ at once, which is strictly stronger and not what $o(1)$ means. |
| 8 | Counting the zeros of $f - a_\nu$ through the literal solution set `{z \| ‖z‖ ≤ t ∧ f z - a ν z = 0}`. | Mathlib's `Meromorphic` does not pin the values of `f` on discrete sets, so a re-valued representative can hide all the genuine zeros of the three functions $f - a_\nu$ at once, zeroing all three $\bar N$ terms while $T(r,f)$ is unchanged — the inequality then fails for large $r$. An earlier version of the ground truth had exactly this defect; the current `distinctCount` incorporates the repair by testing membership with positive `meromorphicOrderAt`, which depends only on the germ. |

## Notes on the ground truth

- The book's `{1+o(1)}T(r,f) ≤ ∑ N̄ + S(r,f)` is rendered by folding both the $o(1)$ and the
  $S(r,f)$ into one arbitrary $\varepsilon$. This is faithful only because admissibility forces
  $S(r,f) = o(T(r,f))$ by Theorem 2.2. A candidate that introduces $S$ explicitly, with its own
  $o(T)$ hypothesis, is closer to the printed text and is equally acceptable.
- `reducedLogCounting` is an integral of a `Set.ncard`. Lean gives a set with infinitely many
  elements the count $0$, and gives a non-integrable integrand the integral $0$, so both could
  quietly return $0$. Here they cannot: $f - a_\nu$ is meromorphic and not identically zero, so its
  zeros are isolated. A candidate should not depend on this silently.
- `hsmall` is a statement about the ratio of characteristics; because $T(r,f)\to\infty$, division by
  zero never occurs for large $r$, so the ratio form is safe.
- The reduced counting function is applied to `fun z ↦ f z - a ν z`. Mathlib's meromorphic functions
  are ordinary functions, so this subtraction is literal pointwise subtraction, including at poles —
  but `distinctCount` tests membership by `0 < meromorphicOrderAt`, which sees only the meromorphic
  germ of the difference, so junk values at poles or on any discrete set never add or remove counted
  zeros.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[hayman_2_5_deficient_small_functions.md](hayman_2_5_deficient_small_functions.md) and the background in [hayman_2_5_deficient_small_functions.context.md](hayman_2_5_deficient_small_functions.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 9 rows, so each row is worth 5.6 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 3 with the $a_\nu$ taken to be constants: that is the second fundamental theorem, not this refinement.
- Requirement 6 with $N$ in place of $\bar N$.
- Requirement 5 dropped, so the comparison functions are unrestricted.

### Domain-specific pitfalls for this problem

- $\bar N(r, 1/(f-a_\nu))$ counts *zeros of $f - a_\nu$*, ignoring multiplicity; the reciprocal in the notation does not mean a counting function of $1/f$.
- Both $\{1+o(1)\}$ and $S(r,f)$ are $o(T(r,f))$ error terms; folding them into a single $\varepsilon T(r,f)$ on each side is the faithful reading.
- The inequality holds eventually in $r$, not for every $r$.
- Distinctness of the $a_\nu$ is as functions, not pointwise at each $z$.
- Admissibility of $f$ must be assumed.
- Junk value — representatives: the zeros of $f - a_\nu$ must be counted through the germ (positive meromorphic order), not through the literal values of the chosen representative, which are unconstrained on discrete sets.
