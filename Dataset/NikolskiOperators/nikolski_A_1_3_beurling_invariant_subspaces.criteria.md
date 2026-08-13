# Criteria: nikolski_A_1_3_beurling_invariant_subspaces

**Statement:** [nikolski_A_1_3_beurling_invariant_subspaces.md](nikolski_A_1_3_beurling_invariant_subspaces.md) · **Lean:** [nikolski_A_1_3_beurling_invariant_subspaces.lean](nikolski_A_1_3_beurling_invariant_subspaces.lean)

## What the theorem says

Work with square-integrable functions on the unit circle. Take a closed linear subspace $E$ that is
carried into itself by multiplication by $z$, and suppose the image $zE$ is *strictly* smaller than
$E$. Beurling and Helson prove that $E$ is then exactly the set of products $\Theta h$, where
$\Theta$ is one fixed measurable function of modulus $1$ and $h$ ranges over the Hardy space $H^2$
(the square-integrable functions on the circle whose negative Fourier coefficients all vanish).
The multiplier $\Theta$ is unique up to multiplication by a constant of modulus $1$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $E$ is a complex linear subspace: it contains $0$ and is closed under linear combinations. | ✅ First two conjuncts of `IsCircleL2Subspace E`. |
| 2 | Every member of $E$ is square integrable, and membership depends only on the almost-everywhere class of a function. | ✅ Last two conjuncts of `IsCircleL2Subspace E`: `∀ f ∈ E, MemLp f 2 circleMeasure` and the a.e.-saturation clause. |
| 3 | $E$ is closed in the $L^2$ norm. | ✅ `hclosed`: any $L^2$ function that is an $L^2$-limit of a sequence drawn from `E` already lies in `E`. |
| 4 | Multiplication by $z$ maps $E$ into $E$, and the image is a *proper* subset. | ✅ `hshiftProper` uses `⊂` (strict inclusion), which says both "contained in" and "not equal". |
| 5 | Multiplication by $z$ is multiplication by $e^{it}$ on the angular parameter. | ✅ `fun t ↦ Complex.exp (Complex.I * t) * f t`. |
| 6 | The conclusion produces a measurable $\Theta$ with $\lvert\Theta\rvert = 1$ almost everywhere. | ✅ First two conjuncts of `UnimodularGeneratedSubspace E theta`: `AEStronglyMeasurable theta circleMeasure` and `∀ᵐ t, ‖theta t‖ = 1`. |
| 7 | $E$ equals $\Theta H^2$ — an exact equality of sets, not an inclusion and not a closure. | ✅ `E = {f \| ∃ h, HardyBoundaryFunction h ∧ f =ᵐ[circleMeasure] fun t ↦ theta t * h t}`. |
| 8 | $H^2$ is the boundary model: square integrable with all negative Fourier coefficients zero. | ✅ `HardyBoundaryFunction h` is `MemLp h 2 circleMeasure ∧ ∀ k < 0, angularFourierCoefficient h k = 0`. |
| 9 | The uniqueness clause: any other unimodular generator $\eta$ of the same $E$ equals $c\Theta$ for one constant $c$ with $\lvert c\rvert = 1$. | ✅ The trailing `∀ eta, UnimodularGeneratedSubspace E eta → ∃ c, ‖c‖ = 1 ∧ eta =ᵐ[circleMeasure] fun t ↦ c * theta t`. |
| 10 | The identifications are stated up to almost-everywhere equality, since $L^2$ members are only pinned down off null sets. | ✅ `=ᵐ[circleMeasure]` in both the generation clause and the uniqueness clause. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Writing $zE \subseteq E$ (or just a `ShiftInvariant`-style predicate) instead of the strict $zE \subsetneq E$. | Plain invariance admits $E = \{0\}$, and it also admits the doubly invariant subspaces $\chi_\sigma L^2$. Neither is of the form $\Theta H^2$, so the theorem becomes false. |
| 2 | Dropping the closedness hypothesis. | Shift-invariant subspaces that are not closed exist (for instance the polynomial multiples of a $\Theta$) and are not equal to $\Theta H^2$. |
| 3 | Omitting the uniqueness clause, or replacing it with `∃!`. | Uniqueness is half the theorem. `∃!` is outright false: if $\Theta$ works then so does $c\Theta$ for every $\lvert c\rvert = 1$. |
| 4 | Formalizing the $H^2$ version instead — coefficient sequences in $\ell^2(\mathbb{N})$ with an *inner* $\Theta$. | That is Beurling's theorem, which is narrower than the printed statement. Here $E$ lives in $L^2$ with two-sided frequencies and $\Theta$ is only asserted measurable and unimodular, not analytic. |
| 5 | Writing $E = \overline{\Theta H^2}$ or $\Theta H^2 \subseteq E$. | The theorem asserts equality; $\Theta H^2$ is already closed, so a closure or an inclusion states strictly less. |
| 6 | Demanding $f = \Theta h$ at every point rather than almost everywhere. | Members of $L^2$ are only determined off null sets, and the subspace is explicitly a.e.-saturated, so the everywhere version is not the intended claim and would fail for legitimate representatives. |
| 7 | Letting $\Theta$ be any measurable function without the constraint $\lvert\Theta\rvert = 1$ a.e. | Without unimodularity the conclusion is nearly empty: multiplication by an arbitrary measurable function does not preserve $L^2$, and the uniqueness statement collapses. |

## Notes on the ground truth

- The circle is modelled by the parameter interval $(0, 2\pi]$ with unnormalized Lebesgue measure
  (`circleMeasure`), not by normalized Haar measure $m$ on $\mathbb{T}$. Only null sets and Fourier
  coefficients matter here, and the $1/(2\pi)$ normalization sits inside
  `angularFourierCoefficient`, so nothing is lost. Mathlib's `Circle` with
  `AddCircle.haarAddCircle` would match the book's $m$ literally.
- Subspace-hood is hand-rolled as `IsCircleL2Subspace` on `Set (ℝ → ℂ)` rather than being a
  `Submodule ℂ` of an $L^2$ space. This is faithful but verbose, and it forces the closedness
  hypothesis to be phrased with approximating sequences rather than with `IsClosed`.
- `ShiftInvariant` is defined in `Defs.lean` but is not used here: properness (`⊂`) already
  contains invariance.
- An earlier version of this file used the coefficient model (`M : Set (ℕ → ℂ)`, Cauchy products,
  an inner generator). That statement was true but formalized Beurling's $H^2$ theorem rather than
  the printed Beurling–Helson theorem in $L^2$; the current file uses the $L^2$ model. Mistake 4
  records the defect.
