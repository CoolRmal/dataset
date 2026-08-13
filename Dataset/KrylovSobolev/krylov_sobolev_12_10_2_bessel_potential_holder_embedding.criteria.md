# Criteria: krylov_sobolev_12_10_2_bessel_potential_holder_embedding

**Statement:** [krylov_sobolev_12_10_2_bessel_potential_holder_embedding.md](krylov_sobolev_12_10_2_bessel_potential_holder_embedding.md) · **Lean:** [krylov_sobolev_12_10_2_bessel_potential_holder_embedding.lean](krylov_sobolev_12_10_2_bessel_potential_holder_embedding.lean)

## What the theorem says

Fix $p \in (1,\infty]$ and a smoothness $\gamma$ with $\delta = \gamma - d/p$ strictly between
$0$ and $1$. Then a single constant $N$ does two jobs at once for every Schwartz function $\phi$:
it bounds $\phi$ pointwise, and it bounds the Hölder quotient
$|\phi(x)-\phi(y)|/|x-y|^\delta$ — both in terms of the single quantity
$\|(1-\Delta)^{\gamma/2}\phi\|_{\mathcal{L}_p}$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

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
