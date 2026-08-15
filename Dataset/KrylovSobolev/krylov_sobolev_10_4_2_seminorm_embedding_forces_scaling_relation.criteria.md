# Criteria: krylov_sobolev_10_4_2_seminorm_embedding_forces_scaling_relation

**Statement:** [krylov_sobolev_10_4_2_seminorm_embedding_forces_scaling_relation.md](krylov_sobolev_10_4_2_seminorm_embedding_forces_scaling_relation.md) · **Lean:** [krylov_sobolev_10_4_2_seminorm_embedding_forces_scaling_relation.lean](krylov_sobolev_10_4_2_seminorm_embedding_forces_scaling_relation.lean) · **Context:** [krylov_sobolev_10_4_2_seminorm_embedding_forces_scaling_relation.context.md](krylov_sobolev_10_4_2_seminorm_embedding_forces_scaling_relation.context.md)

## What the theorem says

This is the converse of the general embedding lemma. Suppose the top-order seminorm inequality
$[u]_{W_q^m} \le N[u]_{W_p^k}$ happens to hold on $\mathbb{R}^d$ or on the half-space, for some
$k, m, p, q$ and some constant $N$ that does not depend on $u$. Then those exponents cannot be
arbitrary: necessarily $m \le k$, and $k - d/p = m - d/q$ exactly.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $\Omega$ is either all of $\mathbb{R}^d$ or the half-space $\{x^1 > 0\}$. | ✅ `hΩ` is that disjunction. |
| 2 | The hypothesis is that one constant $N$ works for every test function $u$. | ✅ `hemb : ∃ N, ∀ u, …`. |
| 3 | The test functions are smooth with compact support inside $\Omega$. | ✅ `ContDiff ℝ ∞ u`, `HasCompactSupport u`, `tsupport u ⊆ Ω`. |
| 4 | Both sides are top-order seminorms: the sums run over multi-indices of order exactly $m$ and exactly $k$. | ✅ `Finset.piAntidiag Finset.univ m` and `… k`, which are the multi-indices summing to $m$ resp. $k$. |
| 5 | $k \ge 1$, $p \ge 1$, $q > 0$. | ✅ `hk`, `hp`, `hq`. |
| 6 | $m$ carries no assumption. | ✅ `m` is a free natural number; bounding it is half the conclusion. |
| 7 | The conclusion is a conjunction: $m \le k$ and the exponent identity. | ✅ `m ≤ k ∧ (k : ℝ) - d / p = (m : ℝ) - d / q`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Assuming $m \le k$ as a hypothesis. | It is part of what has to be proved. |
| 2 | Concluding the inequality $k - d/p \ge m - d/q$. | That is the hypothesis of Theorem 10.4.4. Exercise 10.4.2 gives the equality. |
| 3 | Using the full norm $\|u\|_{W_p^k}$ instead of the seminorm $[u]_{W_p^k}$. | The seminorm has only the top-order terms. With the full norm the scaling argument that forces the identity no longer applies. |
| 4 | Summing over $\lvert \alpha\rvert \le k$ instead of $\lvert \alpha\rvert = k$. | Same problem: that is the full norm again. |
| 5 | Requiring $q \ge 1$ or $q \ge p$. | Krylov allows $q \in (0,\infty)$; $q \ge p$ is a consequence, not an assumption. |
| 6 | Dropping the constraint that the support lies in $\Omega$. | For the half-space this is what makes the class $C_0^\infty(\Omega)$. |

## Notes on the ground truth

- Because $q$ may be less than $1$, `eLpNorm _ (ENNReal.ofReal q)` is Mathlib's $\left(\int|f|^q\right)^{1/q}$, which is Krylov's $\mathcal{L}_q$ quantity for such $q$ as well.
- The hypothesis `hemb` is itself an existential statement, so the theorem has the shape "if there is such an $N$, then the exponents are related". Hoisting that `∃ N` outward would change the meaning.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[krylov_sobolev_10_4_2_seminorm_embedding_forces_scaling_relation.md](krylov_sobolev_10_4_2_seminorm_embedding_forces_scaling_relation.md) and the background in [krylov_sobolev_10_4_2_seminorm_embedding_forces_scaling_relation.context.md](krylov_sobolev_10_4_2_seminorm_embedding_forces_scaling_relation.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 7 rows, so each row is worth 7.1 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 6 with a relation among $k,m,p,q$ assumed: the exercise is to *derive* it.
- Requirement 4 with full Sobolev norms in place of the top-order seminorms.
- Requirement 2 with the constant allowed to depend on $u$.

### Domain-specific pitfalls for this problem

- The seminorm $[u]_{W^k_p}$ sums over $|\alpha| = k$ exactly; the full norm includes lower orders and is not dilation-homogeneous.
- The conclusion is a conjunction: $m \le k$ **and** the exponent identity.
- $m$ carries no hypothesis; bounding it is half of what is to be proved.
- The test functions are compactly supported inside $\Omega$, which for the half-space means away from the boundary.
- One constant works for all $u$; that uniformity is the hypothesis.
