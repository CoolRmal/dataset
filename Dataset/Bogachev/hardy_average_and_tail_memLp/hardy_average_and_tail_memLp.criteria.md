# Criteria: hardy_average_and_tail_memLp

**Statement:** [hardy_average_and_tail_memLp.md](hardy_average_and_tail_memLp.md) · **Lean:** [hardy_average_and_tail_memLp.lean](hardy_average_and_tail_memLp.lean) · **Context:** [hardy_average_and_tail_memLp.context.md](hardy_average_and_tail_memLp.context.md)

## What the theorem says

Let $f$ lie in $L^p(0,\infty)$ with $p > 1$. Two new functions are built from it: the running
average $\varphi(x) = \frac{1}{x}\int_0^x f(t)\,dt$, and the weighted tail
$\psi(x) = \int_x^{\infty} f(t)/t\,dt$. The exercise asks to show that both of them again belong to
$L^p(0,\infty)$. This is Hardy's inequality and its dual, stated as a membership claim: no explicit
constant is requested.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The exponent satisfies $p > 1$ strictly. | ✅ `hp : 1 < p` with `p : ℝ`. |
| 2 | The hypothesis is $f \in L^p$ on the half-line $(0,\infty)$, not on all of $\mathbb{R}$. | ✅ `hf : MemLp f (ENNReal.ofReal p) (volume.restrict (Ioi (0 : ℝ)))`. |
| 3 | $\varphi(x)$ is $1/x$ times the integral of $f$ from $0$ to $x$. | ✅ `fun x ↦ (1 / x) * ∫ t in (0 : ℝ)..x, f t ∂volume`. |
| 4 | $\psi(x)$ is the integral of $f(t)/t$ over $(x,\infty)$. | ✅ `fun x ↦ ∫ t in Ioi x, f t / t ∂volume`. |
| 5 | The conclusion asserts $L^p$ membership of $\varphi$ on $(0,\infty)$, measured with the same exponent and the same restricted measure. | ✅ First conjunct, `MemLp … (ENNReal.ofReal p) (volume.restrict (Ioi (0 : ℝ)))`. |
| 6 | The conclusion asserts $L^p$ membership of $\psi$ as well. | ✅ Second conjunct, same exponent and measure. |
| 7 | Both claims are made at once, as a conjunction. | ✅ The theorem's statement is `… ∧ …`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Assuming $1 \le p$ instead of $1 < p$. | False at $p = 1$: for $f$ the indicator of $(0,1)$, which is in $L^1(0,\infty)$, the average is $\varphi(x) = 1/x$ for $x > 1$, and that is not integrable on $(1,\infty)$. |
| 2 | Formalizing only $\varphi$ and dropping $\psi$. | Half the exercise. The two operators are different and neither implies the other. |
| 3 | Adding the norm bound $\lVert \varphi\rVert_p \le \frac{p}{p-1}\lVert f\rVert_p$. | A strictly stronger statement than the one asked for. The exercise asks only for membership. |
| 4 | Expressing $L^p$ membership as `Integrable (fun x ↦ \|f x\| ^ p)`. | That drops the measurability half of the definition of $L^p$, so it is a different condition, and in the hypothesis position it makes the theorem stronger than intended. |
| 5 | Working over all of $\mathbb{R}$ instead of the half-line. | $\psi$ diverges for $x \le 0$ in general, and the exercise is explicitly about $L^p(0,\infty)$. |
| 6 | Writing the average as $\int_0^x f$ without the factor $1/x$, or the tail as $\int_x^\infty f$ without the weight $1/t$. | Different operators, and both altered claims are false. |
| 7 | Taking $p$ in `ℝ≥0∞` with `1 < p` and nothing ruling out $p = \infty$. | At $p = \infty$ the constant $f \equiv 1$ is admissible, and then $\psi(x) = \int_x^\infty dt/t$ diverges for every $x > 0$, so $\psi$ is not even defined. A real exponent with `1 < p` sidesteps the corner case. |

## Notes on the ground truth

- $L^p(0,\infty)$ is encoded by keeping `f : ℝ → ℝ` a total function and restricting the *measure*:
  `volume.restrict (Ioi 0)`. This is Mathlib's usual way to state one-sided results and avoids a
  subtype domain, which fights the `MemLp` API.
- Both defining integrals are genuinely convergent under the hypotheses, so no Bochner integral is
  quietly defaulting to $0$. For $\varphi$: on the finite interval $(0,x)$, Hölder's inequality
  turns $f \in L^p$ into $f \in L^1$. For $\psi$: on $(x,\infty)$ with $x > 0$, the weight $1/t$ lies
  in $L^{p'}$ where $p' = p/(p-1) > 1$, so Hölder again makes $f(t)/t$ integrable.
- The junk value `1 / 0 = 0` in Lean is invisible here: `MemLp` is measured against a measure
  supported on $(0,\infty)$, and the point $x = 0$ carries no mass. Likewise the values of $f$
  outside $(0,\infty)$ never enter, because `Ioi x` for $x > 0$ stays inside the half-line.
- $\int_0^x$ is written as an interval integral and $\int_x^\infty$ as a set integral over `Ioi x`.
  Endpoints carry no mass, so a candidate using `Icc 0 x` or `Ici x` is equivalent, not worse.
- The exponent is lifted with `ENNReal.ofReal p`, which for `1 < p` is finite and larger than 1, as
  `MemLp` expects.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[hardy_average_and_tail_memLp.md](hardy_average_and_tail_memLp.md) and the background in [hardy_average_and_tail_memLp.context.md](hardy_average_and_tail_memLp.context.md),
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

- Requirement 1 weakened to $1 \le p$, or an exponent typed so that $p = \infty$ is admissible: the statement is then false, with the counterexamples above.
- Requirement 2 or 5–6 stated over $\mathbb{R}$ rather than $(0,\infty)$: $\psi$ is not defined for $x \le 0$ and the claim is not the exercise's.

### Domain-specific pitfalls for this problem

- Junk value — Bochner integral: both $\varphi$ and $\psi$ are defined by Bochner integrals, which return `0` on a non-integrable integrand. Convergence of these integrals is part of what must be true, so a candidate must not rely on the default to make the claim come out right.
- Junk value — division: $1/x$ at $x=0$ is `0` in Lean. It is harmless only because the measure is restricted to the *open* half-line, where $x>0$.
- $L^p$ membership must be `MemLp f p μ`, which carries a.e.-strong-measurability as well as finiteness of the norm; `Integrable (fun x ↦ |f x| ^ p)` drops the measurability half and is a different condition.
- The exponent must be transported into `ℝ≥0∞` in a way that preserves $1 < p < \infty$; `ENNReal.ofReal p` for real $p > 1$ does that, while an `ℝ≥0∞`-valued `p` with only `1 < p` admits `p = ∞`.
- Both conjuncts are required; the two operators are different and neither claim implies the other.
