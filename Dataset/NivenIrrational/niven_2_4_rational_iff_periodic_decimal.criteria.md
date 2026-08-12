# Criteria: niven_2_4_rational_iff_periodic_decimal

**Statement:** [niven_2_4_rational_iff_periodic_decimal.md](niven_2_4_rational_iff_periodic_decimal.md) · **Lean:** [niven_2_4_rational_iff_periodic_decimal.lean](niven_2_4_rational_iff_periodic_decimal.lean)

The proposition is an **equivalence**, and the book's §2.5 is devoted to folding "terminating" into "periodic" by appending zeros — so the right-hand side is a single condition, eventual periodicity, not a disjunction. The hard direction is periodic ⟹ rational; rational ⟹ periodic is the long-division argument.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Conclusion completeness | Both directions are required; the statement is `↔`. | ✅ `(∃ q : ℚ, x = q) ↔ EventuallyPeriodic (decimalDigit x)`. ❗ Predicted error: only the easy direction. |
| 2 | Faithful encoding / periodicity | "Eventually periodic" means `∃ N p, 0 < p ∧ ∀ k ≥ N, d (k+p) = d k`. The period must be **positive** and the repetition must start from some point, not from `0`. | ✅ `EventuallyPeriodic`. ❗ Predicted error: `p = 0` allowed, which makes the condition vacuous for every sequence. |
| 3 | Faithful encoding / digits | `decimalDigit x k = ⌊10^{k+1} x⌋.toNat % 10` is the `k`-th digit after the point. The `.toNat` is safe only because `x ≥ 0`. | ⚠️ The hypothesis `x ∈ Ico 0 1` is what keeps the floor non-negative and the expansion the standard one; without it `Int.toNat` truncates negatives to `0`. |
| 4 | Hypothesis completeness | Restricting to `[0,1)` is a normalisation, not a loss: the integer part contributes no digits after the point. | ⚠️ The book states the proposition for arbitrary rationals `a/b`; the Lean version normalises. A candidate handling all of `ℝ` is closer to the text. |
| 5 | Semantic closeness | Terminating expansions are the eventually-periodic ones with repeating digit `0`, exactly as §2.5 arranges. | ✅ Recorded in the `.md` notation block; no separate disjunct is needed. |
