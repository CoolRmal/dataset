# Criteria: krylov_sobolev_1_1_13_const_coeff_operator_range_dense

**Statement:** [krylov_sobolev_1_1_13_const_coeff_operator_range_dense.md](krylov_sobolev_1_1_13_const_coeff_operator_range_dense.md) · **Lean:** [krylov_sobolev_1_1_13_const_coeff_operator_range_dense.lean](krylov_sobolev_1_1_13_const_coeff_operator_range_dense.lean) · **Context:** [krylov_sobolev_1_1_13_const_coeff_operator_range_dense.context.md](krylov_sobolev_1_1_13_const_coeff_operator_range_dense.context.md)

## What the theorem says

Take any finite family of complex constants $a^\alpha$ indexed by multi-indices of order at most
$m$, not all of them zero, and form the constant-coefficient operator
$L = \sum_{|\alpha| \le m} a^\alpha D^\alpha$. Apply $L$ to every smooth compactly supported
function. The resulting set of functions is dense in $\mathcal{L}_p$ whenever
$2 \le p < \infty$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $m \ge 1$. | ✅ `hm : 1 ≤ m`. |
| 2 | The coefficients are complex, and not all of them are zero. | ✅ `P : MvPolynomial (Fin d) ℂ` with `hP : P ≠ 0`. |
| 3 | The sum runs over every multi-index with $\lvert \alpha\rvert \le m$, including $\alpha = 0$. | ✅ `hPm : P.totalDegree ≤ m`; the zeroth-order term is the constant coefficient of `P`. |
| 4 | The set in question is the image of $C_0^\infty$ under $L$, seen inside $\mathcal{L}_p$. | ✅ A set of `Lp` elements, each of which is a.e. equal to `L φ` for some smooth compactly supported `φ`. |
| 5 | The claim is density. | ✅ `Dense`. |
| 6 | The exponent range is $2 \le p < \infty$. | ✅ `hp2 : 2 ≤ p` and `hp : p ≠ ⊤`. |
| 7 | Scalars are complex on both sides. | ✅ `φ : … → ℂ` and `Lp ℂ p volume`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Using the range $p \in [1,\infty)$. | That is Theorem 1.1.6, which is about $\lambda - \Delta$. Remark 1.1.14 says explicitly that the general case is known for $p \ge 2$. |
| 2 | Assuming $L$ is elliptic, or that its top-order part is non-zero. | No such assumption is made. Only "not all $a^\alpha$ are zero". |
| 3 | Dropping "not all of which are zero". | If every $a^\alpha = 0$ then $LC_0^\infty = \{0\}$, which is not dense. The statement becomes false. |
| 4 | Using real-valued test functions with a complex target. | The closure would then be only the real subspace of $\mathcal{L}_p$, so the statement would be false. |
| 5 | Asserting density of $L\mathcal{S}$ or of $L\mathcal{L}_p$. | The exercise is about $C_0^\infty$, a strictly smaller class than the Schwartz space. |
| 6 | Formalizing the parenthetical hint about $F(D^\alpha v) = i^{\lvert \alpha\rvert }\xi^\alpha\tilde v$. | That is advice for the proof, not part of the claim, and it depends on Krylov's Fourier normalization. |

## Notes on the ground truth

- The coefficient family is packaged as a multivariate polynomial, because a `MvPolynomial (Fin d) ℂ` is exactly a finitely supported family of complex numbers indexed by multi-indices. `totalDegree ≤ m` says precisely that $a^\alpha = 0$ whenever $|\alpha| > m$.
- `[Fact (1 ≤ p)]` appears only so that `Lp ℂ p volume` has its normed-space structure; it follows from `hp2` and adds no restriction.
- `p ≠ ⊤` is used rather than `p ≠ ∞` because `∞` is ambiguous once the `ContDiff` scope is open.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[krylov_sobolev_1_1_13_const_coeff_operator_range_dense.md](krylov_sobolev_1_1_13_const_coeff_operator_range_dense.md) and the background in [krylov_sobolev_1_1_13_const_coeff_operator_range_dense.context.md](krylov_sobolev_1_1_13_const_coeff_operator_range_dense.context.md),
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

- Requirement 2 with the non-vanishing hypothesis on the coefficients dropped: for $L = 0$ the range is $\{0\}$.
- Requirement 6 with the exponent range widened to $[1,\infty)$.
- Requirement 5 with surjectivity claimed instead of density.

### Domain-specific pitfalls for this problem

- The coefficients are complex and only jointly non-zero; no ellipticity is assumed.
- The sum includes $\alpha = 0$, so $L$ may have a zeroth-order term.
- Density is a topological statement about the closure of the image inside $\mathcal{L}_p$.
- Both the test functions and the target space are complex-scalar.
