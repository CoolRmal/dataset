# Criteria: bogachev_4_6_3_nikodym_vitali_hahn_saks

**Statement:** [bogachev_4_6_3_nikodym_vitali_hahn_saks.md](bogachev_4_6_3_nikodym_vitali_hahn_saks.md) · **Lean:** [bogachev_4_6_3_nikodym_vitali_hahn_saks.lean](bogachev_4_6_3_nikodym_vitali_hahn_saks.lean) · **Context:** [bogachev_4_6_3_nikodym_vitali_hahn_saks.context.md](bogachev_4_6_3_nikodym_vitali_hahn_saks.context.md)

## What the theorem says

Suppose a sequence of finite signed measures $\mu_n$ has the property that $\mu_n(A)$ converges to
a finite limit for every measurable set $A$ — and nothing else is assumed. Then a great deal follows
for free. First, the limit is itself a finite signed measure, so countable additivity survives the
pointwise limit. Second, there is a single finite nonnegative measure $\nu$ and a single bounded
increasing function $\alpha$ vanishing at $0$ with $\lvert \mu_n(A)\rvert \le \alpha(\nu(A))$ for
every $n$ and every $A$; in particular the $\mu_n$ have uniformly bounded variation and are
uniformly countably additive. Third, if all the $\mu_n$ are absolutely continuous with respect to
one finite measure, that absolute continuity is uniform in $n$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The $\mu_n$ are finite signed measures, not nonnegative measures. | ✅ `s : ℕ → SignedMeasure Ω`; `SignedMeasure` is finite and of bounded variation by construction. |
| 2 | The only hypothesis is that $\mu_n(A)$ converges to a finite real limit for every measurable $A$. | ✅ `hlim : ∀ A, MeasurableSet A → ∃ l : ℝ, Tendsto (fun n ↦ s n A) atTop (𝓝 l)`. |
| 3 | Conclusion (1): the setwise limit is again a signed measure, and the $\mu_n(A)$ converge to its value on every measurable $A$. | ✅ `∃ sLim : SignedMeasure Ω, ∀ A, MeasurableSet A → Tendsto (fun n ↦ s n A) atTop (𝓝 (sLim A))`. Countable additivity of the limit is carried by the type. |
| 4 | Conclusion (2): there is a finite nonnegative measure $\nu$ and a function $\alpha$ on $[0,\infty)$. | ✅ `∃ ν : FiniteMeasure Ω, ∃ α : ℝ≥0 → ℝ≥0`. |
| 5 | $\alpha$ is nonnegative, nondecreasing, and bounded. | ✅ Nonnegativity from the type `ℝ≥0`, `Monotone α`, and `∃ C : ℝ≥0, ∀ t, α t ≤ C`. |
| 6 | $\alpha(t) \to 0$ as $t \to 0$. | ✅ `Tendsto α (𝓝[>] 0) (𝓝 0)`, the one-sided limit the book takes, leaving $\alpha(0)$ free. |
| 7 | The bound $\lvert \mu_n(A)\rvert \le \alpha(\nu(A))$ holds for every $n$ and every measurable $A$. | ✅ `∀ n, ∀ A, MeasurableSet A → \|s n A\| ≤ (α (ν A) : ℝ)`. |
| 8 | The "in particular" clauses: uniform boundedness in variation, and uniform countable additivity of the whole sequence. | ✅ `UniformlyBoundedInTotalVariation (range s)` and `UniformlyCountablyAdditive (range s)`. |
| 9 | Conclusion (3): for *every* finite nonnegative measure that dominates all the $\mu_n$, the absolute continuity is uniform. | ✅ `∀ lam : FiniteMeasure Ω, (∀ n, s n ≪ᵥ (lam : Measure Ω).toENNRealVectorMeasure) → UniformlyAbsolutelyContinuous (range s) lam`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Using nonnegative `Measure Ω` instead of `SignedMeasure Ω`. | The theorem is about real measures of bounded variation. For nonnegative measures much of the content is different or trivial, and the sign cancellations that make the uniform bound hard disappear. |
| 2 | Assuming a uniform bound $\sup_n \lVert \mu_n\rVert < \infty$ as a hypothesis. | That is one of the conclusions. Assuming it removes the hardest part of the theorem. |
| 3 | Dropping the boundedness of $\alpha$. | This is the clause models drop most often. Without it $\alpha$ could be, say, $\alpha(t) = \infty$-like and the bound would say nothing about uniform boundedness of the $\mu_n$. |
| 4 | Fixing one dominating measure $\lambda$ in the theorem's hypotheses instead of quantifying over all of them in conclusion (3). | Turns a conclusion into an assumption, and states a weaker result. |
| 5 | Omitting the assertion that the limit is countably additive (for example concluding only that a set function $\mu$ exists). | The Nikodym half of the theorem is exactly that the limit is again a measure. |
| 6 | Requiring only that $\mu_n(A)$ converges for sets in some generating algebra. | The hypothesis is convergence on every set of the $\sigma$-algebra. |
| 7 | Formalizing uniform countable additivity as convergence of the tail *series* $\sum_{i \ge n}\mu(A_i)$ without saying the series converges. | The sum of a series that has not been shown convergent has a default value in Lean and can make the condition hold for the wrong reason. Measuring the tail *union* avoids the issue entirely. |

## Notes on the ground truth

- The three `Uniformly…` predicates live in `Defs.lean` and are shared with problem 8.6.2.
  `UniformlyCountablyAdditive S` says: for every sequence of pairwise disjoint measurable sets
  $A_i$ and every $\varepsilon > 0$ there is an $N$ such that
  $\lvert s(\bigcup_{k \ge n} A_k)\rvert < \varepsilon$ for all $s \in S$ and all $n \ge N$. By
  countable additivity the measure of the tail union equals the tail series of Definition 4.6.2, so
  this matches the book without needing a separate convergence side condition.
  `UniformlyBoundedInTotalVariation S` says there is one $C$ with $\lvert s\rvert(X) \le C$ for all
  $s \in S$. `UniformlyAbsolutelyContinuous S μ` is the $\varepsilon$–$\delta$ form: for each
  $\varepsilon > 0$ there is $\delta > 0$ such that $\mu(A) \le \delta$ forces
  $\lvert s(A)\rvert < \varepsilon$ for all $s \in S$.
- `range s` turns the sequence into the family that the `Uniformly…` predicates take, so the same
  definitions serve here and in 8.6.2.
- The $\varepsilon$–$\delta$ comparison `μ A ≤ ENNReal.ofReal δ` happens in `ℝ≥0∞`, so sets of
  infinite measure are handled correctly; `|s A| < ε` is an honest inequality between reals because
  signed measures take finite values.
- Both "there exists a bound $C$" formulations (in requirement 5 and in
  `UniformlyBoundedInTotalVariation`) could equally be written as `⨆ … < ∞`, which would read closer
  to the printed suprema. The `∃ C` form is equivalent.
- Absolute continuity of a signed measure with respect to a measure is written with Mathlib's
  vector-measure relation `≪ᵥ` against `toENNRealVectorMeasure`, the standard way to compare the
  two types.
- Conclusions (2) and (3) sit inside the scope of the `∃ sLim` from conclusion (1) even though they
  do not mention `sLim`. This is only a nesting convenience and does not change what is asserted.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[bogachev_4_6_3_nikodym_vitali_hahn_saks.md](bogachev_4_6_3_nikodym_vitali_hahn_saks.md) and the background in [bogachev_4_6_3_nikodym_vitali_hahn_saks.context.md](bogachev_4_6_3_nikodym_vitali_hahn_saks.context.md),
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

- Requirement 1: stating the theorem for nonnegative measures instead of signed ones. The Nikodym–Vitali–Hahn–Saks theorem is about real measures; the nonnegative case is materially different.
- Requirement 2 strengthened by assuming $\sup_n \lVert\mu_n\rVert < \infty$: that is the theorem's own conclusion, and assuming it removes the content.
- Requirement 5 with the boundedness of $\alpha$ dropped: the bound $|\mu_n(A)| \le \alpha(\nu(A))$ then says nothing and no uniform bound follows.

### Domain-specific pitfalls for this problem

- A `SignedMeasure` in Mathlib is a `VectorMeasure` into `ℝ`, hence automatically finite and of bounded variation — the right home for $\mathcal{M}(X,\mathcal{A})$. `Measure` (nonnegative, `ℝ≥0∞`-valued, possibly infinite) is not.
- A signed measure applied to a non-measurable set returns `0` by definition, so every clause must be guarded by `MeasurableSet A`; without the guard some clauses are satisfied by that default rather than by mathematics.
- Junk value — series: a tail sum $\sum_{i \ge n} \mu(A_i)$ written with `tsum` is `0` when the series is not summable, so a uniform-countable-additivity clause stated with `tsum` and no summability can be vacuously satisfied.
- $\alpha(t) \to 0$ as $t \to 0$: taking the limit along the full neighbourhood filter of $0$ additionally forces $\alpha(0)=0$, whereas the book takes a one-sided limit. Here the two agree, because $\alpha \ge 0$ is nondecreasing, but the distinction is real in general.
- The dominating measure $\lambda$ of part (3) belongs in the conclusion, universally quantified. Moving it into the theorem's hypotheses states a weaker result.
