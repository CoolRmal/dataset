# Criteria: niven_C_5_transcendentals_uncountable

**Statement:** [niven_C_5_transcendentals_uncountable.md](niven_C_5_transcendentals_uncountable.md) · **Lean:** [niven_C_5_transcendentals_uncountable.lean](niven_C_5_transcendentals_uncountable.lean)

## What the theorem says

A real number is algebraic if it is a root of some non-zero polynomial with rational coefficients,
and transcendental otherwise. Cantor's counting argument shows there are only countably many
algebraic numbers — countably many polynomials, each with finitely many roots — while the reals are
uncountable. Removing a countable set from an uncountable one leaves an uncountable set, so the
transcendental reals are uncountable. In particular there are transcendental numbers, even though the
argument exhibits none.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The set under discussion is the set of transcendental **real** numbers. | ✅ `{x : ℝ \| Transcendental ℚ x}`. |
| 2 | Transcendence is over $\mathbb{Q}$. | ✅ `Transcendental ℚ x`, which is Mathlib's `¬ IsAlgebraic ℚ x`. |
| 3 | The claim is that this set is uncountable, i.e. not countable. | ✅ `¬ {x : ℝ \| Transcendental ℚ x}.Countable`. |
| 4 | The claim is about the transcendentals, not about all reals and not about the algebraics. | ✅ The set comprehension picks out exactly the transcendentals. |
| 5 | The statement is unconditional. | ✅ The theorem takes no arguments. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Asserting `¬ (Set.univ : Set ℝ).Countable`. | That is Theorem C.4, the uncountability of the reals — an ingredient of the proof, not the statement. |
| 2 | Asserting that the algebraic numbers are countable. | The other ingredient. True and already in Mathlib, but it is not Theorem C.5. |
| 3 | Writing `Transcendental ℝ x` in the set-builder. | Over $\mathbb{R}$ no real is transcendental, so the set is empty and therefore countable; the claim would be false. |
| 4 | Concluding that the set is infinite rather than uncountable. | Much weaker. Infinitude alone does not distinguish the transcendentals from the algebraics, which are also infinite. |
| 5 | Concluding that the set is countable, or omitting the negation. | The sign is the whole statement. |
| 6 | Claiming merely that a transcendental number exists. | A consequence, and a much weaker one. Cantor's point is that the transcendentals are the overwhelming majority. |

## Notes on the ground truth

- "Uncountable" is written as `¬ Set.Countable`. Mathlib's `Set.Countable` includes finite sets, so
  its negation is the right notion of uncountable.
- Stating it as `Uncountable {x : ℝ // Transcendental ℚ x}` (the typeclass on the subtype) would say
  the same thing and is not counted as an error.
- Honest assessment: Mathlib already has both halves — the countability of the algebraic numbers and
  the uncountability of `ℝ` — so this is a short consequence rather than a deep result. It is
  included because Niven states it as Theorem C.5.
