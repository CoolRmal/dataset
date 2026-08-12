# Criteria: bogachev_gaussian_4_6_1_correlation_convex_strip

**Statement:** [bogachev_gaussian_4_6_1_correlation_convex_strip.md](bogachev_gaussian_4_6_1_correlation_convex_strip.md) · **Lean:** [bogachev_gaussian_4_6_1_correlation_convex_strip.lean](bogachev_gaussian_4_6_1_correlation_convex_strip.lean)

A faithful formalization must state the correlation inequality $\gamma(A \cap \Pi) \ge \gamma(A)\gamma(\Pi)$ for an **absolutely convex** set $A$ and a **symmetric strip** $\Pi = \{|f| \le c\}$ determined by a linear functional. This is the Khatri–Šidák case of the Gaussian correlation problem; Bogachev explicitly records that the general absolutely convex case was open, so a candidate that states it for two arbitrary absolutely convex sets is formalizing a conjecture rather than this theorem.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Semantic closeness / scope | One of the two sets must be a strip. Replacing $\Pi$ by a second absolutely convex set states the (then open) Gaussian correlation conjecture, not Theorem 4.6.1. | ❗ Highest-value trap. ✅ The ground truth keeps `{x \| \|f x\| ≤ c}` with `f` linear. |
| 2 | Hypothesis completeness | $A$ must be convex **and** balanced, and $\gamma$ must be centered. | ✅ `hconv`, `hbal`, `hcentered`. ❗ Predicted error: dropping balancedness, which already fails for a translated convex set. |
| 3 | Faithful encoding | $\Pi$ is cut out by a **linear** functional (not affine), and the inequality is non-strict. | ✅ `f : EuclideanSpace ℝ (Fin n) →ₗ[ℝ] ℝ` and `≤`. ⚠️ Continuity is automatic in finite dimensions, so the plain `→ₗ[ℝ]` is adequate. |
| 4 | Mathlib conventions | The product of two measure values lives in `ℝ≥0∞`; the inequality is written with the smaller side on the left. | ✅ `γ A * γ {x \| \|f x\| ≤ c} ≤ γ (A ∩ {x \| \|f x\| ≤ c})`. |
| 5 | Junk values | `ℝ≥0∞` multiplication has `0 * ∞ = 0`, but $\gamma$ is a probability measure so all four quantities lie in $[0,1]$ and no truncation occurs. | ✅ Safe. |
| 6 | Hypothesis completeness | $c$ is an arbitrary real, including $c < 0$ where $\Pi = \emptyset$ and the inequality is trivial. | ✅ No constraint on `c`, matching the text. |
