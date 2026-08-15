# Criteria: krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative

**Statement:** [krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative.md](krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative.md) · **Lean:** [krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative.lean](krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative.lean) · **Context:** [krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative.context.md](krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative.context.md)

## What the theorem says

Mollify $u$ by an even bump $\zeta$ of unit mass. If the mollification approaches $u$ fast enough
in $\mathcal{L}_2$ — fast enough that $\int_0^1\|u^{(\varepsilon)} - u\|^2\varepsilon^{-3}\,
d\varepsilon$ is finite — then $u$ already has generalized first derivatives in $\mathcal{L}_2$,
and their size is controlled by that integral together with $\|u\|_{\mathcal{L}_2}$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $\zeta$ is smooth, compactly supported, even, and integrates to $1$. | ✅ All four hypotheses on `ζ`. |
| 2 | The constant $N$ is chosen before $u$ and $M$. | ✅ `∃ N : ℝ≥0, ∀ u M, …`. It may depend on `d` and `ζ`, which are fixed earlier. |
| 3 | $u \in \mathcal{L}_2$. | ✅ `MemLp u 2 volume`. |
| 4 | The hypothesis integral is over $(0,1)$ with weight $\varepsilon^{-3}$. | ✅ `∫⁻ ε in Ioo (0:ℝ) 1, … * ENNReal.ofReal (ε ^ (-3 : ℤ))`. |
| 5 | The conclusion $u \in W_2^1$ is spelled out as: there are functions $v_j$ in $\mathcal{L}_2$ that are the generalized derivatives of $u$. | ✅ `∃ v, HasWeakGradient u v ∧ ∀ j, MemLp (v j) 2 volume`. |
| 6 | The bound $\sum_j\|v_j\| \le N(M + \|u\|)$. | ✅ The last conjunct. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Dropping the evenness of $\zeta$. | Without it the mollification only converges at rate $O(\varepsilon)$ (Corollary 9.1.3), and the hypothesis with weight $\varepsilon^{-3}$ can no longer be satisfied by the functions the exercise is about. |
| 2 | Letting $N$ depend on $u$ or on $M$. | The exercise says explicitly that $N$ is independent of both. |
| 3 | Concluding that $u$ is differentiable. | False. The conclusion is the existence of generalized derivatives, which are only defined up to a null set. |
| 4 | Writing the hypothesis with a Bochner integral over $(0,1)$. | Lean gives a divergent Bochner integral the value $0$, so "$\le M^2$" would be satisfied for free by functions with a divergent integral. Using the `ℝ≥0∞`-valued `∫⁻` removes the loophole. |
| 5 | Quantifying $\zeta$ inside the statement, after $N$. | $\zeta$ is fixed by Exercise 9.1.6, and $N$ is allowed to depend on it. |
| 6 | Changing $\varepsilon^{-3}$ or the range $(0,1)$. | The exponent is exactly what makes the hypothesis equivalent to one derivative; any other exponent gives a different theorem. |

## Notes on the ground truth

- `HasWeakGradient u v` is the shared definition $\int u\,D_j\varphi = -\int v_j\varphi$ for all test functions $\varphi$; Mathlib has no weak-derivative predicate.
- The mollification is written in Krylov's third form, $\int u(x - \varepsilon y)\zeta(y)\,dy$, which needs no new definition.
- `M` is a non-negative real (`ℝ≥0`), matching the fact that the hypothesis bounds a square.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative.md](krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative.md) and the background in [krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative.context.md](krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative.context.md),
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

- Requirement 5 with classical rather than generalized derivatives: $u$ is only in $\mathcal{L}_2$ and need not be differentiable.
- Requirement 2 with $N$ allowed to depend on $u$ or $M$.
- Requirement 4 with the weight $\varepsilon^{-3}$ or the interval $(0,1)$ altered.

### Domain-specific pitfalls for this problem

- The generalized derivative is defined by the integration-by-parts identity with a minus sign; getting the sign wrong defines $-D_ju$.
- $\|u_x\|$ is the summed first-order seminorm, not the full $W_2^1$ norm.
- The hypothesis integral has a square inside and the weight $\varepsilon^{-3}$; it may be infinite a priori, so it belongs in an extended-real integral.
- $\zeta$ is even, smooth, compactly supported and of unit mass; all four are used.
- The constant $N$ may depend on the dimension and on $\zeta$ but not on $u$ or $M$.
