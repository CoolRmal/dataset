# Criteria: hayman_2_9_polya_composition_order

**Statement:** [hayman_2_9_polya_composition_order.md](hayman_2_9_polya_composition_order.md) · **Lean:** [hayman_2_9_polya_composition_order.lean](hayman_2_9_polya_composition_order.lean)

Pólya's dichotomy: finite order of a composition forces the inner function to be a polynomial or the outer one to have order zero. The two growth notions must be kept distinct — "finite order" is $\log M(r) = O(r^k)$ for *some* $k$, "zero order" is $O(r^\varepsilon)$ for *every* $\varepsilon>0$ — and the conclusion is a disjunction, not a conjunction.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Conclusion completeness | The conclusion is `f polynomial ∨ g has zero order`; both branches occur. | ✅ As written. ❗ Predicted error: concluding only that `f` is a polynomial. |
| 2 | Faithful encoding / growth | Finite order and zero order differ by the quantifier on the exponent. Collapsing them makes the statement trivial or false. | ✅ `HasFiniteOrder` uses `∃ k`, `HasZeroOrder` uses `∀ ε > 0`, both stated through `M(r)` as a bound on `‖f z‖` for `‖z‖ ≤ r`. ❗ Predicted error: defining order by a `limsup` of `log log M / log r` and then mishandling its junk value for bounded `f`. |
| 3 | Hypothesis completeness | Both $f$ and $g$ must be entire; the hypothesis is on the composition $g \circ f$, not on $f$ or $g$ separately. | ✅ `hf`, `hg`, `hcomp : HasFiniteOrder (g ∘ f)`. ❗ Predicted error: assuming `HasFiniteOrder f`. |
| 4 | Junk values | `HasFiniteOrder` is stated as an eventual pointwise bound rather than through a `limsup`, so no junk supremum arises. | ✅ Junk-free by construction. |
| 5 | Semantic closeness | "Integral function" is Hayman's term for an entire function. | ✅ `Differentiable ℂ f` on all of `ℂ`. |
