# Criteria: krylov_sobolev_13_3_13_negative_order_divergence_decomposition

**Statement:** [krylov_sobolev_13_3_13_negative_order_divergence_decomposition.md](krylov_sobolev_13_3_13_negative_order_divergence_decomposition.md) · **Lean:** [krylov_sobolev_13_3_13_negative_order_divergence_decomposition.lean](krylov_sobolev_13_3_13_negative_order_divergence_decomposition.lean)

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
