# Criteria: bogachev_gaussian_2_5_2_zero_one_law

**Statement:** [bogachev_gaussian_2_5_2_zero_one_law.md](bogachev_gaussian_2_5_2_zero_one_law.md) · **Lean:** [bogachev_gaussian_2_5_2_zero_one_law.lean](bogachev_gaussian_2_5_2_zero_one_law.lean)

## What the theorem says

Let $\gamma$ be a Gaussian measure. Call a set *invariant* if shifting it by any Cameron–Martin
vector does not change its $\gamma$-measure. The zero–one law says such a set has measure exactly
$0$ or exactly $1$ — nothing in between is possible. The same statement holds for functions: if a
measurable function $f$ satisfies $f(x+h) = f(x)$ for almost every $x$, for every Cameron–Martin
vector $h$, then $f$ is almost everywhere equal to a single constant.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $\gamma$ is an arbitrary Gaussian measure on the ambient space. | ✅ `(γ : Measure E) [IsGaussian γ]` with `[NormedAddCommGroup E] [NormedSpace ℝ E] [MeasurableSpace E] [BorelSpace E]`. |
| 2 | Set half: the set $A$ is measurable. | ✅ `∀ A : Set E, MeasurableSet A → …`. |
| 3 | Set half: the invariance hypothesis is $\gamma(A+h) = \gamma(A)$, where $A+h$ is the translate $\{x+h : x \in A\}$. | ✅ `γ ((fun x ↦ x + h) '' A) = γ A`. |
| 4 | The shifts $h$ range over the Cameron–Martin space, not over the whole space and not over a single vector. | ⚠️ `∀ h ∈ cameronMartinSpace γ` in both halves. Bogachev instead assumes $R_\gamma(X^*) \subset X$ and shifts by $R_\gamma(X^*)$; the two agree under that hypothesis, and on a normed space it is automatic, so this is a faithful but not literal transcription. |
| 5 | Set half: the conclusion is the two-value dichotomy $\gamma(A) \in \{0,1\}$. | ✅ `γ A = 0 ∨ γ A = 1`. |
| 6 | Function half: $f$ is a measurable real-valued function. | ✅ `∀ f : E → ℝ, Measurable f → …`. |
| 7 | Function half: the invariance is almost-everywhere for each fixed $h$, not everywhere. | ✅ `∀ h ∈ cameronMartinSpace γ, ∀ᵐ x ∂γ, f (x + h) = f x`. |
| 8 | Function half: the conclusion is that a single constant works for almost every $x$ — the constant is chosen first, outside the "almost every". | ✅ `∃ c : ℝ, ∀ᵐ x ∂γ, f x = c`. |
| 9 | Both halves appear in one statement. | ✅ A conjunction of the two. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Keeping only the set version and dropping the function version. | The function version is what gets used downstream (for measurable seminorms, among other things), and in Lean it does not follow formally from the set version. |
| 2 | Writing the function conclusion as `∀ᵐ x ∂γ, ∃ c, f x = c`. | Always true — take $c = f(x)$ for each $x$. The existential must come first so that one constant serves almost every point. |
| 3 | Quantifying the invariance over all $h : E$ instead of over the Cameron–Martin space. | Far too strong a hypothesis: almost no set is invariant under every shift, so the theorem becomes nearly empty. Only Cameron–Martin shifts preserve $\gamma$-null sets, which is why they are the right family. |
| 4 | Requiring invariance for one fixed $h$ only. | Far too weak. A half-space invariant under a single shift need not have measure $0$ or $1$. |
| 5 | Assuming the function is invariant everywhere: `∀ x, f (x + h) = f x`. | A strictly stronger hypothesis than the printed one, so a strictly weaker theorem. |
| 6 | Concluding "$f$ is constant" rather than "$f$ equals a constant almost everywhere". | False as stated: $f$ can be modified on any $\gamma$-null set. |
| 7 | Interpreting the translate $A+h$ as the preimage $\{x : x + h \in A\}$ without noticing the sign. | That set is $A - h$. It happens to give an equivalent hypothesis here (the Cameron–Martin space is closed under negation), but a candidate should be checked for consistency between the two halves. |

## Notes on the ground truth

- Bogachev's hypothesis is $R_\gamma(X^*) \subset X$, under which $H(\gamma) = R_\gamma(X^*)$, so his shifts are exactly the Cameron–Martin shifts. Our statement uses `cameronMartinSpace γ` directly and works on a normed space, where that inclusion is automatic. This is recorded in the notation block of the `.md`.
- `cameronMartinSpace γ = {h \| cameronMartinNorm γ h ≠ ∞}`, and `cameronMartinNorm` is valued in `ℝ≥0∞`. So no vector sneaks into the space through a junk-value supremum of `0`; see the Cameron–Martin dichotomy rubric for why that matters.
- Bogachev states the theorem for sets and functions measurable with respect to the completed $\gamma$-measurable $\sigma$-algebra. We use plain `MeasurableSet` and `Measurable`, which is a mild restriction — the completed version follows by adjusting on a null set.
