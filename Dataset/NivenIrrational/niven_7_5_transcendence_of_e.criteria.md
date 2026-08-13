# Criteria: niven_7_5_transcendence_of_e

**Statement:** [niven_7_5_transcendence_of_e.md](niven_7_5_transcendence_of_e.md) · **Lean:** [niven_7_5_transcendence_of_e.lean](niven_7_5_transcendence_of_e.lean)

## What the theorem says

The number $e$ is transcendental: there is no non-zero polynomial with rational coefficients having
$e$ as a root. Equivalently, no relation $a_n e^n + \cdots + a_1 e + a_0 = 0$ with integer
coefficients, not all zero, can hold. This is Hermite's theorem and the deepest result in Niven's
book — much stronger than the irrationality of $e$, which only rules out relations of degree $1$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The number is $e$, the base of natural logarithms. | ✅ `Real.exp 1`. Mathlib has no separate constant `Real.e`. |
| 2 | The claim is transcendence, not irrationality. | ✅ `Transcendental ℚ (Real.exp 1)`, which unfolds to `¬ IsAlgebraic ℚ (Real.exp 1)`. |
| 3 | The coefficient field is $\mathbb{Q}$. | ✅ The first argument of `Transcendental` is `ℚ`. |
| 4 | The polynomial ruled out must be non-zero. | ✅ Built into Mathlib's `IsAlgebraic`, whose existential requires `p ≠ 0`. |
| 5 | The statement is unconditional. | ✅ The theorem takes no arguments. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Writing `Transcendental ℝ (Real.exp 1)`. | False. Over $\mathbb{R}$ every real number is a root of $X - a$, so no real is transcendental over $\mathbb{R}$. |
| 2 | Concluding `Irrational (Real.exp 1)`. | Far weaker. Irrationality only says $e$ is not a root of a degree-$1$ rational polynomial; transcendence rules out every degree. |
| 3 | Hand-rolling the statement as `¬ ∃ p : Polynomial ℚ, p.eval (Real.exp 1) = 0` without requiring `p ≠ 0`. | The zero polynomial evaluates to $0$ at every point, so this claim is false for every real number and could never be proved. |
| 4 | Using a different number, such as `Real.exp 2` or `Real.log (Real.exp 1)`. | Not $e$. The second is $1$, which is algebraic, so the claim would be false. |
| 5 | Adding hypotheses, for instance assuming the transcendence of $\pi$ or of $e$ itself. | The statement is closed. Assuming what is to be proved makes the theorem empty. |
| 6 | Stating that $e$ is not the root of any *integer* polynomial of degree at most some fixed $n$. | A bounded-degree version is strictly weaker than transcendence. |

## Notes on the ground truth

- Mathlib contains only the analytical half of the Lindemann–Weierstrass circle of ideas
  (`NumberTheory/Transcendental/Lindemann/AnalyticalPart.lean`); the transcendence of $e$ itself is
  not available there, so this is a genuine target rather than a one-line lookup.
- Stating it over `ℤ` instead of `ℚ` would be equivalent — clear denominators — and is not counted
  as an error, but `ℚ` is the standard Mathlib phrasing and matches the `.md` notation block.
- The statement is a single line by design; all of Niven's §7.5 machinery belongs to the proof.
