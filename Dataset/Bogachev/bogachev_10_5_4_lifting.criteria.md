# Criteria: bogachev_10_5_4_lifting

**Statement:** [bogachev_10_5_4_lifting.md](bogachev_10_5_4_lifting.md) · **Lean:** [bogachev_10_5_4_lifting.lean](bogachev_10_5_4_lifting.lean)

## What the theorem says

A bounded measurable function is normally only pinned down up to a set of measure zero, so it has
many equally good representatives. A *lifting* picks one representative out of each class, for all
classes at once, and does so compatibly with the algebra: the chosen representatives of $f+g$,
of $\alpha f$, and of $fg$ are literally the sum, multiple and product of the chosen
representatives, at every single point — not just almost everywhere. The theorem says such a choice
exists for every complete probability measure.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $\mu$ is a probability measure. | ✅ `[IsProbabilityMeasure μ]`. |
| 2 | $\mu$ is complete, i.e. every subset of a null set is measurable. | ✅ `[μ.IsComplete]`. |
| 3 | The lifting is a map from functions to functions, not from a.e.-classes to a.e.-classes. | ✅ `toFun : (X → ℝ) → X → ℝ`. |
| 4 | It sends bounded measurable functions to bounded measurable functions. | ✅ `maps_bounded_measurable`. |
| 5 | Condition (i): $L(f) = f$ almost everywhere. This one is the a.e. statement. | ✅ `representative : toFun f =ᵐ[μ] f`. |
| 6 | Condition (ii): if $f = g$ a.e. then $L(f)$ and $L(g)$ are the same function at every point. | ✅ `congr_ae : … → toFun f = toFun g`. |
| 7 | Condition (iii): if $f = 1$ a.e. then $L(f)$ is the constant $1$ at every point. | ✅ `map_ae_one : … → toFun f = (1 : X → ℝ)`. |
| 8 | Condition (iv): linearity, holding at every point — both $L(f+g) = L(f)+L(g)$ and $L(\alpha f) = \alpha L(f)$ for real $\alpha$. | ✅ `map_add` and `map_smul`, both exact equalities of functions. |
| 9 | Condition (v): $L(fg) = L(f)L(g)$ at every point. | ✅ `map_mul`. |
| 10 | Every condition is stated only for arguments that are bounded and measurable, since that is the book's space $\mathcal{L}^\infty_{\mathcal{A}}$. | ✅ Each field carries the guard `Measurable f ∧ ∃ C : ℝ, ∀ x, \|f x\| ≤ C`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Typing the lifting as `Lp ℝ ∞ μ → Lp ℝ ∞ μ`, a map between spaces of a.e.-classes. | On classes there is nothing to say: the identity map satisfies every condition. The whole content is the pointwise choice, and conditions (ii)–(v) cannot even be written down on classes. |
| 2 | Writing conditions (ii)–(v) with `=ᵐ[μ]` instead of exact equality. | The identity map then satisfies all of them, so the theorem becomes trivially true. Only condition (i) is an a.e. statement. |
| 3 | Dropping the completeness hypothesis on $\mu$. | This is the hypothesis models omit most often. The theorem is stated and proved for complete measures. |
| 4 | Dropping condition (iii), or folding it into condition (i). | Unitality does not follow from the other four conditions as stated; a lifting is required to send the class of $1$ to the genuine constant function $1$. |
| 5 | Stating the conditions for arbitrary $f : X \to \mathbb{R}$ with no boundedness or measurability guard. | That asserts a lifting defined on all real-valued functions, a much stronger claim than the printed one. |
| 6 | Replacing the probability hypothesis with $\sigma$-finiteness or nothing at all. | The theorem as printed is about a complete probability measure; a weaker hypothesis states a different result. |
| 7 | Requiring only additivity and forgetting scalars, or vice versa. | The book's (iv) is $L(\alpha f + \beta g) = \alpha L(f) + \beta L(g)$, which needs both halves. |

## Notes on the ground truth

- The five book conditions are packaged as a structure `LInfinityLifting μ` in `Defs.lean`, and the
  theorem concludes `Nonempty (LInfinityLifting μ)`. An unfolded `∃ L : (X → ℝ) → X → ℝ, …` with a
  seven-way conjunction says exactly the same thing and is equally acceptable.
- Because Lean functions are total, membership in $\mathcal{L}^\infty_{\mathcal{A}}$ is expressed by
  repeating the guard `Measurable f ∧ ∃ C : ℝ, ∀ x, |f x| ≤ C` on each field. A subtype
  `{f : X → ℝ // Measurable f ∧ …}` would avoid the repetition; the guarded form was chosen because
  it keeps the pointwise algebra (`f + g`, `f * g`, `c • f`) readable.
- "Bounded" is taken as bounded at every point, not just essentially bounded. That matches the
  book's $\mathcal{L}^\infty_{\mathcal{A}}$, which is the space of bounded measurable functions.
- The book's single linearity condition (iv) is split into `map_add` and `map_smul`. Together they
  give the printed statement.
