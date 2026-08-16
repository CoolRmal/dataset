# Criteria: mattila_9_7_projection_energy

**Statement:** [mattila_9_7_projection_energy.md](mattila_9_7_projection_energy.md) · **Lean:** [mattila_9_7_projection_energy.lean](mattila_9_7_projection_energy.lean) · **Context:** [mattila_9_7_projection_energy.context.md](mattila_9_7_projection_energy.context.md)

## What the theorem says

Take a Radon measure $\mu$ on $\mathbb{R}^n$ with compact support whose Riesz $m$-energy
$I_m(\mu) = \iint \lvert x-y\rvert^{-m}\,d\mu x\,d\mu y$ is finite. Project $\mu$ onto an
$m$-dimensional subspace $V$, giving the image measure $P_{V\#}\mu$ on $V$. The theorem says that for
almost every $V$ — with respect to the rotation-invariant probability measure $\gamma_{n,m}$ on the
Grassmannian $G(n,m)$ — the projected measure has a density with respect to $\mathcal{H}^m$ on $V$.
Moreover the densities are square-integrable on average: integrating the square of the density over
$V$ and then over all $V$ gives at most a constant times $I_m(\mu)$, with the constant depending only
on $n$ and $m$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The Grassmannian must carry a fixed measurable structure, otherwise "for $\gamma_{n,m}$ almost all $V$" is not pinned down. | ✅ `Defs.lean` gives `Grassmannian n m` the topology induced by the projection operators `V.1.starProjection`, then the Borel $\sigma$-algebra, plus a `BorelSpace` instance. |
| 2 | $\gamma_{n,m}$ is a probability measure on $G(n,m)$ invariant under all linear isometries of $\mathbb{R}^n$. | ✅ `γ : Measure (Grassmannian n m)` with `hγ : IsInvariantGrassmannianMeasure γ`, which packages `IsProbabilityMeasure γ` together with `Measure.map (grassmannianAction Q) γ = γ` for every norm-preserving linear equivalence `Q`. |
| 3 | The constant depends only on $n$ and $m$, so it is quantified before $\mu$, and it is finite. | ✅ `∃ c : ℝ≥0∞, c < ∞ ∧ ∀ μ, …`, with `n`, `m` and `γ` fixed earlier. |
| 4 | $\mu$ is a Radon measure: finite on compact sets and inner regular. | ✅ `IsFiniteMeasureOnCompacts μ → Measure.InnerRegular μ → …`. |
| 5 | $\mu$ has compact support. | ✅ `IsCompact μ.support →`, with `μ.support` mathlib's `MeasureTheory.Measure.support`. |
| 6 | The energy hypothesis $I_m(\mu) < \infty$, with the Riesz kernel $\lvert x-y\rvert^{-m}$ taking the value $\infty$ on the diagonal. | ✅ `rieszEnergy (m : ℝ) μ < ∞`, where `rieszEnergy s μ = ∫⁻ x, ∫⁻ y, (ENNReal.ofReal (dist x y))⁻¹ ^ s ∂μ ∂μ` — the inverse is taken *after* moving into `ℝ≥0∞`, so `x = y` contributes `∞`. |
| 7 | First conclusion: for $\gamma$-almost every $V$, the pushforward of $\mu$ under the orthogonal projection onto $V$ is absolutely continuous with respect to $\mathcal{H}^m$ on $V$. | ✅ `∀ᵐ V ∂γ, Measure.map (fun x ↦ V.1.orthogonalProjectionOnto x) μ ≪ μH[(m : ℝ)]`. |
| 8 | The projection must be a measurable map landing inside $V$, so that $\mathcal{H}^m$ is computed in $V$. | ✅ `Submodule.orthogonalProjectionOnto : E →L[ℝ] ↥V.1` is continuous, hence measurable, and lands in the subtype; `μH[(m:ℝ)]` there is the measure Mattila writes $\int_V \dots\,d\mathcal{H}^m u$. |
| 9 | Second conclusion: the densities of the projected measures satisfy the energy bound — the double integral of the square of the density, over $V$ against $\mathcal{H}^m$ and over $G(n,m)$ against $\gamma$, is at most $c\,I_m(\mu)$. | ✅ `∫⁻ V, ∫⁻ x, density V x ^ (2 : ℝ) ∂μH[(m : ℝ)] ∂γ ≤ c * rieszEnergy (m : ℝ) μ`. |
| 10 | Every quantity is `ℝ≥0∞`-valued, since energies and density integrals can be infinite. | ✅ `rieszEnergy`, both `∫⁻`s and `c` all live in `ℝ≥0∞`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Writing the kernel as `ENNReal.ofReal ((dist x y)⁻¹) ^ s`, i.e. inverting the real distance first. | In Lean `(0 : ℝ)⁻¹ = 0`, so the kernel is `0` on the diagonal instead of `∞`. Then a point mass has energy $0 < \infty$, while its projection is again a point mass and is not absolutely continuous with respect to $\mathcal{H}^m$ for $m \ge 1$ — the theorem becomes false. |
| 2 | Leaving the $\sigma$-algebra on $G(n,m)$ as an unconstrained instance argument. | Every measurable structure would then be allowed. With the trivial one, a Dirac measure at a single subspace satisfies invariance, `∀ᵐ V ∂γ` collapses to `∀ V`, and the conclusion becomes a much stronger claim that fails. |
| 3 | Writing `∀ μ, ∃ c, …`. | It lets the constant depend on the measure, which drains the inequality of content. |
| 4 | Asserting the density identity for **all** $V$ rather than for $\gamma$-almost all $V$. | Absolute continuity genuinely fails for some subspaces (for instance when $\mu$ lives on a line orthogonal to $V$); only an almost-everywhere claim is true. |
| 5 | Using the Bochner integral `∫` for the energy or for the double integral. | Both are routinely infinite, and the Bochner integral returns the junk value $0$ when the integrand is not integrable — exactly when the bound would matter. |
| 6 | Dropping compactness of $\mu$'s support, or the Radon conditions. | All three are hypotheses of 9.7, and compact support is genuinely used. |
| 7 | Keeping only the energy bound and dropping the absolute continuity conclusion. | The theorem asserts both; the density in the second conclusion only exists because of the first. |

## Notes on the ground truth

- Two earlier defects have been repaired and are recorded here as regression checks. The Riesz kernel
  used to invert the distance before the coercion, making it `0` on the diagonal (Mistake 1); and the
  measurable structure on the Grassmannian used to be an unconstrained instance argument
  (Mistake 2).
- The density $D(P_{V\#}\mu, u)$ is introduced existentially,
  `∃ density : ∀ V, ↥V.1 → ℝ≥0∞` with `Measure.map … μ = μH[(m:ℝ)].withDensity (density V)` for
  almost every `V`, rather than canonically. This is sound: the values of `density V` are pinned
  $\mathcal{H}^m$-almost everywhere for almost every `V`, and both integrals ignore null-set
  ambiguity.
- The density is existentially bound and pinned by `Measure.map … μ = μH[m].withDensity (density V)`,
  which is the defining property of a Radon–Nikodym derivative and avoids depending on Mathlib's
  particular `rnDeriv` normalisation on the null set where it is not determined.
- The bound is stated with the strict `<` the book writes.
- Radon-ness is carried by instance binders `[IsFiniteMeasureOnCompacts μ] [Measure.InnerRegular μ]`,
  which is what these classes are for.
- No hypothesis $m \le n$ is imposed. When $m > n$ the Grassmannian is empty, no probability measure
  exists on it, and the theorem is empty of content — harmless, but worth knowing.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[mattila_9_7_projection_energy.md](mattila_9_7_projection_energy.md) and the background in [mattila_9_7_projection_energy.context.md](mattila_9_7_projection_energy.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 10 rows, so each row is worth 5.0 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 3 with the constant quantified after $\mu$.
- Requirement 7 with the absolute continuity conclusion omitted, so that the density in the second conclusion is undefined.
- Requirement 6 with the energy taken with a different kernel exponent.

### Domain-specific pitfalls for this problem

- The energy is a double integral of a nonnegative singular kernel and belongs in $[0,\infty]$.
- The density $D(P_{V\#}\mu,\cdot)$ exists only because of the first conclusion; asserting the bound without it refers to an undefined object.
- $\mathcal{H}^m$ on $V$ uses the metric $V$ inherits from $\mathbb{R}^n$.
- Compact support of $\mu$ is a hypothesis.
- The constant depends only on $n$ and $m$.
