# Criteria: bogachev_4_5_9_de_la_vallee_poussin

**Statement:** [bogachev_4_5_9_de_la_vallee_poussin.md](bogachev_4_5_9_de_la_vallee_poussin.md) · **Lean:** [bogachev_4_5_9_de_la_vallee_poussin.lean](bogachev_4_5_9_de_la_vallee_poussin.lean)

## What the theorem says

Work with a finite measure and a family of integrable functions. The family is uniformly integrable
exactly when there is a single test function $G$ on $[0,\infty)$ that grows faster than linearly —
$G(t)/t \to \infty$ — such that the integrals $\int G(\lvert f\rvert)\,d\mu$ stay bounded over the
whole family. The same $G$ has to work for every member of the family; that uniform bound is the
content. The theorem adds that whenever the family is uniformly integrable, $G$ can be taken convex
as well as increasing.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The measure is finite and nonnegative. | ✅ `[IsFiniteMeasure μ]`. |
| 2 | The family consists of $\mu$-integrable functions. | ✅ `hF : ∀ i, Integrable (F i) μ`. |
| 3 | The statement is an "if and only if" between uniform integrability of the family and existence of $G$. | ✅ `UniformIntegrable F 1 μ ↔ ∃ G, …`. |
| 4 | $G$ is nonnegative on $[0,\infty)$. | ✅ `∀ t : ℝ, 0 ≤ t → 0 ≤ G t` inside `superlinear`. |
| 5 | $G$ is increasing on $[0,\infty)$. | ✅ `MonotoneOn G (Ici (0 : ℝ))`. |
| 6 | $G$ grows faster than linearly: $G(t)/t \to \infty$ as $t \to \infty$. | ✅ `Tendsto (fun t ↦ G t / t) atTop atTop`. |
| 7 | One bound works for the whole family: $\sup_f \int G(\lvert f\rvert)\,d\mu < \infty$. | ⚠️ `∃ C : ℝ≥0, ∀ i, ∫⁻ x, ENNReal.ofReal (G \|F i x\|) ∂μ ≤ C`. Equivalent to the printed supremum, but `⨆ i, ∫⁻ … < ∞` would read closer to the text. |
| 8 | The integral $\int G(\lvert f\rvert)\,d\mu$ is taken in a way that stays meaningful when it is infinite. | ✅ The lower Lebesgue integral `∫⁻ … ∂μ` valued in `ℝ≥0∞`. |
| 9 | The second part: when the family is uniformly integrable, such a $G$ can additionally be chosen convex. | ✅ A second conjunct `UniformIntegrable F 1 μ → ∃ G, superlinear G ∧ ConvexOn ℝ (Ici (0 : ℝ)) G ∧ …`. |
| 10 | All conditions on $G$ are stated on $[0,\infty)$ only, since $G$ is a function on the half-line. | ✅ Every condition is guarded by `0 ≤ t` or restricted to `Ici (0 : ℝ)`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Dropping superlinearity of $G$, keeping only "nonnegative increasing". | The criterion collapses: $G(t) = t$ then works for any $L^1$-bounded family, uniformly integrable or not. |
| 2 | Writing $\int G(\lvert f\rvert)\,d\mu$ as a Bochner integral `∫`. | Lean gives a non-integrable integrand the value $0$, so a family with genuinely infinite integrals would appear to satisfy the bound and the "if" direction would be corrupted. |
| 3 | Omitting the hypothesis that the family is $\mu$-integrable. | Observed in practice: a model dropped it, apparently assuming `UniformIntegrable` covers it. It does in the forward direction, but in the reverse direction uniform integrability is the *conclusion*, so nothing else supplies measurability of the $F i$. |
| 4 | Formalizing only the equivalence and dropping the "one can choose $G$ convex" refinement. | Half the exercise. The convexity clause is a separate assertion. |
| 5 | Giving each $f$ its own $G$, i.e. `∀ i, ∃ G, …`. | The bound has to be uniform over the family. With one $G$ per function the criterion is true for any family of integrable functions and says nothing. |
| 6 | Requiring $G$ to be increasing or convex on all of $\mathbb{R}$. | In the reverse direction the conditions on $G$ are obligations one must supply, so demanding more of $G$ than the book does weakens that direction of the equivalence. |
| 7 | Replacing `[IsFiniteMeasure μ]` with an ad-hoc `μ Set.univ < ⊤`, or hand-rolling uniform integrability as an $\varepsilon$–$\delta$ formula. | Not wrong mathematically, but it should be checked against Mathlib's `UniformIntegrable F 1 μ`, which for a finite measure is the textbook notion. A hand-rolled version that omits the $L^1$ bound is a different property. |

## Notes on the ground truth

- `UniformIntegrable F 1 μ` in Mathlib unfolds to three things: each $F i$ is a.e. strongly
  measurable, the family is uniformly integrable in the $\varepsilon$–$\delta$ sense, and the
  $L^1$ norms are bounded. For a finite measure this matches Bogachev's definition.
- The family is indexed, `F : ι → Ω → ℝ`, rather than being a `Set` of functions. The two readings
  are interchangeable and the indexed one is the Mathlib convention.
- The three properties of $G$ are bundled by a `let superlinear := …` inside the statement so that
  both halves can reuse them.
- `ENNReal.ofReal` sends negative reals to $0$. That never bites here because $G$ is nonnegative on
  $[0,\infty)$ and it is only applied at $\lvert F i x\rvert \ge 0$.
- The second conjunct restates the existence from scratch rather than asserting that the *same* $G$
  found in the first part is convex. That is the correct reading of "in such a case, one can choose
  a convex increasing function $G$".
