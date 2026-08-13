# Criteria: conway_V_13_3_james

**Statement:** [conway_V_13_3_james.md](conway_V_13_3_james.md) · **Lean:** [conway_V_13_3_james.lean](conway_V_13_3_james.lean)

## What the theorem says

Let $A$ be a closed convex subset of a Banach space $\mathcal{X}$. Suppose every continuous linear
functional $x^*$ on $\mathcal{X}$ attains, at some point of $A$, the largest value that
$\lvert\langle x, x^*\rangle\rvert$ takes on $A$. Then $A$ is compact in the weak topology. This is
one direction of James's theorem; it is the hard and useful direction.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The ambient space is a Banach space: normed over $\mathbb{C}$ and complete. | ✅ `[NormedAddCommGroup E] [NormedSpace ℂ E] [CompleteSpace E]`. |
| 2 | $A$ is norm-closed. | ✅ `hAclosed : IsClosed A`. |
| 3 | $A$ is convex. | ✅ `hAconvex : Convex ℝ A`. |
| 4 | The attainment hypothesis ranges over the whole dual space. | ✅ `∀ φ : E →L[ℂ] ℂ` — Mathlib's `E →L[ℂ] ℂ` is exactly $\mathcal{X}^*$. |
| 5 | For each functional there is a point of $A$ where the modulus $\lvert\langle x, x^*\rangle\rvert$ is largest over $A$. | ✅ `∃ x₀ ∈ A, ∀ x ∈ A, ‖φ x‖ ≤ ‖φ x₀‖`. |
| 6 | The quantity being maximised is the *modulus* of the scalar, not the scalar itself. | ✅ `‖φ x‖`, which for a complex number is its absolute value. |
| 7 | The conclusion is that $A$ itself is compact in the weak topology. | ✅ `IsCompact (toWeakSpace ℂ E '' A)`, i.e. compactness of the transported set inside `WeakSpace ℂ E`. |
| 8 | The theorem is a single implication in the stated direction. | ✅ Hypotheses to the left of the colon, one conclusion. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Writing the attainment hypothesis as `‖φ x₀‖ = sSup {‖φ x‖ \| x ∈ A}`. | Lean gives `sSup` a default value of $0$ when the set is empty or unbounded above. If the image of $A$ under some functional is unbounded, the equation can be satisfied by junk — for instance with $\varphi = 0$ and any $x_0$ — so the hypothesis becomes easier to meet than the book's and the theorem stated is not James's. A `BddAbove` guard would be needed to make this spelling safe. |
| 2 | Dropping `Convex ℝ A`. | The statement becomes false: the unit sphere of a reflexive space satisfies the attainment hypothesis but is not weakly compact. |
| 3 | Dropping `CompleteSpace E`. | James's theorem is known to fail for incomplete normed spaces. |
| 4 | Concluding `IsCompact A` in `E`. | That is norm compactness, which is much stronger than weak compactness and is not what the theorem gives. |
| 5 | Concluding compactness of `closure (toWeakSpace ℂ E '' A)`. | Weaker than the printed conclusion, and it throws away the point that a closed convex set is already weakly closed, so its weak closure adds nothing. |
| 6 | Restricting the hypothesis to functionals with `‖φ‖ = 1`, or to a norming subset. | That changes the hypothesis. (The unit-norm restriction happens to be equivalent by homogeneity, but a general norming subset is not.) |
| 7 | Writing the attainment as `φ x ≤ φ x₀`, dropping the modulus. | Over $\mathbb{C}$ this is not even well formed. Over $\mathbb{R}$ it states the different "sup without modulus" variant of James's theorem. |
| 8 | Attempting `Convex ℂ A`. | Mathlib's `Convex` needs an ordered field of scalars, so the complex version does not typecheck. Convexity of a subset of a complex space is `Convex ℝ A`. |

## Notes on the ground truth

- Writing the hypothesis in attainment form — "there is a point of $A$ at which no other point of
  $A$ beats it" — never forms a supremum at all, so the junk value described in Mistake 1 cannot
  arise. This is the main modelling choice in the file.
- The same form also reproduces the book's behaviour when $A$ is empty: both "there is an $x_0$ in
  $A$" and `∃ x₀ ∈ A` fail, so the theorem is not asserted there. No convention for $\sup \emptyset$
  is involved.
- The converse — weakly compact implies every functional attains its supremum — is true but is not
  what V.13.3 asserts. ⚠️ A candidate stating the `↔` is still a true theorem; treat it as
  over-strong relative to the text rather than as wrong.
