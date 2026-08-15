# Criteria: krylov_sobolev_13_6_3_divergence_form_solvability

**Statement:** [krylov_sobolev_13_6_3_divergence_form_solvability.md](krylov_sobolev_13_6_3_divergence_form_solvability.md) · **Lean:** [krylov_sobolev_13_6_3_divergence_form_solvability.lean](krylov_sobolev_13_6_3_divergence_form_solvability.lean) · **Context:** [krylov_sobolev_13_6_3_divergence_form_solvability.context.md](krylov_sobolev_13_6_3_divergence_form_solvability.context.md)

## What the theorem says

For a second-order operator in divergence form with bounded measurable coefficients, uniformly
elliptic, whose top-order coefficients are uniformly continuous with modulus $\omega$: once
$\lambda$ is large enough, the equation $Lu - \lambda u = D_if^i + g$ has exactly one solution in
$W_p^1$ for every right-hand side in $\mathcal{L}_p$, and that solution satisfies an estimate whose
constant does not depend on $\omega$ at all — only the threshold $\lambda_0$ does.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $\lambda_0$ depends on $d, p, \kappa, \omega, K$. | ✅ `∃ lam₀` sits inside `∀ w`, so it may depend on the modulus of continuity. |
| 2 | $N$ depends only on $d, p, \kappa, K$ — not on $\omega$. | ✅ `∃ N` is placed *before* `∀ w`. This asymmetry is the sharp part of the theorem. |
| 3 | The coefficients are measurable and bounded by $K$ in absolute value: $a^{ij}, a^i, b^i, c$. | ✅ Four measurability hypotheses and four bounds. |
| 4 | Uniform ellipticity $a^{rk}\xi^r\xi^k \ge \kappa\lvert \xi\rvert ^2$ for all $x$ and all $\xi$. | ✅ `∀ x ξ, κ * ‖ξ‖ ^ 2 ≤ ∑ r, ∑ k, a r k x * ξ r * ξ k`. |
| 5 | Only the $a^{ij}$ carry a modulus of continuity. | ✅ The `w`-hypothesis mentions `a` alone. |
| 6 | $\omega(\varepsilon) \to 0$ as $\varepsilon \downarrow 0$. | ✅ `Tendsto w (𝓝[>] 0) (𝓝 0)`. |
| 7 | Existence and uniqueness of the solution in $W_p^1$. | ✅ `∃! u : Lp ℝ p volume, ∃ v, IsDivergenceFormSolution …` — the `∃ v` says $u$ has a generalized gradient in $\mathcal{L}_p$, i.e. $u \in W_p^1$. |
| 8 | The estimate $\lambda^{1/2}\|u\| + \|Du\| \le N(\lambda^{-1/2}\|g\| + \sum_i\|f^i\|)$. | ✅ With `Real.sqrt lam` and `(Real.sqrt lam)⁻¹`. |
| 9 | The equation is understood in the sense of distributions. | ✅ `IsDivergenceFormSolution` is the integrated-by-parts identity tested against every $\varphi \in C_0^\infty$. |
| 10 | $\lambda \ge \lambda_0$, and $p \in (1,\infty)$. | ✅ `lam₀ ≤ lam`, `hp₁`, `hp₂`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Placing $\exists N$ inside $\forall\omega$. | That would let $N$ depend on the modulus of continuity, which is exactly what the theorem denies. This is the single most important detail. |
| 2 | Dropping uniqueness and asserting only existence. | The theorem says "a unique $u$". |
| 3 | Dropping the modulus-of-continuity hypothesis on $a^{ij}$. | Without any continuity the result is false; that is why Chapter 6 needs VMO coefficients for the weaker version. |
| 4 | Requiring $a^i$, $b^i$ or $c$ to be continuous. | They are only assumed measurable and bounded. |
| 5 | Using $\lambda$ and $\lambda^{-1}$ in the estimate instead of $\lambda^{1/2}$ and $\lambda^{-1/2}$. | The powers are what make the estimate scale-invariant; other powers give a false statement for large $\lambda$. |
| 6 | Reading the equation classically, i.e. assuming $u$ is twice differentiable. | Solutions are sought in $W_p^1$; only one derivative exists, and the equation is distributional. |
| 7 | Dropping the $-f^i$ term or the $g$ term from the weak formulation. | The right-hand side is $D_if^i + g$; both parts appear, in different places, after integrating by parts. |

## Notes on the ground truth

- `IsDivergenceFormSolution` is a shared definition holding the weak formulation, so that the same formula is not written four times. It bundles "$u$ has generalized gradient $v$" with the tested identity.
- The estimate is stated for every pair $(u,v)$ satisfying the equation. Given the uniqueness clause this is the same as Krylov's "for this solution".
- $\|Du\|_{\mathcal{L}_p}$ is the summed seminorm $\sum_j\|v_j\|$; a different convention only changes $N$.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[krylov_sobolev_13_6_3_divergence_form_solvability.md](krylov_sobolev_13_6_3_divergence_form_solvability.md) and the background in [krylov_sobolev_13_6_3_divergence_form_solvability.context.md](krylov_sobolev_13_6_3_divergence_form_solvability.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 10 rows, so each row is worth 5.0 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 2 with $N$ quantified after $\omega$, so that it may depend on the modulus of continuity.
- Requirement 8 with the $\lambda$-weights dropped or interchanged.
- Requirement 9 with the equation read pointwise rather than distributionally.

### Domain-specific pitfalls for this problem

- The quantifier order for the two constants is the substance: $N$ before $\omega$, $\lambda_0$ after it.
- Only the leading coefficients carry a modulus of continuity; the rest are measurable and bounded.
- The equation is in divergence form and lives in the distributional sense; $D_if^i$ is not a function.
- The solution space is $W_p^1$ and uniqueness is relative to it.
- The exponent range is $p \in (1,\infty)$; the endpoints are excluded.
