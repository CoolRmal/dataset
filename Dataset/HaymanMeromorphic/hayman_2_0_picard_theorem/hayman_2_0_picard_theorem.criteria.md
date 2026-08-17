# Criteria: hayman_2_0_picard_theorem

**Statement:** [hayman_2_0_picard_theorem.md](hayman_2_0_picard_theorem.md) · **Lean:** [hayman_2_0_picard_theorem.lean](hayman_2_0_picard_theorem.lean) · **Context:** [hayman_2_0_picard_theorem.context.md](hayman_2_0_picard_theorem.context.md)

## What the theorem says

Take a meromorphic function on the whole complex plane that is not a rational function. Picard's
theorem says it hits almost every complex value infinitely many times: there are at most two values
$a$ for which the equation $f(z) = a$ has only finitely many solutions. Two is the true bound and
cannot be lowered to one — for example $e^z$ never takes the value $0$, and as a map to the sphere
it also never takes the value $\infty$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $f$ is meromorphic on all of $\mathbb{C}$. | ✅ `hf : Meromorphic f`, which unfolds to `∀ x, MeromorphicAt f x`. |
| 2 | $f$ is transcendental, i.e. not a rational function. | ✅ `htr : ¬ ∃ p q : Polynomial ℂ, q ≠ 0 ∧ ∀ z, q.eval z ≠ 0 → f z = p.eval z / q.eval z`. The `q ≠ 0` conjunct is essential: without it $q = 0$ makes the guard `q.eval z ≠ 0` false everywhere, the inner existential true for every `f`, and the hypothesis unsatisfiable. |
| 3 | "Assumes the value $a$ infinitely often" means the solution set of $f(z) = a$ is an infinite set. | ✅ `{z : ℂ \| f z = c}.Infinite`. |
| 4 | The exceptional set is the set of values that are *not* taken infinitely often. | ✅ `{c : ℂ \| ¬ {z : ℂ \| f z = c}.Infinite}`. |
| 5 | That exceptional set has at most two elements. | ✅ `∃ a b : ℂ, … ⊆ {a, b}`. Allowing `a = b` covers the cases of zero or one exception. |
| 6 | The bound is on the number of exceptional values, not on how often each value is missed. | ✅ The conclusion is a containment of the exceptional set, with nothing said about the finite solution sets themselves. |
| 7 | The solution sets $\{z \mid f(z) = a\}$ must mean the $a$-points of the meromorphic function, not of an arbitrary representative. | ✅ `hnf : ∀ z, MeromorphicNFAt f z` pins the representative to normal form: `f` is analytic (hence takes its true value) at every non-pole and takes the value `0` at poles, so the literal sets `{z \| f z = c}` read faithfully. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Saying the exceptional set is a `Set.Subsingleton`, or writing `∃ a, E ⊆ {a}`. | That is a bound of one, and it is false. Viewed on the sphere, $e^z$ omits both $0$ and $\infty$. |
| 2 | Saying the exceptional set is empty. | Even stronger than the previous error and false for the same reason. |
| 3 | Replacing "infinitely often" by "at least once", i.e. `{z \| f z = c} ≠ ∅`. | That is Picard's *little* theorem. It is strictly weaker: a function could take a value exactly once and still be counted as non-exceptional. |
| 4 | Dropping the transcendence hypothesis. | A rational function such as $1/z$ takes each value only finitely often, so every value is exceptional and the statement collapses. |
| 5 | Writing transcendence as "$f$ is not a polynomial". | That admits $1/z$, which is not a polynomial but is rational, and for which the conclusion fails. Polynomial-exclusion is the right notion for *entire* functions only. |
| 6 | Assuming $f$ is entire rather than meromorphic. | A different (easier) theorem. Hayman's §2.0 statement is about meromorphic functions. |
| 7 | Combining a bare `Meromorphic f` with the literal solution sets `{z \| f z = c}`, with nothing to pin the representative. | Mathlib's `Meromorphic` leaves the value of `f` on any discrete set unconstrained, so a representative can be re-valued to *delete* $a$-points, manufacturing extra "exceptional" values and making the statement provably false. An earlier version of the ground truth had exactly this defect; the current one incorporates the repair via `hnf : ∀ z, MeromorphicNFAt f z` (an order-based, representative-independent reading of the $a$-point sets would work too). |

## Notes on the ground truth

- The `q ≠ 0` conjunct in `htr` is load-bearing. An earlier version omitted it, and then $q = 0$
  satisfied the inner existential for every `f` — the hypothesis was false for every `f` and the
  theorem was vacuous. Non-rationality has to be said in a form that cannot be met by the zero
  denominator.
- Hayman writes "all values in the plane", and the Lean statement quantifies over `c : ℂ` only, so
  it bounds the number of exceptional *finite* values by two. On the sphere $\infty$ would count as
  one of the two exceptions, which is the slightly stronger reading. Both are defensible; a
  candidate that includes $\infty$ (via `WithTop ℂ`) is at least as strong.
- Mathlib models a meromorphic function as an ordinary function `f : ℂ → ℂ` that is `MeromorphicAt`
  at every point, and `Meromorphic f` alone does not determine the values of `f` on discrete sets —
  the recurring modelling hazard throughout this book. Here the hypothesis
  `hnf : ∀ z, MeromorphicNFAt f z` closes the gap: normal form forces `f` to be analytic, with its
  true value, at every non-pole, and to take the value `0` at each pole. So $a$-points can no longer
  be deleted by re-valuing the representative; the only remaining slack is that `{z \| f z = 0}` may
  pick up extra hits at poles, which only enlarges a solution set and is harmless for a bound on the
  number of exceptional values.
- No integrals, suprema or `toReal` coercions appear, so there is no default-value hazard beyond the
  representative convention above.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[hayman_2_0_picard_theorem.md](hayman_2_0_picard_theorem.md) and the background in [hayman_2_0_picard_theorem.context.md](hayman_2_0_picard_theorem.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 7 rows, so each row is worth 7.1 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 2 dropped or read as "not a polynomial": a rational function is a counterexample.
- Requirement 3 read as "omits the value" rather than "takes it only finitely often": a strictly weaker conclusion.
- Requirement 5 with a bound other than two exceptional values.

### Domain-specific pitfalls for this problem

- For a *meromorphic* function, transcendental means not rational; the polynomial version of the condition is the entire-function notion and is too weak here.
- Being exceptional means being attained only finitely often, not being omitted.
- A meromorphic function represented as a total function $\mathbb{C} \to \mathbb{C}$ is unconstrained on discrete sets, so any clause about the solution set of $f(z) = a$ must either pin the representative (normal form at every point) or count $a$-points in a representative-independent way; otherwise $a$-points can be silently deleted and the statement is false.
- "At most two" is naturally written as containment in a two-element set, which correctly allows fewer than two exceptions.
