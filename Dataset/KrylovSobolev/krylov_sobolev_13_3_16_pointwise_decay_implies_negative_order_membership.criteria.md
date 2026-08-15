# Criteria: krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership

**Statement:** [krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership.md](krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership.md) · **Lean:** [krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership.lean](krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership.lean) · **Context:** [krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership.context.md](krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership.context.md)

## What the theorem says

Deciding whether a function lies in $H_p^\gamma$ for negative $\gamma$ is awkward, because such
a function need not be in $\mathcal{L}_p$ at all. This exercise gives a purely pointwise test: if
$u$ lives in a ball and decays like $|x|^{-\nu}$, with the exponents in the stated ranges, then $u$
is in $H_p^\gamma$ and its norm is bounded by a constant that does not depend on $u$. The second
half is the same test applied to all derivatives up to order $n$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | Both halves are asserted. | ✅ The statement is a conjunction of the $\gamma < 0$ case and the general order-$n$ case. |
| 2 | First half: support in $B_\rho$, $\lvert u(x)\rvert \le N_0\lvert x\rvert ^{-\nu}$, and the three exponent conditions $\nu < d$, $0 < (\nu+\gamma)p < d$, $\gamma < 0$. | ✅ All present as hypotheses. |
| 3 | Second half: $\lvert D^\alpha u(x)\rvert \le N_0\lvert x\rvert ^{-\nu}$ for every $\lvert \alpha\rvert \le n$, plus $\nu < d$ and $\gamma \le n$. | ✅ `∀ α, (∑ i, α i) ≤ n → ∀ x ≠ 0, ‖multiDeriv α u x‖ ≤ N₀ * ‖x‖ ^ (-ν)`. |
| 4 | Second half: the "either … or …" condition on the exponents. | ✅ A disjunction: `(γ < n ∧ 0 < (ν+γ-n)*p ∧ (ν+γ-n)*p < d) ∨ (γ = n ∧ ν*p < d)`. |
| 5 | The conclusion is membership in $H_p^\gamma$ together with a bound on $\|u\|_{H_p^\gamma}$. | ✅ `MemSobolev γ p …` and `sobolevNorm γ p … ≤ C`. |
| 6 | The bounding constant depends only on the listed data and not on $u$. | ✅ `∃ C, C ≠ ⊤ ∧ ∀ u, …` — `C` is chosen before `u`, after $d, p, \rho, \nu, \gamma, N_0$ (and $n$). |
| 7 | $p \in (1,\infty)$. | ✅ `hp₁` and `hp₂`. |
| 8 | The dimension is at least $1$. | ✅ `hd : 0 < d`. Krylov works on $\mathbb{R}^d$ throughout; at $d = 0$ the second half is false. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Formalizing only the first half. | The generalization is explicitly part of the exercise. |
| 2 | Letting the constant depend on $u$. | Then the claim is empty: any single $u$ in the space has some finite norm. |
| 3 | Concluding $u \in \mathcal{L}_p$. | Krylov points out that this generally fails, because $\nu p < d$ need not hold. That remark is the whole reason the exercise is interesting. |
| 4 | Dropping $\nu < d$. | Without it $\lvert x\rvert ^{-\nu}$ is not locally integrable, and $u$ need not define a distribution at all. |
| 5 | Replacing the "either … or …" by just the first alternative. | The $\gamma = n$ case has a genuinely different exponent condition, $\nu p < d$. |
| 6 | Stating the decay bound at $x = 0$ as well. | $\lvert x\rvert ^{-\nu}$ is undefined there; the bound is asserted for $x \ne 0$. |
| 7 | Forgetting that $u$ must be supported in the ball. | Without compact support the decay hypothesis says nothing at infinity, and the conclusion fails. |
| 8 | Leaving the dimension unconstrained. | At $d = 0$ the space is one point, so "supported in $B_\rho$" and "$\lvert D^\alpha u(x)\rvert \le N_0\lvert x\rvert^{-\nu}$ for $x \ne 0$" are both vacuous and every constant function qualifies — but their $H_p^\gamma$ norms are unbounded, while the constant was fixed first. The second half of the statement is then provably false. |

## Notes on the ground truth

- To speak of $u$ as a distribution the statement produces an $\mathcal{L}_1$ representative `U` with `u =ᵐ[volume] ⇑U`, and asserts the $H_p^\gamma$ facts about `U`. The decay hypothesis plus compact support is exactly what makes $u$ integrable, so this is part of the conclusion rather than an added assumption.
- The `hd : 0 < d` hypothesis was added after an adversarial review produced a compiling refutation of the $d = 0$ case; see `GROUND_TRUTH_ISSUES.md`.
- $\|x\|^{-\nu}$ is `Real.rpow`, which is why the bound is stated for `x ≠ 0`.
- In the second half `ContDiff ℝ n u` is assumed so that the derivatives $D^\alpha u$ the hypothesis talks about actually exist; `multiDeriv` would otherwise silently return $0$.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership.md](krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership.md) and the background in [krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership.context.md](krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership.context.md),
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

- Requirement 8 with $d = 0$ admitted: the second half is then false, since the decay and support hypotheses hold vacuously for every constant while the $H_p^\gamma$ norms of the constants are unbounded.
- Requirement 4 with the "either/or" collapsed to one branch.
- Requirement 6 with the bounding constant allowed to depend on $u$.

### Domain-specific pitfalls for this problem

- The bounding constant depends only on $d,p,\rho,\nu,\gamma,N_0$ (and $n$ in the second half); its quantifier position is the content.
- The decay hypothesis in the second half is on *every* derivative of order $\le n$, not only on $u$.
- $\gamma$ is a real number, negative in the first half and $\le n$ in the second.
- Membership in $H_p^\gamma$ for $\gamma < 0$ is about a distribution, and the hypotheses deliberately do not give $u \in \mathcal{L}_p$.
- Both halves are asserted.
