# Criteria: krylov_sobolev_13_3_13_negative_order_divergence_decomposition

**Statement:** [krylov_sobolev_13_3_13_negative_order_divergence_decomposition.md](krylov_sobolev_13_3_13_negative_order_divergence_decomposition.md) · **Lean:** [krylov_sobolev_13_3_13_negative_order_divergence_decomposition.lean](krylov_sobolev_13_3_13_negative_order_divergence_decomposition.lean) · **Context:** [krylov_sobolev_13_3_13_negative_order_divergence_decomposition.context.md](krylov_sobolev_13_3_13_negative_order_divergence_decomposition.context.md)

## What the theorem says

A distribution of order $-1$ is exactly a sum $f_0 + \sum_j D_jf_j$ of $d+1$ functions in
$\mathcal{L}_p$, one undifferentiated and $d$ differentiated once. The exercise asks for both
directions, each with a norm bound, and each with a constant that does not depend on the data.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The constant $N$ is chosen first, then quantified over all $g$ (and all $f$). | ✅ `∃ N : ℝ≥0, (∀ g, …) ∧ (∀ g f, …)`. |
| 2 | Forward direction: every $g \in H_p^{-1}$ admits such a decomposition, with $\sum_j\|f_j\|_{\mathcal{L}_p} \le N\|g\|_{H_p^{-1}}$. | ✅ First conjunct. |
| 3 | Backward direction: any $g$ of that form lies in $H_p^{-1}$, and $\|g\|_{H_p^{-1}} \le N\sum_j\|f_j\|_{\mathcal{L}_p}$. | ✅ Second conjunct, which asserts membership as well as the bound. |
| 4 | There are $d+1$ functions: $f_0$ undifferentiated, then $f_1,\dots,f_d$. | ✅ `f : Fin (d + 1) → Lp ℂ p volume`, with `f 0` alone and `f j.succ` under `∂`. |
| 5 | The identity $g = f_0 + \sum_j D_jf_j$ is an identity of distributions. | ✅ Both sides live in `𝓢'(EuclideanSpace ℝ (Fin d), ℂ)`; `∂_{…}` is the distributional derivative. |
| 6 | $p \in (1,\infty)$. | ✅ `hp₁ : 1 < p` and `hp₂ : p ≠ ⊤`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Proving only one direction. | The exercise states two, and the converse also asserts membership in $H_p^{-1}$, not just an inequality. |
| 2 | In the backward direction, asserting only the norm bound and not $g \in H_p^{-1}$. | Without the membership claim the norm bound says little, since the norm of something outside the space is not a real number. |
| 3 | Letting $N$ depend on $g$ or on the $f_j$. | The exercise says twice that $N$ is independent of them. |
| 4 | Reading $g = f_0 + \sum_j D_jf_j$ as a pointwise identity of functions. | $D_jf_j$ is a distributional derivative of an $\mathcal{L}_p$ function; in general it is not a function at all. |
| 5 | Using $d$ functions instead of $d+1$. | The undifferentiated $f_0$ is needed; without it the claim is false, since $H_p^{-1}$ contains non-zero constants' worth of low-frequency content that pure divergences cannot produce. |
| 6 | Allowing $p = 1$ or $p = \infty$. | Section 13.3 fixes $p \in (1,\infty)$, and the result fails at both endpoints. |

## Notes on the ground truth

- `sobolevNorm (-1) p g` is the shared definition of $\|g\|_{H_p^{-1}}$: Mathlib supplies `MemSobolev` as a predicate but no norm. It is defined as an infimum over $\mathcal{L}_p$ representatives, so it takes the value $\top$ exactly when $g$ is not in the space.
- Mathlib's `besselPotential` carries the $2\pi$ normalization, so `sobolevNorm` is equivalent to, rather than equal to, Krylov's norm. Both constants here are existential, so the statement is unaffected.
- Tempered distributions in Mathlib need complex scalars, so the statement is over $\mathbb{C}$; the real case is contained in it.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[krylov_sobolev_13_3_13_negative_order_divergence_decomposition.md](krylov_sobolev_13_3_13_negative_order_divergence_decomposition.md) and the background in [krylov_sobolev_13_3_13_negative_order_divergence_decomposition.context.md](krylov_sobolev_13_3_13_negative_order_divergence_decomposition.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 6 rows, so each row is worth 8.3 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 1 with the constant quantified after $g$ (or after the $f_j$).
- Requirement 3 omitted, so only one direction of the characterisation is asserted.
- Requirement 5 with the identity read pointwise rather than as an identity of distributions.

### Domain-specific pitfalls for this problem

- There are $d+1$ functions; $f_0$ is not differentiated.
- $D_jf_j$ is a distributional derivative — an element of $H_p^{-1}$, not an $\mathcal{L}_p$ function.
- Both inequalities have their own uniform constant, quantified outermost.
- $H_p^{-1}$ is a space of distributions; membership is a statement about the Bessel potential of $g$.
