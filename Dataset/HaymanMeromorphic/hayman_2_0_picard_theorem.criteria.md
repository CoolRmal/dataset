# Criteria: hayman_2_0_picard_theorem

**Statement:** [hayman_2_0_picard_theorem.md](hayman_2_0_picard_theorem.md) · **Lean:** [hayman_2_0_picard_theorem.lean](hayman_2_0_picard_theorem.lean)

The content is a bound of **two** on the size of the exceptional set, not a bound of one, and it applies to *transcendental* meromorphic functions — a rational function omits values freely. "Infinitely often" is genuine infinitude of the value set, not mere nonemptiness. A recurring hazard in this book: in Mathlib a meromorphic function is an honest `f : ℂ → ℂ` that is `MeromorphicAt` everywhere, so `f` still has a *value* at each pole. A set such as `{z \| f z = a}` can therefore pick up an accidental coincidence at a pole, where Hayman means an $a$-point of the analytic part. Every statement below that quantifies over value sets must be read with that in mind.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Conclusion completeness | The exceptional set has at most two elements: `∃ a b, E ⊆ {a, b}`. `Set.Subsingleton` (≤ 1) is the wrong bound and would be false for $e^z$ viewed on the sphere. | ✅ `∃ a b : ℂ, {c \| ¬ {z \| f z = c}.Infinite} ⊆ {a, b}`. ❗ Predicted error: `Subsingleton`, or `∃ a, E ⊆ {a}`. |
| 2 | Hypothesis completeness | Transcendence is essential. It is expressed as "not a rational function", i.e. not equal to a quotient of polynomials off the zero set of the denominator. | ✅ `htr`. ❗ Predicted error: dropping it, or writing "not a polynomial" (which admits `1/z`, a rational function omitting `0`). |
| 3 | Faithful encoding | "Assumes infinitely often" is `{z \| f z = c}.Infinite`; the exceptional set is the complement of that condition. | ✅ As written. ❗ Predicted error: `{z \| f z = c} ≠ ∅`, which is Picard's *little* theorem and strictly weaker. |
| 4 | Semantic closeness / scope | Hayman says "all values in the plane", i.e. the finite values; on the sphere $\infty$ counts as one of the two exceptions. | ⚠️ The Lean statement quantifies over `c : ℂ` only, so it bounds the finite exceptional values by two. That is the literal reading of "values in the plane" but is marginally weaker than the spherical form. |
| 5 | Junk values | No suprema, integrals or `toReal` occur; the only modelling subtlety is the pole convention. | ⚠️ See the preamble. |
