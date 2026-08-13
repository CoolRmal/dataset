# Criteria: niven_5_5_squaring_the_circle_impossible

**Statement:** [niven_5_5_squaring_the_circle_impossible.md](niven_5_5_squaring_the_circle_impossible.md) · **Lean:** [niven_5_5_squaring_the_circle_impossible.lean](niven_5_5_squaring_the_circle_impossible.lean)

## What the theorem says

Squaring the circle means building a square whose area equals that of a circle of radius $1$. That
area is $\pi$, so the side of the square must have length $\sqrt\pi$. Niven grants — without proving
it — that $\pi$ is transcendental, meaning it satisfies no polynomial equation with rational
coefficients. Then $\sqrt\pi$ is transcendental too, so it is not algebraic at all, let alone of
degree a power of $2$. By the Theorem on Geometric Constructions it cannot be built with straightedge
and compass.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The transcendence of $\pi$ over $\mathbb{Q}$ appears as a hypothesis, matching the book's "granted that". | ✅ `hpi : Transcendental ℚ Real.pi`. |
| 2 | The length to be constructed is $\sqrt\pi$, not $\pi$. | ✅ `Real.sqrt Real.pi`. |
| 3 | The conclusion is non-constructibility. | ✅ `¬ IsConstructible (Real.sqrt Real.pi)`. |
| 4 | "Constructible" is the shared straightedge-and-compass class. | ✅ `IsConstructible` from `Defs.lean`. |
| 5 | The transcendence is over the rationals, not over the reals. | ✅ `Transcendental ℚ`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Dropping the hypothesis `hpi`. | The resulting statement is true but is not Niven's. His argument is explicitly conditional, and neither this file nor Mathlib supplies the transcendence of $\pi$, so the `sorry` would then stand for the whole of Lindemann's theorem rather than for §5.5. |
| 2 | Concluding `¬ IsConstructible Real.pi`. | A different statement. It is also true, but the quadrature asks for the *side* of the square, which is $\sqrt\pi$. |
| 3 | Concluding `Irrational (Real.sqrt Real.pi)`. | Much weaker, and irrationality does not obstruct construction: $\sqrt2$ is irrational and constructible. |
| 4 | Using `Irrational Real.pi` as the hypothesis instead of transcendence. | Too weak. An irrational number can be algebraic and constructible; the argument needs that $\pi$ satisfies no rational polynomial at all. |
| 5 | Writing `Transcendental ℝ Real.pi`. | False. Every real number is a root of $X - a$ over $\mathbb{R}$, so this hypothesis would be unsatisfiable and the theorem empty. |
| 6 | Taking the square whose side is $\pi$, or the circle of area $1$. | Different geometry, different number. Radius $1$ gives area $\pi$ and side $\sqrt\pi$. |

## Notes on the ground truth

- Carrying `Transcendental ℚ Real.pi` as a hypothesis is the faithful reading of the text, but it is
  worth being clear that this is a true theorem being assumed, not an open condition. Mathlib does
  not currently prove it, which is the practical reason it stays a hypothesis.
- `Real.sqrt` of a non-negative number is the genuine root; $\pi > 0$, so no default value is
  involved.
- The statement omits the geometric wrapper (the square, the circle) and keeps only the algebraic
  residue, exactly as Niven's own reduction does.
