# Criteria: hasLusinPropertyN_iff_maps_nullMeasurableSet

**Statement:** [hasLusinPropertyN_iff_maps_nullMeasurableSet.md](hasLusinPropertyN_iff_maps_nullMeasurableSet.md) · **Lean:** [hasLusinPropertyN_iff_maps_nullMeasurableSet.lean](hasLusinPropertyN_iff_maps_nullMeasurableSet.lean)

## What the theorem says

A map $F$ of $\mathbb{R}^n$ to itself has Lusin's property (N) when it sends every set of Lebesgue
measure zero to a set of Lebesgue measure zero. Theorem 3.6.9 says that, for a Lebesgue measurable
$F$, this happens exactly when $F$ sends every Lebesgue measurable set to a Lebesgue measurable set.
Everything here is about the Lebesgue $\sigma$-algebra — the completion — and not about Borel sets:
images of Borel sets under measurable maps are generally analytic and not Borel, so the Borel
version of the right-hand side would be a different claim.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The dimension $n$ is arbitrary, and both the source and the target are $\mathbb{R}^n$ with Lebesgue measure. | ✅ `{n : ℕ}` and `F : (Fin n → ℝ) → (Fin n → ℝ)` with `volume`. |
| 2 | $F$ is Lebesgue measurable, i.e. measurable for the completed $\sigma$-algebra — not Borel measurable. | ✅ `hF : NullMeasurable F volume`. |
| 3 | Property (N) says: every Lebesgue-null set has null image. | ✅ `HasLusinPropertyN F volume volume`, defined as `∀ A, NullMeasurableSet A μ → μ A = 0 → ν (F '' A) = 0`. |
| 4 | The image in property (N) is measured without assuming it is measurable. | ✅ `ν (F '' A)`; Mathlib measures apply to any set as outer measures. |
| 5 | The other side of the equivalence quantifies over all Lebesgue measurable sets $A$. | ✅ `∀ A : Set (Fin n → ℝ), NullMeasurableSet A volume → …`. |
| 6 | Its conclusion is that the image $F(A)$ is again Lebesgue measurable. | ✅ `NullMeasurableSet (F '' A) volume`. |
| 7 | The statement is a biconditional — "precisely when" — so both directions are asserted. | ✅ Stated with `↔`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Assuming `Measurable F`, i.e. Borel measurability. | Strictly narrower than the book's Lebesgue measurable, so the theorem proved is a special case. |
| 2 | Concluding that $F(A)$ is a Borel set (`MeasurableSet (F '' A)`). | Almost never true: images of Borel sets under Borel maps are analytic, and there are analytic sets that are not Borel. The right-hand side of the equivalence would then be false in cases where the theorem says it holds. |
| 3 | Quantifying the left-hand side over Borel null sets only. | The definition of property (N) is about null sets of the completed $\sigma$-algebra, which include all subsets of Borel null sets. Restricting to Borel sets weakens property (N) and breaks the equivalence. |
| 4 | Adding a measurability hypothesis on $F(A)$ inside property (N). | Property (N) is a statement about outer measure and assumes nothing about the image. Adding the hypothesis makes the condition weaker for free. |
| 5 | Stating only one direction of the equivalence. | The book says "precisely when". |
| 6 | Fixing $n = 1$ or working on $\mathbb{R}$ instead of $\mathbb{R}^n$. | Loses the general statement. |
| 7 | Formalizing property (N) for the restriction of $F$ to a set, or for a different pair of measures. | Theorem 3.6.9 is about property (N) with respect to the pair (Lebesgue, Lebesgue) on all of $\mathbb{R}^n$. |

## Notes on the ground truth

- `HasLusinPropertyN` is defined in `Defs.lean` in the general two-measure form of Definition 3.6.8
  and the theorem instantiates both measures to `volume`, so the definition is reusable (problem
  5.5.4 uses the relative version `HasLusinPropertyNOn`).
- $\mathbb{R}^n$ is modelled as `Fin n → ℝ` with `volume`, the product Lebesgue measure.
  `EuclideanSpace ℝ (Fin n)` would give the same measure space, and the statement does not mention
  norms, so either is fine.
- In `HasLusinPropertyN`, the clause `NullMeasurableSet A μ` is redundant next to `μ A = 0`: any set
  of outer measure zero is already null-measurable. Keeping it does no harm and mirrors the book's
  "for every set $A \in \mathcal{A}$ with $\mu(A) = 0$".
- Lebesgue measurability of a *set* is `NullMeasurableSet A volume`, which says $A$ differs from a
  Borel set by a null set — the standard description of the completed $\sigma$-algebra. Lebesgue
  measurability of the *map* is `NullMeasurable F volume`.
