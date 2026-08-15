# Criteria: grafakos_2_1_6_hardy_littlewood_maximal

**Statement:** [grafakos_2_1_6_hardy_littlewood_maximal.md](grafakos_2_1_6_hardy_littlewood_maximal.md) · **Lean:** [grafakos_2_1_6_hardy_littlewood_maximal.lean](grafakos_2_1_6_hardy_littlewood_maximal.lean) · **Context:** [grafakos_2_1_6_hardy_littlewood_maximal.context.md](grafakos_2_1_6_hardy_littlewood_maximal.context.md)

## What the theorem says

The Hardy–Littlewood maximal function of $f$ at a point $x$ is the largest average of $\lvert f\rvert$
over a ball. There are two versions: the *uncentered* $M$, which takes the supremum over all balls
containing $x$, and the *centered* $M^c$, which uses only balls with centre $x$. The theorem says
both operators are bounded from $L^1$ into weak-$L^1$ with constant $3^n$, and bounded on $L^p$ for
$1 < p < \infty$ with constant $3^{n/p}p/(p-1)$. It also records a sharper local statement: the
measure of the set where $Mf$ exceeds $\alpha$ is at most $3^n/\alpha$ times the integral of
$\lvert f\rvert$ *over that same set*.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The uncentered operator is the supremum of the averages over all balls that *contain* $x$, not just balls centred at $x$. | ✅ `hardyLittlewoodMaximal n f x = ⨆ y, ⨆ r : {r : ℝ // 0 < r}, ⨆ (_ : x ∈ ball y r), (∫⁻ z in ball y r, ‖f z‖ₑ) / volume (ball y r)`; the `⨆ (_ : x ∈ ball y r)` guard contributes `0` when `x ∉ ball y r`, so only balls containing `x` count. |
| 2 | The centered operator is the supremum of the averages over balls centred at $x$. | ✅ `hardyLittlewoodCenteredMaximal n f x = ⨆ r : {r : ℝ // 0 < r}, (∫⁻ z in ball x r, ‖f z‖ₑ) / volume (ball x r)`. |
| 3 | Every claim is made for *both* operators. | ✅ `let operators := ({hardyLittlewoodMaximal n, hardyLittlewoodCenteredMaximal n} : Set _)` together with `∀ M ∈ operators, …` in both conjuncts. |
| 4 | The maximal function is defined for every $f$, with no integrability side condition, and is allowed to take the value $+\infty$. | ✅ Averages are `(∫⁻ z in ball y r, ‖f z‖ₑ) / volume (ball y r)` in `ℝ≥0∞`; the lower Lebesgue integral is defined for any $f$, and `volume (ball y r)` is finite and nonzero for $r > 0$, so the division is honest. |
| 5 | The local estimate: for $f \in L^1$ and every $\alpha > 0$, the measure of the set where $Mf$ is strictly above $\alpha$ is at most $3^n/\alpha$ times the integral of $\lvert f\rvert$ over that set. | ✅ `volume {x \| ENNReal.ofReal α < M f x} ≤ ENNReal.ofReal (3 ^ n / α) * ∫⁻ x in {x \| ENNReal.ofReal α < M f x}, ‖f x‖ₑ`, under `MemLp f 1 volume` and `0 < α`. |
| 6 | The strong bound: for $1 < p < \infty$ and $f \in L^p$, the $L^p$ norm of $Mf$ is at most $3^{n/p}\,p/(p-1)$ times $\|f\|_p$. | ✅ `ENNReal.rpow (∫⁻ x, ENNReal.rpow (M f x) p) (1 / p) ≤ ENNReal.ofReal (3 ^ ((n : ℝ) / p) * p / (p - 1)) * eLpNorm f (ENNReal.ofReal p) volume`, with `1 < p` so `p - 1 ≠ 0`. |
| 7 | The named weak $(1,1)$ bound, $\alpha\,\lvert\{Mf>\alpha\}\rvert \le 3^n\|f\|_1$. | ✅ A second conjunct, stated for both operators alongside the sharper local estimate. |
| 8 | The constants are the explicit ones, $3^n$ and $3^{n/p}p/(p-1)$, not unspecified constants. | ✅ `ENNReal.ofReal (3 ^ n / α)` and `ENNReal.ofReal (3 ^ ((n : ℝ) / p) * p / (p - 1))`; the exponent `(n : ℝ) / p` is a real power, correctly giving $3^{n/p}$. |
| 9 | "Ball" means a Euclidean ball and the measure is $n$-dimensional Lebesgue measure. | ✅ The space is `EuclideanSpace ℝ (Fin n)`, so `Metric.ball` is a round ball and `volume` is Lebesgue measure. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Formalizing only one of the two operators. | The theorem is stated for both, and the covering argument applies directly only to the uncentered one; the centered case is deduced. Stating one leaves out half the result. |
| 2 | Defining the uncentered operator with balls centred at $x$, or with cubes. | Those are different operators. The cube version is comparable but the constant $3^n$ is then no longer the printed one. |
| 3 | Defining the averages with a Bochner integral, e.g. `(∫ z in ball y r, ‖f z‖) / (volume (ball y r)).toReal`. | Lean gives a Bochner integral of a non-integrable function the value `0`. So the average would read as `0` on exactly the balls where $f$ is large, which is where the maximal function gets its value. |
| 4 | Using constant $3^n$ in the strong bound instead of $3^{n/p}$. | A different, larger constant for $p$ close to $1$ and smaller for large $p$; either way it is not the printed inequality. The Marcinkiewicz-derived constant $2\big(\tfrac{p}{p-1}\big)^{1/p}3^{n/p}$ is likewise not what 2.1.6 claims. |
| 5 | Allowing $p = 1$ in the strong bound, or asserting a strong $(1,1)$ bound. | False. For $f$ integrable and not zero, $Mf$ decays like $\lvert x\rvert^{-n}$ at infinity and is never integrable. |
| 6 | Replacing the constants by `∃ C, …`. | Theorem 2.1.6 is quantitative; the named constants are what is being asserted. |
| 7 | Writing the level set with `≤`, as $\{Mf \ge \alpha\}$. | Grafakos's distribution function uses the strict inequality. The closed set is larger, so the inequality asserted is stronger than the printed one. |
| 8 | Working on `Fin n → ℝ` instead of `EuclideanSpace ℝ (Fin n)`. | On `Fin n → ℝ` Mathlib's `Metric.ball` is a sup-norm ball, i.e. a cube. The operator is comparable but not equal, and the constant $3^n$ is tied to round balls. |

## Notes on the ground truth

- This Mathlib has no Hardy–Littlewood maximal operator, so both maximal functions are defined in
  `Defs.lean`. That is justified rather than a pointless wrapper.
- The $L^p$ norm on the left of the strong bound is written out as
  `(∫⁻ x, (M f x) ^ p) ^ (1/p)` because $Mf$ takes values in `ℝ≥0∞`. Mathlib has an `ENorm ℝ≥0∞`
  instance with `‖x‖ₑ = x`, so `eLpNorm (M f) (ENNReal.ofReal p) volume` is the same thing and is
  more idiomatic; both should be accepted.
- Collecting the two operators into a two-element `Set` and quantifying with `∀ M ∈ operators` is
  compact but unusual. Two separate conjunctions, or two theorems, would read better and would not
  need `Set.mem_insert_iff` to unfold.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[grafakos_2_1_6_hardy_littlewood_maximal.md](grafakos_2_1_6_hardy_littlewood_maximal.md) and the background in [grafakos_2_1_6_hardy_littlewood_maximal.context.md](grafakos_2_1_6_hardy_littlewood_maximal.context.md),
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

- Requirement 1 or 2 with the two operators confused, or with the claims made for only one of them.
- Requirement 8 with the explicit constants replaced by unspecified ones.
- Requirement 4 with an integrability side condition imposed so that the maximal function is defined only for good $f$.

### Domain-specific pitfalls for this problem

- Junk value — supremum: the maximal function must take values in `ℝ≥0∞`. A real-valued `sSup` over an unbounded family is `0`, which would make $Mf$ vanish exactly where it is largest.
- The uncentred operator ranges over balls *containing* $x$, not centred at $x$; conflating the two loses one of the two claims.
- The averages are $\frac{1}{|B|}\int_B|f|$, so the division is in `ℝ≥0∞`; the ball has positive finite measure for $r>0$, so no division by $0$ or $\infty$ occurs.
- The displayed local estimate integrates $|f|$ only over the level set $\{Mf>\alpha\}$ and is strictly stronger than weak $(1,1)$; both are printed.
- "Ball" is the Euclidean ball, so the ambient space must carry the Euclidean norm.
