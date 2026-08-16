# Criteria: mattila_6_2_hausdorff_density_estimates

**Statement:** [mattila_6_2_hausdorff_density_estimates.md](mattila_6_2_hausdorff_density_estimates.md) · **Lean:** [mattila_6_2_hausdorff_density_estimates.lean](mattila_6_2_hausdorff_density_estimates.lean) · **Context:** [mattila_6_2_hausdorff_density_estimates.context.md](mattila_6_2_hausdorff_density_estimates.context.md)

## What the theorem says

Take a set $A$ in $\mathbb{R}^n$ whose $s$-dimensional Hausdorff measure is finite. Look at small
balls around a point $x$ and compare the amount of $A$ inside the ball with the size $(2r)^s$ that a
truly $s$-dimensional set would have; the $\limsup$ of that ratio as $r \downarrow 0$ is the upper
$s$-density $\Theta^{*s}(A,x)$. The theorem says two things. At almost every point of $A$ the upper
density sits between $2^{-s}$ and $1$ — so $A$ is neither much thinner nor much thicker than
$s$-dimensional at almost all of its own points. And if $A$ is measurable, then at almost every point
outside $A$ the upper density is $0$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $A$ is an arbitrary subset of $\mathbb{R}^n$; part (1) assumes nothing about its measurability. | ✅ `{A : Set (EuclideanSpace ℝ (Fin n))}` with no measurability binder. |
| 2 | The hypothesis $\mathcal{H}^s(A) < \infty$. | ✅ `hA : μH[s] A < ∞`. |
| 3 | The upper density is the $\limsup$ as $r \downarrow 0$ of $\mathcal{H}^s(A \cap \bar B(x,r))$ divided by $(2r)^s$. | ✅ `upperHausdorffDensity` in `Defs.lean`: `limsup (fun r ↦ μH[s] (A ∩ closedBall x r) / ENNReal.ofReal ((2 * r) ^ s)) (𝓝[>] 0)`. |
| 4 | Part (1) asserts the lower bound $2^{-s} \le \Theta^{*s}(A,x)$. | ✅ `ENNReal.ofReal (2 ^ (-s)) ≤ upperHausdorffDensity s A x`. |
| 5 | Part (1) asserts the upper bound $\Theta^{*s}(A,x) \le 1$. | ✅ `upperHausdorffDensity s A x ≤ 1`, in the same conjunction. |
| 6 | "For $\mathcal{H}^s$ almost all $x \in A$" must mean that the bad points inside $A$ form an $\mathcal{H}^s$-null set, without assuming $A$ measurable. | ✅ `∀ᵐ x ∂μH[s], x ∈ A → …`, which unfolds to `μH[s] {x \| x ∈ A ∧ ¬ P x} = 0`. |
| 7 | Measurability of $A$ is a hypothesis of part (2) only, so it must appear as an implication inside the second conjunct, not in the binder list. | ✅ `(NullMeasurableSet A μH[s] → ∀ᵐ x ∂μH[s], …)`, with Carathéodory measurability as the book intends. |
| 8 | Part (2) says the density vanishes at almost every point **outside** $A$, and both parts are asserted together. | ✅ `∀ᵐ x ∂μH[s], x ∉ A → upperHausdorffDensity s A x = 0`, joined to part (1) by `∧`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Dividing by $r^s$ instead of $(2r)^s$ while keeping the constants $2^{-s}$ and $1$. | That rescales the density by $2^s$, so the true bounds become $1 \le \Theta \le 2^s$. The stated inequality would then be false. |
| 2 | Using a normalized Hausdorff measure (one carrying Federer's $\alpha(s)/2^s$ factor). | The constants $2^{-s}$ and $1$ belong to the unnormalized $\mathcal{H}^s = \inf \sum d(E_i)^s$, which is what `μH[s]` is. Any other normalization changes both bounds. |
| 3 | Writing "almost all $x \in A$" as `∀ᵐ x ∂(μH[s].restrict A)` without assuming $A$ measurable. | `Measure.restrict` only computes as `μ (S ∩ A)` when `A` is measurable; without that hypothesis the restricted measure is not the intended one. |
| 4 | Moving `MeasurableSet A` into the theorem's binder list. | Part (1) is stated for arbitrary $A$. Assuming measurability everywhere weakens it. |
| 5 | Defining the upper density with `Tendsto` or with a `liminf`. | The limit need not exist, so `Tendsto` asserts something extra; `liminf` is the *lower* density, and the bound $2^{-s} \le \Theta_*^s$ is false in general. |
| 6 | Making the density a real number, e.g. via `ENNReal.toReal`. | The ratio can be $\infty$, and `toReal` sends $\infty$ to $0$, which would make the lower bound fail for a spurious reason. |
| 7 | Keeping only $\Theta^{*s}(A,x) \le 1$ and dropping the lower bound, or dropping part (2). | Each is a separate assertion of the theorem; the lower bound is the harder half. |
| 8 | Dropping the `x ∉ A` guard in part (2). | Then it would say the density is $0$ almost everywhere, which directly contradicts part (1). |

## Notes on the ground truth

- The `limsup` is taken in `ℝ≥0∞`, where it always exists, so there is no "the limit may fail to
  exist" gap. For `r > 0` the denominator `ENNReal.ofReal ((2 * r) ^ s)` is positive and finite, so
  the ratio is never `0/0` or `∞/∞`. The filter `𝓝[>] 0` never sees `r ≤ 0`, where `(2*r)^s` is a
  junk value of `Real.rpow`.
- `closedBall` matches Mattila's convention that $B(x,r)$ is closed. Using `Metric.ball` would give
  the same `limsup` value, but it is a needless departure from the text.
- `2 ^ (-s)` is `Real.rpow`, moved into `ℝ≥0∞` by `ENNReal.ofReal`, the correct coercion of a
  positive real.
- **Deliberate departure.** `hs : 0 < s` is our addition; the text does not state it. It is a harmless narrowing (at
  $s = 0$ the bounds read $1 \le \Theta \le 1$ for counting measure), but it is not in the source.
- Part (2) uses Carathéodory $\mathcal{H}^s$-measurability, matching the book.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[mattila_6_2_hausdorff_density_estimates.md](mattila_6_2_hausdorff_density_estimates.md) and the background in [mattila_6_2_hausdorff_density_estimates.context.md](mattila_6_2_hausdorff_density_estimates.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 8 rows, so each row is worth 6.2 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 7 with measurability of $A$ made a standing hypothesis rather than a hypothesis of part (2).
- Requirement 3 with a genuine limit or a lower density in place of the $\limsup$, or with $r^s$ in place of $(2r)^s$.
- Requirement 8 with part (2) stated about points of $A$ rather than of its complement.

### Domain-specific pitfalls for this problem

- The normalization is by the diameter $(2r)^s$, which is where the constant $2^{-s}$ comes from.
- Part (1) holds for an arbitrary set; only part (2) needs measurability.
- "Almost all $x \in A$" restricts the Hausdorff measure to $A$; part (2)'s "almost all $x \notin A$" restricts it to the complement.
- Both bounds of part (1) are asserted.
- Densities live in $[0,\infty]$.
