# Criteria: hayman_2_7_fixpoints_of_entire_functions

**Statement:** [hayman_2_7_fixpoints_of_entire_functions.md](hayman_2_7_fixpoints_of_entire_functions.md) · **Lean:** [hayman_2_7_fixpoints_of_entire_functions.lean](hayman_2_7_fixpoints_of_entire_functions.lean)

The statement is about fix-points of **exact** order $n$ — points fixed by the $n$-th iterate but by no earlier one — and asserts that the set of $n$ for which there are only finitely many such points has at most one element. Both the exactness and the "at most one exception" are load-bearing: $f(z) = e^{g(z)}+z$ has no fix-points of order one, so an exception genuinely occurs.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Faithful encoding / exact order | A fix-point of exact order $n$ satisfies $f_n(\zeta)=\zeta$ and $f_m(\zeta)\ne\zeta$ for $1\le m<n$. Dropping the minimality gives fix-points of order $n$, a different and larger set. | ✅ `{z \| iter n z = z ∧ ∀ m, 1 ≤ m → m < n → iter m z ≠ z}`. ❗ Highest-value trap. |
| 2 | Conclusion completeness | The exceptional set of orders is a `Subsingleton` — at most one $n$. Asserting no exception is false. | ✅ `Set.Subsingleton`. ❗ Predicted error: `= ∅`. |
| 3 | Faithful encoding / iteration | The iterates are Hayman's $f_1 = f$, $f_{\nu+1} = f \circ f_\nu$; the recursion must be supplied since `iter` is a hypothesis, not a definition. | ✅ `h₁ : ∀ z, iter 1 z = f z` and `hstep : ∀ n z, iter (n+1) z = f (iter n z)`. ⚠️ Using `Function.iterate` would be more idiomatic and would remove two hypotheses. |
| 4 | Hypothesis completeness | $f$ must be a *transcendental integral* function: entire and not a polynomial. | ✅ `IsTranscendentalEntire f`. ❗ Predicted error: allowing polynomials, for which the theorem fails ($f(z)=z$). |
| 5 | Semantic closeness | Only orders $n \ge 1$ are meaningful. | ✅ The exceptional set is cut down by `1 ≤ n`. |
