# Criteria: niven_5_5_squaring_the_circle_impossible

**Statement:** [niven_5_5_squaring_the_circle_impossible.md](niven_5_5_squaring_the_circle_impossible.md) · **Lean:** [niven_5_5_squaring_the_circle_impossible.lean](niven_5_5_squaring_the_circle_impossible.lean)

Niven's argument is explicitly conditional — he grants the transcendence of $\pi$ — so the transcendence must appear as a **hypothesis**, not be silently assumed or omitted. The quantity to be constructed is $\sqrt\pi$, the side of a square of area $\pi$.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Hypothesis completeness | The transcendence of `π` is a hypothesis of the argument as the book presents it. | ✅ `hpi : Transcendental ℚ Real.pi`. ⚠️ mathlib does not currently prove `Transcendental ℚ Real.pi`, so discharging it would need new work; carrying it as a hypothesis is the faithful reading. ❗ Predicted error: dropping it and claiming the result unconditionally. |
| 2 | Faithful encoding | The constructed length is `√π`, not `π`. | ✅ `Real.sqrt Real.pi`. ❗ Predicted error: `¬ IsConstructible Real.pi`, which is a different (also true) statement and does not directly answer the quadrature. |
| 3 | Conclusion completeness | Non-constructibility. | ✅ `¬ IsConstructible`. |
| 4 | Junk values | `Real.sqrt` of a non-negative real is the genuine root. | ✅ Safe since `π > 0`. |
