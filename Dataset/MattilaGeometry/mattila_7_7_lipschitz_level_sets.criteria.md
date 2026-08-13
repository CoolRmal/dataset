# Criteria: mattila_7_7_lipschitz_level_sets

**Statement:** [mattila_7_7_lipschitz_level_sets.md](mattila_7_7_lipschitz_level_sets.md) · **Lean:** [mattila_7_7_lipschitz_level_sets.lean](mattila_7_7_lipschitz_level_sets.lean)

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
row is incomplete.

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
- ⚠️ `(K : ℝ≥0∞) ^ (m : ℝ)` is `rpow`; the simpler natural power `^ m` would read better.
- ⚠️ The range condition is packaged as one conjunction `(m : ℝ) < s ∧ s < n`; two separate
  hypotheses would be more idiomatic.
- The constant is only required to be finite, not positive. A smaller `c` gives a stronger claim, so
  no lower bound on `c` is needed.
