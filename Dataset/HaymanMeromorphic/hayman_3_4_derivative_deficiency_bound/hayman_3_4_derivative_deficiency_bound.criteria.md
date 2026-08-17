# Criteria: hayman_3_4_derivative_deficiency_bound

**Statement:** [hayman_3_4_derivative_deficiency_bound.md](hayman_3_4_derivative_deficiency_bound.md) · **Lean:** [hayman_3_4_derivative_deficiency_bound.lean](hayman_3_4_derivative_deficiency_bound.lean) · **Context:** [hayman_3_4_derivative_deficiency_bound.context.md](hayman_3_4_derivative_deficiency_bound.context.md)

## What the theorem says

Nevanlinna's deficiency relation (Theorem 2.4) says that for any meromorphic function the total
$\sum_a \Theta(a)$ over all values, including $a = \infty$, is at most $2$. This theorem says that if
you differentiate — take $\psi = f^{(l)}$ for some $l \ge 1$ and $f$ transcendental meromorphic in
the plane — then the *finite* values alone carry at most $1 + \frac{1}{l+1}$. The missing amount is
absorbed at $\infty$: differentiating $l$ times makes poles very deficient. As a consequence, $\psi$
takes every finite value infinitely often, with at most one exception.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $f$ is meromorphic on the whole plane. | ✅ `hf : Meromorphic f`. |
| 2 | $f$ is transcendental, i.e. not a rational function. | ✅ `htr : ¬ ∃ p q : Polynomial ℂ, q ≠ 0 ∧ ∀ z, q.eval z ≠ 0 → f z = p.eval z / q.eval z`. The `q ≠ 0` conjunct is essential: without it $q = 0$ makes the guard `q.eval z ≠ 0` false everywhere, the inner existential true for every `f`, and the hypothesis unsatisfiable. |
| 3 | The order of differentiation is at least $1$. | ✅ `l : ℕ` with `hl : 1 ≤ l`. |
| 4 | $\psi$ is the $l$-th derivative of $f$. | ✅ `hψ : ψ = iteratedDeriv l f`. |
| 5 | $\Theta(a,\psi)$ is Nevanlinna's $1 - \limsup_{r\to\infty} \bar N(r,a)/T(r)$, computed for $\psi$, using the reduced counting function. | ✅ `nevanlinnaTheta ψ a`, from `Defs.lean`. |
| 6 | The sum is over finite values only; $a = \infty$ is excluded. | ✅ `∑ a ∈ s` with `s : Finset ℂ`, so only complex values appear. |
| 7 | The bound on the sum is exactly $1 + \frac{1}{l+1}$, and it depends on $l$. | ✅ `≤ 1 + 1 / (l + 1 : ℝ)`, with `l` the same natural number as in `hψ`. |
| 8 | A sum over a possibly infinite value set needs a convergence-free meaning. | ✅ Every finite subset satisfies the bound: `∀ s : Finset ℂ, …`. Since each $\Theta \ge 0$ this is equivalent to the sum bound. |
| 9 | The "in particular" clause: the set of finite values $\psi$ takes only finitely often has at most one element. | ✅ Second conjunct, `{a : ℂ \| ¬ {z : ℂ \| 0 < meromorphicOrderAt (fun w ↦ ψ w - a) z}.Infinite}.Subsingleton` — an $a$-point of $\psi$ is a point where $\psi - a$ has positive meromorphic order, the representative-independent reading. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Using the bound $2$ instead of $1 + \frac{1}{l+1}$. | This is the highest-value trap. The bound $2$ is just Theorem 2.4 applied to $\psi$ and carries none of the content. The improvement measures exactly how much deficiency differentiating moves to $\infty$; it is sharp, as $f = \tan z$ with $l = 1$ shows. |
| 2 | Letting the constant be "some constant $C$" rather than the explicit $1 + \frac{1}{l+1}$. | Much weaker, and the explicit dependence on $l$ is the point of the theorem. |
| 3 | Summing over all values including $a = \infty$. | The bound becomes false: $\Theta(\infty,\psi) \ge \frac{l}{l+1}$, and adding that to $1 + \frac{1}{l+1}$ overshoots. Hayman writes the sum as $\sum_{a \ne \infty}$ for exactly this reason. |
| 4 | Allowing $l = 0$. | Then $\psi = f$, the constant degrades to $2$ (no content beyond Theorem 2.4), and the second conjunct becomes false: $f(z) = 1/(1+e^{z})$ is transcendental meromorphic and never takes either of the two finite values $0$ and $1$, so its exceptional set has two elements, not at most one. |
| 5 | Keeping only the inequality and dropping the "in particular" clause. | The second conjunct is a separate assertion, and it is the form in which the theorem is normally applied. |
| 6 | Keeping only the "in particular" clause and dropping the inequality. | The inequality is the quantitative statement; the clause about exceptional values is a consequence of it. |
| 7 | Replacing "takes the value infinitely often" by "takes the value at least once". | Strictly weaker; the theorem gives infinitude. |
| 8 | Dropping the transcendence hypothesis. | For a rational $f$, all the Nevanlinna ratios degenerate and $\psi$ can omit values freely. Transcendence is what makes $T(r,\psi)\to\infty$. |
| 9 | Reading "$\psi$ takes the value $a$" as the literal `ψ z = a` of the total-function representative. | Mathlib's `Meromorphic` leaves the values of `f` — and hence of `ψ = iteratedDeriv l f`, which junk-vanishes at discontinuity points — unconstrained on discrete sets. Tampering the representative of `f` at the $a$-points of $f^{(l)}$ hides them, drives `nevanlinnaTheta ψ a` to $1$ for several values and manufactures several exceptional values, refuting both conjuncts. An earlier version of the ground truth had exactly this defect in the second conjunct; the current one incorporates the repair by counting $a$-points through positive `meromorphicOrderAt`. |

## Notes on the ground truth

- The `q ≠ 0` conjunct in `htr` is load-bearing. Without it, $q = 0$ makes the guard
  `q.eval z ≠ 0` false for every $z$, the inner existential holds for *every* $f$, and the
  hypothesis is unsatisfiable — the theorem would be empty. Non-rationality must be stated in a form
  the zero denominator cannot satisfy, exactly as the ground truth does.
- $\psi$ is introduced as a separate variable pinned down by `hψ : ψ = iteratedDeriv l f`, so that
  the statement reads like the book. Inlining `iteratedDeriv l f` would say the same thing with one
  fewer hypothesis.
- `1 / (l + 1 : ℝ)` coerces `l` to a real before adding, so the constant is genuinely
  $1 + 1/(l+1)$ and not a truncated natural-number division.
- `nevanlinnaTheta` is a `limsup` of a ratio of a `reducedLogCounting` to a `characteristic`.
  `reducedLogCounting` is an integral of a `Set.ncard`; Lean gives an infinite set the count $0$ and
  a non-integrable integrand the integral $0$, and `limsup` of an unbounded family falls back to a
  default. None of these fire for a transcendental meromorphic $f$, but a candidate should not lean
  on that silently.
- Mathlib models meromorphic functions as ordinary functions whose values on discrete sets carry no
  meaning, so the second conjunct counts $a$-points of $\psi$ by positive `meromorphicOrderAt` of
  $\psi - a$ rather than by the literal equation `ψ z = a`. Positive order excludes both deleted
  $a$-points at tampered/discontinuity points and spurious literal hits at poles, so the
  "infinitely often" clause measures the meromorphic function itself.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[hayman_3_4_derivative_deficiency_bound.md](hayman_3_4_derivative_deficiency_bound.md) and the background in [hayman_3_4_derivative_deficiency_bound.context.md](hayman_3_4_derivative_deficiency_bound.context.md),
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

- Requirement 6 with $a = \infty$ included in the sum: the bound is then false.
- Requirement 7 with the bound $2$ (Theorem 2.4's) instead of $1 + \frac{1}{l+1}$.
- Requirement 2 read as "not a polynomial".

### Domain-specific pitfalls for this problem

- The sum runs over finite values only; the improvement over Theorem 2.4 depends on excluding the pole deficiency.
- $\Theta$ is built from the *reduced* counting function $\bar N$.
- Junk value — `tsum`: quantifying over all finite subsums avoids an unordered sum over an uncountable index.
- The "in particular" clause is a second assertion and models routinely omit it.
- The bound depends on $l$ and requires $l \ge 1$.
- Junk value — representatives: "$\psi$ takes the value $a$" must be read through the germ (positive order of $\psi - a$), not through the literal values of the chosen representative, which are unconstrained on discrete sets.
