# Criteria: krylov_sobolev_12_10_2_bessel_potential_holder_embedding

**Statement:** [krylov_sobolev_12_10_2_bessel_potential_holder_embedding.md](krylov_sobolev_12_10_2_bessel_potential_holder_embedding.md) · **Lean:** [krylov_sobolev_12_10_2_bessel_potential_holder_embedding.lean](krylov_sobolev_12_10_2_bessel_potential_holder_embedding.lean) · **Context:** [krylov_sobolev_12_10_2_bessel_potential_holder_embedding.context.md](krylov_sobolev_12_10_2_bessel_potential_holder_embedding.context.md)

## What the theorem says

Fix $p \in (1,\infty]$ and a smoothness $\gamma$ with $\delta = \gamma - d/p$ strictly between
$0$ and $1$. Then a single constant $N$ does two jobs at once for every Schwartz function $\phi$:
it bounds $\phi$ pointwise, and it bounds the Hölder quotient
$|\phi(x)-\phi(y)|/|x-y|^\delta$ — both in terms of the single quantity
$\|(1-\Delta)^{\gamma/2}\phi\|_{\mathcal{L}_p}$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | Both estimates are asserted, under one and the same $N$. | ✅ The conclusion is a conjunction inside a single `∃ N`. |
| 2 | $N$ is chosen before $\phi$, $x$ and $y$. | ✅ `∃ N : ℝ, ∀ φ x y, …`. |
| 3 | $p$ ranges over $(1,\infty]$, so $p = \infty$ is included. | ✅ `p : ℝ≥0∞` with `hp : 1 < p` and no upper restriction. |
| 4 | $\delta = \gamma - d/p$, with $d/\infty$ read as $0$. | ✅ `γ - d * (p⁻¹).toReal`; at `p = ⊤` this is `γ - d * 0 = γ`. |
| 5 | Both bounds $0 < \delta$ and $\delta < 1$ are assumed. | ✅ `hδ₀` and `hδ₁`. |
| 6 | $\phi$ is a Schwartz function. | ✅ `φ : 𝓢(EuclideanSpace ℝ (Fin d), ℂ)`. |
| 7 | $(1-\Delta)^{\gamma/2}$ is the Fourier multiplier with symbol $(1+\lvert \xi\rvert ^2)^{\gamma/2}$. | ✅ `besselOp γ`, a shared definition built from `SchwartzMap.fourierMultiplierCLM`. |
| 8 | The Hölder bound carries the factor $\lvert x-y\rvert ^\delta$. | ✅ `‖x - y‖ ^ (γ - d * (p⁻¹).toReal)`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Keeping only the Hölder estimate. | The sup bound is a separate assertion; it does not follow from the Hölder bound alone, since a Hölder-continuous function need not be bounded. |
| 2 | Excluding $p = \infty$. | Krylov's range is $(1,\infty]$ and the endpoint is the case $\delta = \gamma$. |
| 3 | Assuming only $\delta > 0$, or only $\delta < 1$. | Both ends are sharp. At $\delta = 0$ only a BMO-type bound survives (Exercise 12.10.5); at $\delta = 1$ only a second-difference bound survives (Exercise 12.10.6). |
| 4 | Adding a hypothesis that $\|(1-\Delta)^{\gamma/2}\phi\|_{\mathcal{L}_p}$ is finite. | It is automatic: the operator maps Schwartz functions to Schwartz functions. Assuming it is over-assuming. |
| 5 | Using the symbol $(1+\lvert \xi\rvert ^2)^{\gamma/2}$ verbatim with Mathlib's Fourier transform. | Mathlib uses the $e^{-2\pi i\langle x,\xi\rangle}$ convention, so that symbol gives $(1 - (2\pi)^{-2}\Delta)^{\gamma/2}$, not Krylov's operator. The norms are equivalent, so the statement stays true, but it is a different operator. |
| 6 | Letting $N$ depend on $\phi$. | Then the statement is trivial: take $N$ large for each $\phi$ separately. |

## Notes on the ground truth

- `besselOp γ` uses the symbol $(1 + (2\pi)^2|\xi|^2)^{\gamma/2}$, which under Mathlib's Fourier convention is exactly Krylov's $(1-\Delta)^{\gamma/2}$ — not merely an equivalent operator.
- `0 ≤ N` is not stated because it is forced: the left sides are norms, so any $N$ that works is non-negative.
- `(p⁻¹).toReal` is used instead of `d / p.toReal` because `ENNReal.toReal ⊤ = 0`; writing it this way makes the $p = \infty$ convention explicit rather than accidental.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[krylov_sobolev_12_10_2_bessel_potential_holder_embedding.md](krylov_sobolev_12_10_2_bessel_potential_holder_embedding.md) and the background in [krylov_sobolev_12_10_2_bessel_potential_holder_embedding.context.md](krylov_sobolev_12_10_2_bessel_potential_holder_embedding.context.md),
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

- Requirement 2 with $N$ quantified after $\phi$, $x$ or $y$.
- Requirement 4 with $d/p$ at $p=\infty$ evaluated by a division that returns a junk value rather than $0$.
- Requirement 7 with $(1-\Delta)^{\gamma/2}$ replaced by a differential operator rather than the Fourier multiplier.

### Domain-specific pitfalls for this problem

- Junk value — division: $d/p$ with $p = \infty$ must be $0$; in `ℝ≥0∞` the inverse of $\infty$ is $0$, which gives the right convention, but a real-valued division would not.
- $(1-\Delta)^{\gamma/2}$ is defined through the Fourier transform, with symbol $(1+|\xi|^2)^{\gamma/2}$; $\gamma$ is real and may be non-integral.
- Both estimates share the constant $N$.
- The exponent in the Hölder factor is $\delta = \gamma - d/p$, the same $\delta$ constrained by the hypothesis.
- The endpoint $p = \infty$ is included in the range.
