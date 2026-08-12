# Criteria: folland_2_69_convolution_factorization

**Statement:** [folland_2_69_convolution_factorization.md](folland_2_69_convolution_factorization.md) · **Lean:** [folland_2_69_convolution_factorization.lean](folland_2_69_convolution_factorization.lean)

The theorem is a **factorization** statement: every $\mathcal{L}^p$ function is *exactly* (not approximately) a convolution $g*h$ with $g \in \mathcal{L}^1$ and $h \in \mathcal{L}^p$. The inclusion $\mathcal{L}^1 * \mathcal{L}^p \subseteq \mathcal{L}^p$ is Young's inequality and is the easy half; the content (a special case of Cohen's factorization theorem) is surjectivity.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Conclusion completeness | The assertion is set **equality**, whose non-trivial half is that every `f ∈ 𝓛ᵖ` factors. A candidate stating only `𝓛¹ * 𝓛ᵖ ⊆ 𝓛ᵖ` has formalized Young's inequality instead. | ✅ `∃ g h, MemLp g 1 μ ∧ MemLp h p μ ∧ ∀ᵐ x ∂μ, groupConv μ g h x = f x`. ❗ Highest-value trap. |
| 2 | Faithful encoding | Equality of the factorization is in `𝓛ᵖ`, i.e. almost everywhere, not pointwise everywhere. | ✅ `∀ᵐ x ∂μ`. ❗ Predicted error: `∀ x`, which is false since convolution is only defined a.e. |
| 3 | Hypothesis completeness | $1 \le p < \infty$: the case $p = \infty$ is a *different* assertion in the theorem (it yields $C_{lu}(G)$, not $\mathcal{L}^\infty$). | ✅ `hp : 1 ≤ p` and `hp' : p ≠ ∞`. ❗ Predicted error: allowing `p = ⊤`, which makes the statement false. |
| 4 | Conclusion completeness | Folland's theorem also covers $\mathcal{L}^1 * \mathcal{L}^\infty = C_{lu}(G)$ and the right-handed versions. | ⚠️ Only the $\mathcal{L}^p$ clause is formalized; the uniform-continuity clauses would need $C_{lu}$, $C_{ru}$ and are recorded in the `.md` but not in Lean. |
| 5 | Junk values | `groupConv` returns `0` off the integrability locus; the hypotheses on `g` and `h` plus the a.e. equality keep the factorization meaningful. | ⚠️ Safe under the stated memberships. |
