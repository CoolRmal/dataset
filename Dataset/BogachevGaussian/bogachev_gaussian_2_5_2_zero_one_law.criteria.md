# Criteria: bogachev_gaussian_2_5_2_zero_one_law

**Statement:** [bogachev_gaussian_2_5_2_zero_one_law.md](bogachev_gaussian_2_5_2_zero_one_law.md) · **Lean:** [bogachev_gaussian_2_5_2_zero_one_law.lean](bogachev_gaussian_2_5_2_zero_one_law.lean)

A faithful formalization must contain both halves — the $\{0,1\}$ dichotomy for invariant sets and the a.e.-constancy of invariant functions — and must quantify the invariance over **all** Cameron–Martin shifts. Invariance under a single shift, or under shifts by an arbitrary vector of $X$, are both wrong: the first is far too weak and the second is far too strong (only Cameron–Martin vectors preserve $\gamma$-null sets).

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Conclusion completeness | Both assertions are required; the function version is the one used downstream (e.g. for measurable seminorms) and does not follow formally from the set version in Lean. | ✅ A conjunction. ❗ Predicted error: keeping only `γ A = 0 ∨ γ A = 1`. |
| 2 | Hypothesis completeness | The invariance hypothesis ranges over $h \in H(\gamma)$. Quantifying over all $h \in X$ makes the hypothesis nearly vacuous (few sets are invariant) and the theorem uninformative. | ✅ `∀ h ∈ cameronMartinSpace γ`. ❗ Predicted error: `∀ h : E`. |
| 3 | Faithful encoding | $A + h$ is the translate $\{x + h : x \in A\}$; the function version is invariance *almost everywhere* for each fixed $h$, not everywhere. | ✅ `γ ((fun x ↦ x + h) '' A) = γ A` and `∀ᵐ x ∂γ, f (x + h) = f x`. ❗ Predicted error: `∀ x, f (x + h) = f x`, a strictly stronger hypothesis. |
| 4 | Semantic closeness | Bogachev's hypothesis is $R_\gamma(X^*) \subset X$, under which $H(\gamma) = R_\gamma(X^*)$; the shifts are therefore exactly the Cameron–Martin shifts. | ⚠️ The Lean statement uses `cameronMartinSpace γ` directly and works on a normed space, where the inclusion is automatic. Recorded in the `.md` notation block. |
| 5 | Junk values | `cameronMartinSpace γ = {h \| cameronMartinNorm γ h ≠ ∞}` inherits the `ℝ≥0∞` valuation, so no vector is admitted by a junk `0`. | ✅ Safe. |
| 6 | Conclusion completeness | The function conclusion is "$f$ equals a constant a.e.", i.e. `∃ c, ∀ᵐ x ∂γ, f x = c` — the existential must be outside the a.e. quantifier. | ✅ As written. ❗ Predicted error: `∀ᵐ x ∂γ, ∃ c, f x = c`, which is vacuously true. |
