# Criteria: hayman_3_6_corollary_derivative_zeros_in_disk

**Statement:** [hayman_3_6_corollary_derivative_zeros_in_disk.md](hayman_3_6_corollary_derivative_zeros_in_disk.md) · **Lean:** [hayman_3_6_corollary_derivative_zeros_in_disk.lean](hayman_3_6_corollary_derivative_zeros_in_disk.lean)

The corollary's force is the **uniformity** of $l$: one threshold works for every disk and every $f$ simultaneously. Moving the `∀ f` inside the `∀ᶠ l` — i.e. letting the threshold depend on the function — gives a much weaker statement that follows immediately from Theorem 3.6.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Quantifier order | `∀ᶠ l in atTop, ∀ f z₀ R, …` — the threshold on `l` is chosen **before** the function and the disk. | ✅ As written. ❗ Highest-value trap: `∀ f z₀ R, …, ∀ᶠ l in atTop, …`. |
| 2 | Hypothesis completeness | `f` meromorphic on the disk with at least two distinct poles *in that disk*. | ✅ Both hypotheses inside the universally quantified body. |
| 3 | Conclusion completeness | The conclusion is existence of a zero of `f^{(l)}` inside the disk. | ✅ `∃ z ∈ ball z₀ R, iteratedDeriv l f z = 0`. |
| 4 | Semantic closeness | This is a genuinely separate assertion from Theorem 3.6, not a restatement: 3.6 localises near $z_0$, the corollary covers the whole disk. | ✅ Kept as its own declaration. |
| 5 | Junk values | No integrals, suprema or coercions occur. | ✅ Junk-free. |
