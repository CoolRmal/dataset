# Criteria: hayman_2_6_five_value_theorem

**Statement:** [hayman_2_6_five_value_theorem.md](hayman_2_6_five_value_theorem.md) · **Lean:** [hayman_2_6_five_value_theorem.lean](hayman_2_6_five_value_theorem.lean)

Five is sharp — $f_1 = e^{-z}$, $f_2 = e^{z}$ share $0, 1, -1, \infty$ — so the count must be exactly five distinct values, and the sets $E_j(a)$ must be compared **ignoring multiplicity**: they are sets of points, not divisors. The conclusion is a disjunction, and the second disjunct requires *both* functions constant. A recurring hazard in this book: in Mathlib a meromorphic function is an honest `f : ℂ → ℂ` that is `MeromorphicAt` everywhere, so `f` still has a *value* at each pole. A set such as `{z \| f z = a}` can therefore pick up an accidental coincidence at a pole, where Hayman means an $a$-point of the analytic part. Every statement below that quantifies over value sets must be read with that in mind.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Hypothesis completeness | Exactly five *distinct* values are needed. Four does not suffice. | ✅ `a : Fin 5 → ℂ` with `ha : Function.Injective a`. ❗ Predicted error: an unindexed `Set ℂ` of size ≥ 5 without injectivity, or four values. |
| 2 | Faithful encoding | $E_j(a)$ is the *set* $\{z : f_j(z) = a\}$; equality of these sets ignores multiplicity, which is exactly what makes the theorem hard. | ✅ `{z \| f₁ z = a ν} = {z \| f₂ z = a ν}`. ❗ Predicted error: comparing counting functions or divisors, i.e. accounting for multiplicity. |
| 3 | Conclusion completeness | The disjunction is `f₁ = f₂ ∨ (both constant)`. Dropping the constant branch makes the statement false for two distinct constants sharing no values. | ✅ Both branches present. ⚠️ The constants are given as `∃ c, ∀ z, f z = c` rather than `∃ c, f = Function.const ℂ c`; equivalent. |
| 4 | Hypothesis completeness | Both functions are meromorphic **in the whole plane**; the finite-disk version needs admissibility instead (Hayman notes this immediately after the proof). | ✅ `Meromorphic f₁`, `Meromorphic f₂`, i.e. `∀ x, MeromorphicAt _ x`. |
| 5 | Junk values | The value sets are compared as plain sets, so no measure or supremum is involved. | ⚠️ The only hazard is the pole convention described in the preamble. |
