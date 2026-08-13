# Criteria: hayman_3_4_derivative_deficiency_bound

**Statement:** [hayman_3_4_derivative_deficiency_bound.md](hayman_3_4_derivative_deficiency_bound.md) · **Lean:** [hayman_3_4_derivative_deficiency_bound.lean](hayman_3_4_derivative_deficiency_bound.lean)

## What the theorem says

Nevanlinna's deficiency relation (Theorem 2.4) says that for any meromorphic function the total
$\sum_a \Theta(a)$ over all values, including $a = \infty$, is at most $2$. This theorem says that if
you differentiate — take $\psi = f^{(l)}$ for some $l \ge 1$ and $f$ transcendental meromorphic in
the plane — then the *finite* values alone carry at most $1 + \frac{1}{l+1}$. The missing amount is
absorbed at $\infty$: differentiating $l$ times makes poles very deficient. As a consequence, $\psi$
takes every finite value infinitely often, with at most one exception.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $f$ is meromorphic on the whole plane. | ✅ `hf : Meromorphic f`. |
| 2 | $f$ is transcendental, i.e. not a rational function. | ⚠️ `htr` says there is no pair of polynomials $p,q$ with $f = p/q$ off the zeros of $q$. See the notes: as written this hypothesis is never satisfiable. |
| 3 | The order of differentiation is at least $1$. | ✅ `l : ℕ` with `hl : 1 ≤ l`. |
| 4 | $\psi$ is the $l$-th derivative of $f$. | ✅ `hψ : ψ = iteratedDeriv l f`. |
| 5 | $\Theta(a,\psi)$ is Nevanlinna's $1 - \limsup_{r\to\infty} \bar N(r,a)/T(r)$, computed for $\psi$, using the reduced counting function. | ✅ `nevanlinnaTheta ψ a`, from `Defs.lean`. |
| 6 | The sum is over finite values only; $a = \infty$ is excluded. | ✅ `∑ a ∈ s` with `s : Finset ℂ`, so only complex values appear. |
| 7 | The bound on the sum is exactly $1 + \frac{1}{l+1}$, and it depends on $l$. | ✅ `≤ 1 + 1 / (l + 1 : ℝ)`, with `l` the same natural number as in `hψ`. |
| 8 | A sum over a possibly infinite value set needs a convergence-free meaning. | ✅ Every finite subset satisfies the bound: `∀ s : Finset ℂ, …`. Since each $\Theta \ge 0$ this is equivalent to the sum bound. |
| 9 | The "in particular" clause: the set of finite values $\psi$ takes only finitely often has at most one element. | ✅ Second conjunct, `{a : ℂ \| ¬ {z : ℂ \| ψ z = a}.Infinite}.Subsingleton`. |

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

## Notes on the ground truth

- **`htr` is unsatisfiable as written, so the theorem is empty.** The hypothesis is
  `¬ ∃ p q : Polynomial ℂ, ∀ z, q.eval z ≠ 0 → f z = p.eval z / q.eval z`. Taking $q = 0$ makes
  `q.eval z ≠ 0` false for every $z$, so the implication holds everywhere and the inner existential
  is true for *every* $f$; hence `htr` is false for every $f$. Requiring `q ≠ 0` inside the
  existential repairs it. A candidate that includes `q ≠ 0` is better here, not worse.
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
- Mathlib models meromorphic functions as ordinary functions with a value at each pole, so the set
  `{z \| ψ z = a}` may include an accidental hit at a pole of $\psi$. Extra points only make the set
  larger, so the "infinitely often" conclusion is not weakened by this.
