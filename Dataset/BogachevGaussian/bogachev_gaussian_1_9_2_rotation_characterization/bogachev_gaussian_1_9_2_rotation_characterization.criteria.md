# Criteria: bogachev_gaussian_1_9_2_rotation_characterization

**Statement:** [bogachev_gaussian_1_9_2_rotation_characterization.md](bogachev_gaussian_1_9_2_rotation_characterization.md) · **Lean:** [bogachev_gaussian_1_9_2_rotation_characterization.lean](bogachev_gaussian_1_9_2_rotation_characterization.lean) · **Context:** [bogachev_gaussian_1_9_2_rotation_characterization.context.md](bogachev_gaussian_1_9_2_rotation_characterization.context.md)

## What the theorem says

Take a random vector $\xi$ in $\mathbb{R}^n$ and two independent copies $\xi_1,\xi_2$ of it. Pick an
angle $\varphi$ and form the two mixtures $\xi_1\sin\varphi+\xi_2\cos\varphi$ and
$\xi_1\cos\varphi-\xi_2\sin\varphi$. If $\xi$ is centered Gaussian, these two mixtures are again a
pair of independent copies of $\xi$, for every $\varphi$. The theorem says the converse also holds:
if the mixtures are a pair of independent copies for every $\varphi$, then $\xi$ must be centered
Gaussian. So this one-parameter rotation property characterizes the centered Gaussian laws.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The law $\mu$ of $\xi$ is a Borel probability measure on $\mathbb{R}^n$. | ✅ `(μ : Measure (EuclideanSpace ℝ (Fin n)))` with `[IsProbabilityMeasure μ]`. |
| 2 | The statement is an "if and only if". Both directions are asserted. | ✅ The top-level connective is `↔`. |
| 3 | The left-hand side says two things: $\mu$ is Gaussian, and $\mu$ is centered (mean vector $0$). | ✅ `IsGaussian μ ∧ ∫ x, x ∂μ = 0`. |
| 4 | "A pair of independent copies of $\xi$" is the product measure $\mu\otimes\mu$ on $\mathbb{R}^n\times\mathbb{R}^n$. | ✅ `μ.prod μ` on both sides of the inner equation. |
| 5 | "The rotated pair is again a pair of independent copies" is an equality of measures on the product space: pushing $\mu\otimes\mu$ forward by the rotation gives back $\mu\otimes\mu$. | ✅ `(μ.prod μ).map (fun p ↦ …) = μ.prod μ`. |
| 6 | The map is exactly the printed one: first coordinate $x\sin\varphi+y\cos\varphi$, second coordinate $x\cos\varphi-y\sin\varphi$. | ✅ `(Real.sin φ • p.1 + Real.cos φ • p.2, Real.cos φ • p.1 - Real.sin φ • p.2)`. |
| 7 | The condition is required for every real $\varphi$. | ✅ `∀ φ : ℝ, …`. |
| 8 | No other hypothesis is imposed — in particular no assumption that $\xi$ has a finite second moment. | ✅ `[IsProbabilityMeasure μ]` is the only instance argument. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Stating only the direction "centered Gaussian $\Rightarrow$ rotation invariance". | That direction is a short computation. The converse is the theorem (Kac's characterization); dropping it removes all the content. |
| 2 | Reading "independent copies" as "each of the two mixtures has law $\mu$", i.e. an equality of marginals. | Strictly weaker, and false as a characterization: many non-Gaussian laws keep each marginal fixed without the pair being independent. The joint law on the product space is what must be preserved. |
| 3 | Replacing the one-parameter family by "for every orthogonal matrix $T$ on $\mathbb{R}^n\times\mathbb{R}^n$, the pushforward of $\mu\otimes\mu$ is $\mu\otimes\mu$". | True but a different, much easier statement. The point is that these particular maps already suffice. |
| 4 | Dropping the centering conjunct and concluding only `IsGaussian μ`. | Rotation invariance forces the mean to be $0$; a Gaussian with nonzero mean does not satisfy the right-hand side. Without centering the equivalence is false. |
| 5 | Adding a moment hypothesis such as `MemLp id 2 μ`. | Finiteness of the second moment is part of what the theorem proves in the hard direction. Assuming it gives away the difficulty. |
| 6 | Flipping a sign in the map, e.g. writing $(\ x\sin\varphi+y\cos\varphi,\ -x\cos\varphi+y\sin\varphi)$, or swapping which coordinate carries the minus. | These are genuinely different maps of the plane pair. The transcription must be literal. |
| 7 | Assuming $\xi_1$ and $\xi_2$ are independent with possibly different laws. | The theorem is about two copies of the *same* $\xi$; the product must be $\mu\otimes\mu$, not $\mu_1\otimes\mu_2$. |

## Notes on the ground truth

- The printed pair has determinant $-1$, so strictly it is a reflection rather than a rotation. We transcribed it literally as printed rather than "fixing" it.
- Bogachev remarks that the condition for a single $\varphi$ with $\varphi \neq k\pi/2$ already suffices. Our `∀ φ : ℝ` is the literal form of the theorem as stated; a candidate using a single such $\varphi$ is proving a stronger result, not this one.
- "Gaussian" is Mathlib's `IsGaussian`: every continuous linear functional has a real Gaussian law, degenerate cases included. We reuse the class rather than re-defining Gaussianity.
- "Centered" is written as the Bochner integral of the identity, `∫ x, x ∂μ = 0`, rather than `∀ L, μ[L] = 0`. The two agree here.
- Lean gives a non-integrable Bochner integral the value $0$, so `∫ x, x ∂μ = 0` could in principle hold for free. It does not cause a problem here: in the forward direction the hypothesis `IsGaussian μ` supplies integrability (`IsGaussian.integrable_id`), and in the backward direction the centering is part of what is being proved alongside `IsGaussian`. Also `EuclideanSpace ℝ (Fin n)` is complete, so the Bochner integral is not disabled outright.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[bogachev_gaussian_1_9_2_rotation_characterization.md](bogachev_gaussian_1_9_2_rotation_characterization.md) and the background in [bogachev_gaussian_1_9_2_rotation_characterization.context.md](bogachev_gaussian_1_9_2_rotation_characterization.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 8 rows, so each row is worth 6.2 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 5 weakened to equality of marginals rather than equality of the joint law on the product: the resulting statement is not a characterization of Gaussian laws.
- Requirement 2 with only the easy direction stated.
- Requirement 8 strengthened by a second-moment hypothesis: that finiteness is part of what the theorem proves.

### Domain-specific pitfalls for this problem

- "Independent copies" is a statement about the *joint* law: the product measure `μ.prod μ` on the pair, not two separate marginal conditions.
- The rotation is the specific map printed; swapping which coordinate carries the minus sign, or flipping a sign, gives a genuinely different map of the plane and a different theorem.
- Centredness is the vanishing of the mean vector $\int x \, d\gamma$. This Bochner integral is not a junk value here because a Gaussian measure has all moments — but the same expression would be junk for an arbitrary probability measure.
- `EuclideanSpace ℝ (Fin n)` carries the inner-product structure the statement's geometry needs; `Fin n → ℝ` with the sup norm is a different normed space, although for this statement the two give the same content.
