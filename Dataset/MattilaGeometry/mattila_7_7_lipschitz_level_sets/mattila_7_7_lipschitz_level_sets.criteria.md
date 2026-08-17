# Criteria: mattila_7_7_lipschitz_level_sets

**Statement:** [mattila_7_7_lipschitz_level_sets.md](mattila_7_7_lipschitz_level_sets.md) · **Lean:** [mattila_7_7_lipschitz_level_sets.lean](mattila_7_7_lipschitz_level_sets.lean) · **Context:** [mattila_7_7_lipschitz_level_sets.context.md](mattila_7_7_lipschitz_level_sets.context.md)

## What the theorem says

Let $f$ be a Lipschitz map from a set $A \subset \mathbb{R}^n$ into $\mathbb{R}^m$, and fix an
exponent $s$ with $m \le s \le n$. Slice $A$ by the level sets $A \cap f^{-1}\{y\}$, one for each
$y \in \mathbb{R}^m$. Each slice has an $(s-m)$-dimensional Hausdorff measure. The theorem says that
the total of these slice measures, integrated over $y$ against Lebesgue measure on $\mathbb{R}^m$, is
at most $\alpha(m)\,\mathrm{Lip}(f)^m\,\mathcal{H}^s(A)$, where $\alpha(m) = \mathcal{L}^m(B^m(0,1))$
is the Lebesgue measure of the unit ball of $\mathbb{R}^m$ — an explicit constant depending only on
$m$. This is an Eilenberg-type coarea inequality. The integral has
to be the *upper* integral, because the function $y \mapsto \mathcal{H}^{s-m}(A \cap f^{-1}\{y\})$ is
not known to be measurable.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The constant is the explicit $\alpha(m) = \mathcal{L}^m(B^m(0,1))$, the Lebesgue measure of the unit ball of $\mathbb{R}^m$ — a fixed quantity depending only on $m$, not an existentially quantified constant, and not depending on $n$, $s$, $A$, $f$ or the Lipschitz constant. | ✅ `volume (Metric.ball (0 : EuclideanSpace ℝ (Fin m)) 1)`, a closed term in `m` alone; there is no `∃ c` anywhere in the statement. |
| 2 | Both halves of the range condition $m \le s \le n$, with **non-strict** inequalities at both ends. | ✅ `(m : ℝ) ≤ s → s ≤ n → …`, two separate hypotheses of the implication. |
| 3 | $f$ is Lipschitz **on $A$**, not on all of $\mathbb{R}^n$. | ✅ `LipschitzOnWith K f A`, with `K` universally quantified so that every admissible Lipschitz constant gives a bound. |
| 4 | The integrand is the $(s-m)$-dimensional Hausdorff measure of the slice $A \cap f^{-1}\{y\}$, with $s-m$ the real difference. | ✅ `μH[s - m] (A ∩ f ⁻¹' {y})`. |
| 5 | The integral over $y$ is the **upper** integral $\int^{*}$: the infimum of $\int g$ over measurable functions $g$ lying above the integrand. | ✅ `upperIntegral volume (fun y ↦ …)`, where `upperIntegral μ f = ⨅ g, ⨅ (_ : Measurable g), ⨅ (_ : f ≤ g), ∫⁻ x, g x ∂μ` in `Defs.lean`. |
| 6 | The integration is against Lebesgue measure on $\mathbb{R}^m$. | ✅ `volume` on `EuclideanSpace ℝ (Fin m)`, which is Lebesgue measure there. |
| 7 | The right-hand side is $\alpha(m)$ $\times$ (Lipschitz constant)$^m$ $\times$ $\mathcal{H}^s(A)$. | ✅ `volume (Metric.ball (0 : EuclideanSpace ℝ (Fin m)) 1) * (K : ℝ≥0∞) ^ m * μH[s] A`, with the natural power `^ m`. |
| 8 | Nothing is assumed about the measurability of $A$; the text allows an arbitrary subset of $\mathbb{R}^n$. | ✅ `A : Set (EuclideanSpace ℝ (Fin n))` with no side condition; `μH[·]` is an outer measure, defined on all sets. |
| 9 | Everything is `ℝ≥0∞`-valued, since both the slice measures and $\mathcal{H}^s(A)$ can be $\infty$. | ✅ `upperIntegral`, `μH[s - m]`, `μH[s]` and the unit-ball volume all live in `ℝ≥0∞`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Using mathlib's `∫⁻ y, … ∂volume` in place of the upper integral. | `∫⁻` is the *lower* integral — the supremum of integrals of simple functions below the integrand. For a non-measurable integrand it can be strictly smaller than $\int^{*}$, so the inequality proved is weaker than the one printed. This is exactly why Mattila writes $\int^{*}$. |
| 2 | Using the Bochner integral `∫`. | It is real-valued and evaluates to the junk value $0$ whenever the integrand is not integrable — which is the interesting case here, since slice measures are routinely $\infty$. |
| 3 | Existentially quantifying the constant (`∃ c, …`, in any position) instead of writing $\alpha(m)$. | The text pins the constant down to the explicit $\alpha(m) = \mathcal{L}^m(B^m(0,1))$; replacing it by an unspecified constant is a strictly weaker theorem (Band D), wherever the quantifier sits. An earlier version of this problem's ground truth made exactly this mistake — and claimed the constant depends on both $n$ and $m$, when it depends on $m$ alone. |
| 4 | A constant that depends on $n$ — e.g. the unit-ball volume of $\mathbb{R}^n$, or an abstract $c(n,m)$. | The theorem's constant is $\alpha(m)$, uniform in the ambient dimension. With the wrong explicit ball the statement can even be false: the unit-ball volume is eventually decreasing in the dimension, so $\alpha(n) < \alpha(m)$ for many $n > m$. |
| 5 | Assuming `LipschitzWith K f`, i.e. Lipschitz on all of $\mathbb{R}^n$. | A strictly stronger hypothesis, hence a weaker theorem. The book only assumes $f$ is Lipschitz on $A$. |
| 6 | Integrating $\mathcal{H}^{s-m}(f^{-1}\{y\})$ without intersecting with $A$. | In Lean `f` is a total function whose values off $A$ are unconstrained junk; the intersection with $A$ is what neutralizes them. |
| 7 | Strictening the range to $m < s < n$, or dropping either bound. | Strictening a hypothesis gives a strictly weaker theorem: it silently drops the endpoint cases the book covers. The endpoint $s = m$ — where $\mathcal{H}^{0}$ counts the points of each slice — is precisely the case used for Lemma 18.4. An earlier version of this problem's ground truth made exactly this mistake. Dropping $m \le s$ instead lets the slice exponent $s - m$ go negative, which is not the printed theorem. |
| 8 | Adding a measurability hypothesis on the slice function, or on $A$. | That removes the difficulty the upper integral exists to handle, and it is not in the text. |

## Notes on the ground truth

- An earlier version of this statement used `∫⁻` (the lower integral). That was a genuine weakening
  of the printed inequality and has been repaired: the statement now uses `upperIntegral`, an
  infimum over measurable majorants. Candidates that reach for `∫⁻` are making the same mistake.
- The constant is encoded as `volume (Metric.ball (0 : EuclideanSpace ℝ (Fin m)) 1)` — the
  Lebesgue measure of the *open* unit ball of $\mathbb{R}^m$. The book's $B^m(0,1)$ is closed, but
  the boundary sphere is Lebesgue-null, so the two measures agree; a candidate using the closed
  ball, or any expression provably equal to $\alpha(m)$, loses nothing. An earlier version
  existentially quantified a finite `c` said to depend on `n` and `m`; that was a strictly weaker
  statement with the wrong claimed dependence and has been repaired.
- The range condition is two separate **non-strict** hypotheses, `(m : ℝ) ≤ s` and `s ≤ n` (with
  the natural-number bounds coerced to `ℝ`). An earlier version had strict inequalities, silently
  dropping the endpoint cases; that too has been repaired.
- The book writes $\mathrm{Lip}(f)^m$, the least Lipschitz constant. Quantifying over every `K` with
  `LipschitzOnWith K f A` is equivalent, since the right-hand side grows with `K`.
- $d\mathcal{L}^m y$ is Lebesgue measure on $\mathbb{R}^m$, i.e. `volume` on
  `EuclideanSpace ℝ (Fin m)`. Using `μH[(m:ℝ)]` on the target instead would change the bound by a
  dimensional constant, which the explicit $\alpha(m)$ cannot absorb — it is not a harmless variant
  here.
- The Lipschitz constant is raised to the natural power `^ m`.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[mattila_7_7_lipschitz_level_sets.md](mattila_7_7_lipschitz_level_sets.md) and the background in [mattila_7_7_lipschitz_level_sets.context.md](mattila_7_7_lipschitz_level_sets.context.md),
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

- Requirement 1 with a constant that depends on $s$, $A$, $f$ or the Lipschitz constant (e.g. a
  constant existentially quantified after them).
- Requirement 5 with an ordinary integral in place of the upper integral, or with a measurability hypothesis added to make one available.
- Requirement 7 with the power of $\mathrm{Lip}(f)$ other than $m$.

### Domain-specific pitfalls for this problem

- The upper integral is what makes the statement meaningful without measurability of the slice function; adding measurability changes the hypotheses.
- $f$ is Lipschitz on $A$ only.
- Both sides are extended-real valued and may be infinite.
- The constant is the explicit $\alpha(m) = \mathcal{L}^m(B^m(0,1))$, depending only on $m$ — not on $n$, and not an unspecified constant.
- The exponent range is $m \le s \le n$, inclusive at both endpoints.
- The slice is $A \cap f^{-1}\{y\}$ and is measured with $\mathcal{H}^{s-m}$.
