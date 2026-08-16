# Criteria: bogachev_gaussian_4_5_8_seminorm_concentration

**Statement:** [bogachev_gaussian_4_5_8_seminorm_concentration.md](bogachev_gaussian_4_5_8_seminorm_concentration.md) · **Lean:** [bogachev_gaussian_4_5_8_seminorm_concentration.lean](bogachev_gaussian_4_5_8_seminorm_concentration.lean) · **Context:** [bogachev_gaussian_4_5_8_seminorm_concentration.context.md](bogachev_gaussian_4_5_8_seminorm_concentration.context.md)

## What the theorem says

Let $\gamma$ be a Gaussian measure and let $f$ be a measurable seminorm on the space. Measure how
big $f$ can get on the Cameron–Martin unit ball: $\chi(f) = \sup\{f(h) : \lvert h\rvert_{H(\gamma)}
\le 1\}$. Then $f$ concentrates around its mean $\mathbb{E}f = \int f\,d\gamma$ at a Gaussian rate
controlled by $\chi(f)$ alone: for every $t \ge 0$,
$$\gamma\{x : \lvert f(x) - \mathbb{E}f\rvert > t\} \le 2\exp\!\left(-\tfrac{2}{\pi^2\chi(f)^2}t^2\right).$$
The dimension of the space plays no role — only $\chi(f)$ does.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $\gamma$ is a Gaussian measure on the ambient space. | ✅ `(γ : Measure E) [IsGaussian γ]` with a normed and Borel structure on `E`. |
| 2 | $f$ is a seminorm: subadditive and absolutely homogeneous. | ✅ `f : Seminorm ℝ E`, Mathlib's bundled structure. |
| 3 | $f$ is measurable. In infinite dimensions this is not automatic. | ✅ `hf : Measurable f`. |
| 4 | $\chi(f)$ is the supremum of $f$ over the *Cameron–Martin* unit ball $\{h : \lvert h\rvert_{H(\gamma)} \le 1\}$. | ✅ `cameronMartinGauge γ f = ⨆ h : {h // cameronMartinNorm γ h ≤ 1}, ENNReal.ofReal (f h)`. |
| 5 | The bound must not silently assume $\chi(f)$ is finite by converting it to a real number. | ✅ The gauge stays in `ℝ≥0∞` and is bounded above by a real `c` with `0 < c`, so no `toReal` appears and the infinite case simply makes the hypothesis unsatisfiable rather than the bound false. |
| 6 | The deviation is measured from the **mean** $\int f\,d\gamma$. | ✅ `∫ y, f y ∂γ` inside the absolute value. |
| 7 | The event is the strict inequality $\lvert f(x) - \mathbb{E}f\rvert > t$. | ✅ `{x \| t < \|f x - ∫ y, f y ∂γ\|}`. |
| 8 | The bound is $2\exp(-2t^2/(\pi^2\chi(f)^2))$ — factor $2$ in front, and the whole ratio inside the exponential. | ✅ `2 * ENNReal.ofReal (Real.exp (-(2 * t ^ 2 / (Real.pi ^ 2 * c ^ 2))))`. |
| 9 | $t$ is nonnegative. | ✅ `ht : 0 ≤ t`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Putting the division outside the exponential, e.g. $2\exp(-2t^2)/(\pi^2\chi(f)^2)$. | A completely different and false inequality. This is the easiest silent slip in this problem: the whole ratio $2t^2/(\pi^2\chi(f)^2)$ is the exponent. |
| 2 | Converting $\chi(f)$ to a real with `ENNReal.toReal` and dividing by it. | $\chi(f)$ really can be $+\infty$ — a seminorm need not be bounded on the Cameron–Martin ball. `toReal` sends $\infty$ to $0$, and then the exponent divides by zero, which Lean evaluates to $0$, so $\exp(0) = 1$ and the bound reads $\gamma(\dots) \le 2$: true for free, and not the theorem. |
| 3 | Dropping the requirement $t \ge 0$. | The statement becomes false. For $t < 0$ the event $\{t < \lvert f - \mathbb{E}f\rvert\}$ is the whole space, so the left side is $1$, while $2\exp(-2t^2/(\pi^2c^2)) \to 0$ as $t \to -\infty$. |
| 4 | Measuring deviation from the median instead of the mean. | A different theorem with a different (better) constant. Bogachev's $\pi^2/2$ goes with the mean. |
| 5 | Taking the supremum defining $\chi(f)$ over the unit ball of the ambient norm, or using an operator norm $\lVert f\rVert$. | The ambient unit ball is much bigger than the Cameron–Martin ball in infinite dimensions, so the constant is wrong (usually infinite) and the inequality asserted is not the printed one. |
| 6 | Replacing the seminorm by an arbitrary measurable convex function, or by an arbitrary Lipschitz function. | The constant $2/\pi^2$ is tied to seminorms. Dropping homogeneity or subadditivity makes the printed constant wrong. |
| 7 | Omitting the measurability hypothesis on $f$. | In infinite dimensions a seminorm need not be measurable, and then $\{x : \lvert f(x) - \mathbb{E}f\rvert > t\}$ and $\int f\,d\gamma$ are not the intended objects. |
| 8 | Dropping the factor $2$ in front of the exponential. | Halves the bound. The two-sided deviation costs a factor $2$; the one-sided bound is a different statement. |

## Notes on the ground truth

- Instead of writing $\chi(f)$ directly in the exponent, we quantify over a real number $c > 0$ with $\chi(f) \le c$ and put $c$ in the exponent. Because $x \mapsto 2\exp(-2t^2/(\pi^2 x^2))$ is increasing in $x$, this is equivalent to the printed bound, and it avoids any conversion from `ℝ≥0∞` to `ℝ`. It is slightly less literal than the book, which is why it is recorded here.
- `hgauge` together with `hc : 0 < c` implicitly rules out $\chi(f) = \infty$. That is the only case the printed inequality does not cover in a meaningful way, so nothing is lost.
- `∫ y, f y ∂γ` would be Lean's default value $0$ if $f$ were not integrable. That does not create a loophole: a seminorm with $\chi(f) < \infty$ is $\gamma$-integrable by Fernique's theorem, so the hypothesis `hgauge` already guarantees the mean is the real one. Bogachev makes the same point when he says $f$ satisfies condition (4.5.4).
- Bogachev's "$\gamma$-measurable seminorm" is only required to be defined almost everywhere. We use a genuine everywhere-defined `Seminorm ℝ E` together with a measurability hypothesis, which is a mild strengthening of the setup.
- The right-hand side is written in `ℝ≥0∞` via `ENNReal.ofReal`, matching the left-hand side's measure value, so no finiteness is presupposed anywhere.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[bogachev_gaussian_4_5_8_seminorm_concentration.md](bogachev_gaussian_4_5_8_seminorm_concentration.md) and the background in [bogachev_gaussian_4_5_8_seminorm_concentration.context.md](bogachev_gaussian_4_5_8_seminorm_concentration.context.md),
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

- $\chi(f)$ typed as a real number obtained by an `ℝ`-valued supremum: the gauge may be infinite, and an unbounded `sSup` in `ℝ` is the junk value `0`, which would make the bound assert something false.
- Replacing $\chi(f)$ by a norm of $f$ on $X$, or by $\mathbb{E}f$: a different quantity, and the inequality is then not the printed one.
- Dropping the seminorm structure and stating the bound for an arbitrary measurable function: false.

### Domain-specific pitfalls for this problem

- Junk value — supremum: the gauge must be taken in `ℝ≥0∞`. Bounding it above by a real constant $c$ with $0 < c$ and stating the inequality with $c$ is a faithful way to avoid extended arithmetic in the exponent.
- $\mathbb{E}f$ is a Bochner integral of a real function; it is finite here by Fernique's theorem, but the statement should not silently depend on the integral's default value.
- The measure of the deviation event lives in `ℝ≥0∞`, so the right-hand side must be coerced from `ℝ` by `ENNReal.ofReal`, which sends negatives to `0` — harmless for an exponential, but the coercion is where a sign error would hide.
- The event is the strict inequality $|f(x) - \mathbb{E}f| > t$, and both the factor $2$ in front and the constant $2/\pi^2$ in the exponent are as printed.
- A seminorm is subadditive and absolutely homogeneous but need not be continuous; assuming continuity narrows the example to a case where it is much easier.
