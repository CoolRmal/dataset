# Criteria: kallenberg_5_27_continuous_mapping

**Statement:** [kallenberg_5_27_continuous_mapping.md](kallenberg_5_27_continuous_mapping.md) · **Lean:** [kallenberg_5_27_continuous_mapping.lean](kallenberg_5_27_continuous_mapping.lean) · **Context:** [kallenberg_5_27_continuous_mapping.context.md](kallenberg_5_27_continuous_mapping.context.md)

## What the theorem says

Let $S$ and $T$ be metric spaces, let $C$ be any subset of $S$, and let $f, f_1, f_2, \dots$ be
measurable maps from $S$ to $T$ tied together by one condition: whenever $s_n \to s$ with $s$ in $C$,
we have $f_n(s_n) \to f(s)$. Then if random elements $\xi_n$ converge in distribution to $\xi$, and
$\xi$ lands in $C$ almost surely, the random elements $f_n(\xi_n)$ converge in distribution to
$f(\xi)$. As a special case, if a measurable map $g$ is almost surely continuous at $\xi$, then
$\xi_n \to \xi$ in distribution implies $g(\xi_n) \to g(\xi)$ in distribution.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | Both $S$ and $T$ are metric spaces with their Borel measurable structures, and the two underlying measures are probability measures. | ✅ `[MetricSpace S] [MeasurableSpace S] [BorelSpace S]`, likewise for `T`, and `[IsProbabilityMeasure μ] [IsProbabilityMeasure μ']`. |
| 2 | There is a whole sequence of maps $f_n$ plus a limit map $f$, and all of them are only assumed measurable. | ✅ `f : S → T`, `fn : ℕ → S → T`, `hfn : ∀ n, Measurable (fn n)`, `hf : Measurable f`. |
| 3 | The linking condition: for every $s$ in $C$ and every sequence $s_n \to s$, we have $f_n(s_n) \to f(s)$. The approximating sequence is unrestricted; only its limit must lie in $C$. | ✅ `hcontinuous : ∀ s : S, s ∈ C → ∀ sn : ℕ → S, Tendsto sn atTop (𝓝 s) → Tendsto (fun n ↦ fn n (sn n)) atTop (𝓝 (f s))`. |
| 4 | $C$ is an arbitrary subset of $S$, with no measurability assumed. | ✅ `C : Set S` and nothing else. |
| 5 | The hypothesis "$\xi_n \to \xi$ in distribution". | ✅ `hξ : TendstoInDistribution ξn atTop ξ (fun _ ↦ μ) μ'`, with the `ξn` on `(Ω, μ)` and `ξ` on `(Ω', μ')`. |
| 6 | The hypothesis "$\xi \in C$ almost surely". | ✅ `hC : μ' (ξ ⁻¹' C) = 1`, with `μ'` acting as an outer measure since `C` need not be measurable. |
| 7 | The conclusion: $f_n(\xi_n)$ converges in distribution to $f(\xi)$. | ✅ `TendstoInDistribution (fun n ω ↦ fn n (ξn n ω)) atTop (fun ω ↦ f (ξ ω)) (fun _ ↦ μ) μ'`. |
| 8 | The "in particular" corollary: for a measurable $g$ whose set of continuity points is charged with full probability by the law of $\xi$, $g(\xi_n) \to g(\xi)$ in distribution. | ✅ Second conjunct: `∀ g : S → T, Measurable g → μ' (ξ ⁻¹' {s : S \| ContinuousAt g s}) = 1 → TendstoInDistribution (fun n ω ↦ g (ξn n ω)) atTop (fun ω ↦ g (ξ ω)) (fun _ ↦ μ) μ'`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Collapsing the array to a single map — taking `fn n = f` and assuming `ContinuousOn f C`. | That is a strictly weaker theorem. Kallenberg's version applies to a varying sequence of maps, which is what makes it usable for triangular arrays and approximation schemes. |
| 2 | Requiring the approximating sequence to satisfy `sn n ∈ C`. | The linking condition would then say nothing about sequences approaching $C$ from outside, which is exactly the case the proof needs. |
| 3 | Assuming `Continuous f` or `Continuous (fn n)`. | The text assumes only measurability. Continuity gives the naive continuous-mapping theorem, not Theorem 5.27. |
| 4 | Adding `MeasurableSet C`. | Unnecessary and weakening: the theorem is stated for an arbitrary subset, and the outer-measure reading of "$\xi \in C$ a.s." makes it work. |
| 5 | Writing the hypothesis on $C$ as `∀ᵐ ω ∂μ', ξ ω ∈ C`. | For non-measurable $C$ that says the complement of the preimage is contained in a null set, which is strictly stronger than `μ' (ξ ⁻¹' C) = 1` and therefore yields a weaker theorem. |
| 6 | Using almost-sure convergence or convergence in probability. | The $\xi_n$ and $\xi$ live on different probability spaces, so those modes cannot even be stated here. |
| 7 | Omitting the "in particular" corollary, or stating it with `Continuous g`. | The corollary is part of the printed statement; with `Continuous g` it is trivial and carries none of its intended content. |
| 8 | Rendering "$g$ is a.s. continuous at $\xi$" as `ContinuousOn g C` or as continuity of $g$ on a set of full measure in $\Omega'$. | The condition is about the set of continuity points of $g$ inside $S$, pulled back through $\xi$; the other readings are different statements. |

## Notes on the ground truth

- Reading "$\xi \in C$ a.s." as `μ' (ξ ⁻¹' C) = 1` is the weakest sound reading and so gives the
  strongest theorem. The proof still goes through: any measurable set inside the complement of
  `ξ ⁻¹' C` has measure at most $1 - 1 = 0$.
- The set of continuity points `{s : S \| ContinuousAt g s}` is a $G_\delta$ in a metric space, hence
  measurable, so the outer-measure reading in the corollary is unambiguous.
- **Deliberate departure.** The corollary is a second conjunct sitting under the ambient hypotheses about `C`, `f`, `fn`.
  It still delivers the standalone statement — instantiate the theorem at `C = univ` and
  `f = fn n = id`, for which the linking condition and `hC` hold trivially — but a separate
  top-level theorem would be more idiomatic and would spare the reader that instantiation.
- The measurability facts about `ξn` and `ξ` come bundled inside `TendstoInDistribution`, so no
  separate hypotheses are needed.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[kallenberg_5_27_continuous_mapping.md](kallenberg_5_27_continuous_mapping.md) and the background in [kallenberg_5_27_continuous_mapping.context.md](kallenberg_5_27_continuous_mapping.context.md),
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

- Requirement 3 with the linking condition weakened to continuity of $f$ on $C$, which does not control the $f_n$.
- Requirement 2 with continuity assumed of $f$ or of the $f_n$.
- Requirement 8 omitted, dropping the "in particular" corollary.

### Domain-specific pitfalls for this problem

- The linking condition constrains the whole sequence $f_n$ jointly with $f$; assuming $f_n = f$ states only the classical special case.
- "A.s. continuous at $\xi$" means the law of $\xi$ charges the set of continuity points fully — not that $g$ is continuous.
- $C$ carries no measurability hypothesis.
- Convergence in distribution again concerns laws, so the source spaces may differ.
