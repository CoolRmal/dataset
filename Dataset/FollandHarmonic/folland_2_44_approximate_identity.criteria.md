# Criteria: folland_2_44_approximate_identity

**Statement:** [folland_2_44_approximate_identity.md](folland_2_44_approximate_identity.md) · **Lean:** [folland_2_44_approximate_identity.lean](folland_2_44_approximate_identity.lean)

The proposition quantifies over a neighbourhood base and takes a limit "as $U \to \{1\}$". The faithful unpacking is: for every $\varepsilon$ there is a neighbourhood $U$ of $1$ such that **every** bump supported in $U$ already works — the quantifier over $\psi$ must be universal, inside the choice of $U$. Getting that order wrong turns the statement into the much weaker claim that *some* approximate identity works.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Quantifier order | `∃ U ∈ 𝓝 1, ∀ ψ …` — the neighbourhood is chosen first and then every admissible bump works. | ✅ As written. ❗ Highest-value trap: `∀ ψ, ∃ U` or `∃ ψ, …`, which weakens the proposition. |
| 2 | Hypothesis completeness | Conditions (i) and (ii) on `ψ`: compact support contained in `U`, nonnegative, total mass `1`. | ✅ `HasCompactSupport ψ`, `tsupport ψ ⊆ U`, `∀ x, 0 ≤ ψ x`, `∫ x, ψ x ∂μ = 1`. ⚠️ `Integrable ψ μ` is added so that the mass condition is not about a junk `0` integral. |
| 3 | Conclusion completeness | The second half — right convolution — holds only under the extra symmetry condition (iii) `ψ (x⁻¹) = ψ x`. | ✅ Stated as an implication guarded by `∀ x, ψ x⁻¹ = ψ x`. ❗ Predicted error: asserting the right-hand convergence unconditionally. |
| 4 | Hypothesis completeness | The `𝓛ᵖ` conclusion needs `1 ≤ p < ∞`; the book's `p = ∞` case additionally requires left (resp. right) uniform continuity of `f`. | ⚠️ Only the `p < ∞` case is formalized (`hp' : p ≠ ∞`); the uniformly-continuous `p = ∞` case is omitted, which is a proper restriction of the book's statement rather than a distortion of it. |
| 5 | Junk values | `∫ x, ψ x ∂μ = 1` would be satisfiable by a non-integrable `ψ` only if the integral could be junk; it cannot equal `1` by default, but `Integrable ψ μ` makes the intent explicit. | ✅ Safe. |
| 6 | Faithful encoding | `supp ψ` in the book is the closed support, mathlib's `tsupport`. | ✅ `tsupport ψ ⊆ U`. ❗ Predicted error: `Function.support ψ ⊆ U`, which is weaker. |
