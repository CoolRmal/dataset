# Criteria: niven_5_5_trisection_of_the_angle_impossible

**Statement:** [niven_5_5_trisection_of_the_angle_impossible.md](niven_5_5_trisection_of_the_angle_impossible.md) · **Lean:** [niven_5_5_trisection_of_the_angle_impossible.lean](niven_5_5_trisection_of_the_angle_impossible.lean)

## What the theorem says

To show that angles cannot be trisected in general it is enough to find one angle that cannot be
trisected. Niven takes $60°$, which is easy to draw. Trisecting it means producing a $20°$ angle, and
an angle can be drawn with straightedge and compass exactly when its cosine can be built as a length.
So the whole question becomes: is $\cos 20°$ constructible? It is not — it satisfies
$8x^3 - 6x - 1 = 0$, which has no rational root, so its degree over $\mathbb{Q}$ is $3$, not a power
of $2$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The number is the cosine of $20°$, written in radians as $\pi/9$. | ✅ `Real.cos (Real.pi / 9)`. |
| 2 | The claim is about a single specific angle, not about all angles. | ✅ The literal `Real.pi / 9`, with no quantifier. |
| 3 | The conclusion is that this length is not constructible. | ✅ `¬ IsConstructible (Real.cos (Real.pi / 9))`. |
| 4 | "Constructible" is the shared straightedge-and-compass class. | ✅ `IsConstructible` from `Defs.lean`. |
| 5 | The statement is unconditional. | ✅ The theorem takes no arguments. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Using `Real.pi / 3` instead of `Real.pi / 9`. | That is $60°$, the angle you start from. Its cosine is $1/2$, which is rational and therefore constructible, so the statement would be false. |
| 2 | Writing `Real.cos 20`. | Mathlib's `cos` takes radians, so this is the cosine of $20$ radians, an unrelated number. |
| 3 | Quantifying over all angles: `∀ θ, ¬ IsConstructible (Real.cos (θ / 3))`. | False. Take $\theta = \pi/2$: then $\cos(\pi/6) = \sqrt3/2$, which is constructible. Many angles can be trisected; the theorem exhibits one that cannot. |
| 4 | Concluding `Irrational (Real.cos (Real.pi / 9))`. | Weaker and beside the point. $\cos 15° = (\sqrt6+\sqrt2)/4$ is irrational and constructible, so irrationality is no obstruction to trisection. |
| 5 | Stating `¬ IsConstructible (Real.pi / 9)`. | That is a claim about the number $\pi/9$ itself, which is a different (also true) statement. Drawing an angle corresponds to building its cosine as a length, not to building the radian measure. |
| 6 | Stating that the degree of $\cos 20°$ over $\mathbb{Q}$ is $3$. | That is the reason for the result, not the result. The construction problem asks whether the angle can be drawn. |

## Notes on the ground truth

- The Lean statement keeps only the algebraic residue: no angles, no trisection, just
  $\cos(\pi/9)$. This mirrors Niven's own reduction, but it does mean a reader has to accept the
  bridge "an angle is constructible exactly when its cosine is", which the `.md` records.
- $20°$ is $\pi/9$ radians because $20/180 = 1/9$.
- The cubic $8x^3 - 6x - 1$ comes from the triple-angle identity $\cos 3\theta = 4\cos^3\theta -
  3\cos\theta$ at $3\theta = 60°$; it is mentioned here only as background, not asserted in Lean.
