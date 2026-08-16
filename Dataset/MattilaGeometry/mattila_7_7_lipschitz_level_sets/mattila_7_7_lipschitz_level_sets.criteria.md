# Criteria: mattila_7_7_lipschitz_level_sets

**Statement:** [mattila_7_7_lipschitz_level_sets.md](mattila_7_7_lipschitz_level_sets.md) · **Lean:** [mattila_7_7_lipschitz_level_sets.lean](mattila_7_7_lipschitz_level_sets.lean) · **Context:** [mattila_7_7_lipschitz_level_sets.context.md](mattila_7_7_lipschitz_level_sets.context.md)

## What the theorem says

Let $f$ be a Lipschitz map from a set $A \subset \mathbb{R}^n$ into $\mathbb{R}^m$, and fix an
exponent $s$ with $m < s < n$. Slice $A$ by the level sets $A \cap f^{-1}\{y\}$, one for each
$y \in \mathbb{R}^m$. Each slice has an $(s-m)$-dimensional Hausdorff measure. The theorem says that
the total of these slice measures, integrated over $y$ against Lebesgue measure on $\mathbb{R}^m$, is
at most a constant times $\mathrm{Lip}(f)^m$ times $\mathcal{H}^s(A)$, where the constant depends
only on the two dimensions $n$ and $m$. This is an Eilenberg-type coarea inequality. The integral has
to be the *upper* integral, because the function $y \mapsto \mathcal{H}^{s-m}(A \cap f^{-1}\{y\})$ is
not known to be measurable.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The constant depends on $n$ and $m$ only, so it must be quantified before $s$, $A$, $f$ and the Lipschitz constant, and it must be finite. | ✅ `∃ c : ℝ≥0∞, c < ∞ ∧ ∀ (s : ℝ) (A) (f) (K : ℝ≥0), …`, with `n m` implicit in the theorem's binders. |
| 2 | Both halves of the range condition $m < s < n$. | ✅ `(m : ℝ) < s ∧ s < n` as a hypothesis of the inner implication. |
| 3 | $f$ is Lipschitz **on $A$**, not on all of $\mathbb{R}^n$. | ✅ `LipschitzOnWith K f A`, with `K` universally quantified so that every admissible Lipschitz constant gives a bound. |
| 4 | The integrand is the $(s-m)$-dimensional Hausdorff measure of the slice $A \cap f^{-1}\{y\}$, with $s-m$ the real difference. | ✅ `μH[s - m] (A ∩ f ⁻¹' {y})`. |
| 5 | The integral over $y$ is the **upper** integral $\int^{*}$: the infimum of $\int g$ over measurable functions $g$ lying above the integrand. | ✅ `upperIntegral volume (fun y ↦ …)`, where `upperIntegral μ f = ⨅ g, ⨅ (_ : Measurable g), ⨅ (_ : f ≤ g), ∫⁻ x, g x ∂μ` in `Defs.lean`. |
| 6 | The integration is against Lebesgue measure on $\mathbb{R}^m$. | ✅ `volume` on `EuclideanSpace ℝ (Fin m)`, which is Lebesgue measure there. |
| 7 | The right-hand side is (constant) $\times$ (Lipschitz constant)$^m$ $\times$ $\mathcal{H}^s(A)$. | ✅ `c * (K : ℝ≥0∞) ^ (m : ℝ) * μH[s] A`. |
| 8 | Nothing is assumed about the measurability of $A$; the text allows an arbitrary subset of $\mathbb{R}^n$. | ✅ `A : Set (EuclideanSpace ℝ (Fin n))` with no side condition; `μH[·]` is an outer measure, defined on all sets. |
| 9 | Everything is `ℝ≥0∞`-valued, since both the slice measures and $\mathcal{H}^s(A)$ can be $\infty$. | ✅ `upperIntegral`, `μH[s - m]`, `μH[s]` and `c` all live in `ℝ≥0∞`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Using mathlib's `∫⁻ y, … ∂volume` in place of the upper integral. | `∫⁻` is the *lower* integral — the supremum of integrals of simple functions below the integrand. For a non-measurable integrand it can be strictly smaller than $\int^{*}$, so the inequality proved is weaker than the one printed. This is exactly why Mattila writes $\int^{*}$. |
| 2 | Using the Bochner integral `∫`. | It is real-valued and evaluates to the junk value $0$ whenever the integrand is not integrable — which is the interesting case here, since slice measures are routinely $\infty$. |
| 3 | Writing `∀ s A f, ∃ c, …`. | That lets the constant depend on the set and the map, which makes the inequality nearly content-free. The constant must come first. |
| 4 | Assuming `LipschitzWith K f`, i.e. Lipschitz on all of $\mathbb{R}^n$. | A strictly stronger hypothesis, hence a weaker theorem. The book only assumes $f$ is Lipschitz on $A$. |
| 5 | Integrating $\mathcal{H}^{s-m}(f^{-1}\{y\})$ without intersecting with $A$. | In Lean `f` is a total function whose values off $A$ are unconstrained junk; the intersection with $A$ is what neutralizes them. |
| 6 | Dropping $s < n$, or dropping $m < s$. | Both are hypotheses. Without $m < s$ the exponent $s - m$ is nonpositive and the slice term is not the intended one. |
| 7 | Adding a measurability hypothesis on the slice function, or on $A$. | That removes the difficulty the upper integral exists to handle, and it is not in the text. |

## Notes on the ground truth

- An earlier version of this statement used `∫⁻` (the lower integral). That was a genuine weakening
  of the printed inequality and has been repaired: the statement now uses `upperIntegral`, an
  infimum over measurable majorants. Candidates that reach for `∫⁻` are making the same mistake.
- The book writes $\mathrm{Lip}(f)^m$, the least Lipschitz constant. Quantifying over every `K` with
  `LipschitzOnWith K f A` is equivalent, since the right-hand side grows with `K`.
- $d\mathcal{L}^m y$ is Lebesgue measure on $\mathbb{R}^m$. Using `μH[(m:ℝ)]` on the target instead
  would change the bound only by a dimensional constant, which `c` could absorb, but it is farther
  from the text.
- The Lipschitz constant is raised to the natural power `^ m`.
- The range condition is two separate hypotheses, `(m : ℝ) < s` and `s < n`.
- The constant is only required to be finite, not positive. A smaller `c` gives a stronger claim, so
  no lower bound on `c` is needed.

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

- Requirement 1 with the constant quantified after $A$ or $f$.
- Requirement 5 with an ordinary integral in place of the upper integral, or with a measurability hypothesis added to make one available.
- Requirement 7 with the power of $\mathrm{Lip}(f)$ other than $m$.

### Domain-specific pitfalls for this problem

- The upper integral is what makes the statement meaningful without measurability of the slice function; adding measurability changes the hypotheses.
- $f$ is Lipschitz on $A$ only.
- Both sides are extended-real valued and may be infinite.
- The constant depends only on $n$ and $m$.
- The slice is $A \cap f^{-1}\{y\}$ and is measured with $\mathcal{H}^{s-m}$.
