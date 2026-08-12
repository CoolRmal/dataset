# Criteria: hayman_2_5_deficient_small_functions

**Statement:** [hayman_2_5_deficient_small_functions.md](hayman_2_5_deficient_small_functions.md) · **Lean:** [hayman_2_5_deficient_small_functions.lean](hayman_2_5_deficient_small_functions.lean)

Three *functions* — not constants — that grow more slowly than $f$ cannot all be deficient. The hypotheses are that the $a_\nu$ are distinct meromorphic functions with $T(r,a_\nu) = o(T(r,f))$, and the conclusion bounds $\{1+o(1)\}T(r,f)$ by the reduced counting functions of $f - a_\nu$ plus $S(r,f)$. Replacing the $a_\nu$ by constants gives the much easier three-constant case of the second fundamental theorem.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Semantic closeness / scope | The $a_\nu$ must be allowed to be non-constant meromorphic functions; that is the whole point of §2.6. | ✅ `a : Fin 3 → ℂ → ℂ` with `ha : ∀ ν, Meromorphic (a ν)`. ❗ Predicted error: `a : Fin 3 → ℂ`. |
| 2 | Hypothesis completeness | Distinctness of the three functions, admissibility of $f$, and the smallness condition (2.10) are all required. | ✅ `hdistinct`, `hadm`, `hsmall`. ❗ Predicted error: dropping (2.10), which makes the conclusion false (take $a_\nu = f + \nu$). |
| 3 | Faithful encoding | $\bar N(r, 1/(f-a_\nu))$ is the reduced counting function of the **zeros** of $f - a_\nu$. | ✅ `reducedLogCounting (fun z ↦ f z - a ν z) 0`. ❗ Predicted error: counting the $a_\nu$-points of $f$ with multiplicity, i.e. `logCounting` rather than the reduced version. |
| 4 | Faithful encoding / the error term | The book's `{1+o(1)}T(r,f) ≤ ∑ N̄ + S(r,f)` is rendered by absorbing both `o(1)` and `S(r,f)` into an arbitrary `ε`: for every `ε > 0`, eventually `(1-ε)T ≤ ∑ N̄ + εT`. | ⚠️ Faithful only because admissibility forces `S(r,f) = o(T(r,f))` (Theorem 2.2); a candidate that quantifies `S` explicitly is closer to the text. |
| 5 | Junk values | `reducedLogCounting` is an integral of a `Set.ncard`; both degenerate silently on infinite root sets. | ⚠️ Controlled by the meromorphy hypotheses. |
