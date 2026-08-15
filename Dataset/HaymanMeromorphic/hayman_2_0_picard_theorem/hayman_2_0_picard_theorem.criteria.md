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
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $f$ is meromorphic on all of $\mathbb{C}$. | ✅ `hf : Meromorphic f`, which unfolds to `∀ x, MeromorphicAt f x`. |
| 2 | $f$ is transcendental, i.e. not a rational function. | ✅ `htr : ¬ ∃ p q : Polynomial ℂ, q ≠ 0 ∧ ∀ z, q.eval z ≠ 0 → f z = p.eval z / q.eval z`. The `q ≠ 0` conjunct is essential: without it $q = 0$ makes the guard `q.eval z ≠ 0` false everywhere, the inner existential true for every `f`, and the hypothesis unsatisfiable. |
| 3 | "Assumes the value $a$ infinitely often" means the solution set of $f(z) = a$ is an infinite set. | ✅ `{z : ℂ \| f z = c}.Infinite`. |
| 4 | The exceptional set is the set of values that are *not* taken infinitely often. | ✅ `{c : ℂ \| ¬ {z : ℂ \| f z = c}.Infinite}`. |
| 5 | That exceptional set has at most two elements. | ✅ `∃ a b : ℂ, … ⊆ {a, b}`. Allowing `a = b` covers the cases of zero or one exception. |
| 6 | The bound is on the number of exceptional values, not on how often each value is missed. | ✅ The conclusion is a containment of the exceptional set, with nothing said about the finite solution sets themselves. |

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
  at every point, so `f` still has some complex *value* at each pole. The set `{z \| f z = c}` can
  therefore pick up an accidental hit at a pole, where Hayman means an $a$-point of the analytic
  part. This is harmless for a bound on the number of exceptional values (extra points only make the
  solution sets larger), but it is the recurring modelling hazard throughout this book.
- No integrals, suprema or `toReal` coercions appear, so there is no default-value hazard beyond the
  pole convention above.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[hayman_2_0_picard_theorem.md](hayman_2_0_picard_theorem.md) and the background in [hayman_2_0_picard_theorem.context.md](hayman_2_0_picard_theorem.context.md),
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

- Requirement 2 dropped or read as "not a polynomial": a rational function is a counterexample.
- Requirement 3 read as "omits the value" rather than "takes it only finitely often": a strictly weaker conclusion.
- Requirement 5 with a bound other than two exceptional values.

### Domain-specific pitfalls for this problem

- For a *meromorphic* function, transcendental means not rational; the polynomial version of the condition is the entire-function notion and is too weak here.
- Being exceptional means being attained only finitely often, not being omitted.
- A meromorphic function represented as a total function $\mathbb{C} \to \mathbb{C}$ takes a default value at its poles, so any clause about the solution set of $f(z) = a$ must be read with that in mind.
- "At most two" is naturally written as containment in a two-element set, which correctly allows fewer than two exceptions.
