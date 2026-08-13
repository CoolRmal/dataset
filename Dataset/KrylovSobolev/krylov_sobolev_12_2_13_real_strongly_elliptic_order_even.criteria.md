# Criteria: krylov_sobolev_12_2_13_real_strongly_elliptic_order_even

**Statement:** [krylov_sobolev_12_2_13_real_strongly_elliptic_order_even.md](krylov_sobolev_12_2_13_real_strongly_elliptic_order_even.md) · **Lean:** [krylov_sobolev_12_2_13_real_strongly_elliptic_order_even.lean](krylov_sobolev_12_2_13_real_strongly_elliptic_order_even.lean)

## What the theorem says

A constant-coefficient operator of order $m$ is strongly elliptic when two things hold: its
top-order symbol $\sum_{|\alpha|=m}a^\alpha\xi^\alpha$ is non-zero for every real
$\xi \ne 0$, and its characteristic polynomial
$\sum_{|\alpha|\le m}a^\alpha i^{|\alpha|}\xi^\alpha$ is non-zero for every real $\xi$. If all
the coefficients happen to be real numbers, and the dimension is at least $2$, then the order $m$
cannot be odd.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | Both conditions of Definition 12.2.1 are assumed. | ✅ `IsStronglyElliptic` is the conjunction of the degree bound and the two non-vanishing conditions. |
| 2 | The first condition uses the $\lvert \alpha\rvert = m$ homogeneous part of the symbol. | ✅ `MvPolynomial.homogeneousComponent m P`. |
| 3 | $\xi$ ranges over real vectors in both conditions. | ✅ `ξ : Fin d → ℝ`, cast into `ℂ` where needed. |
| 4 | $m \ge 1$. | ✅ `hm : 1 ≤ m`. |
| 5 | $d \ge 2$. | ✅ `hd : 2 ≤ d`. |
| 6 | Every coefficient is real, the lower-order ones included. | ✅ `hreal : ∀ α, (P.coeff α).im = 0`, quantified over all multi-indices. |
| 7 | The conclusion is that $m$ is even. | ✅ `Even m`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Dropping the second ellipticity condition because the proof only uses the first. | The hypothesis of the printed exercise includes both. Dropping one changes the theorem. |
| 2 | Dropping $d \ge 2$. | The statement is false in dimension $1$: $L = D - 1$ is first-order and strongly elliptic there. |
| 3 | Letting $\xi$ range over complex vectors. | For $m \ge 1$ a homogeneous polynomial of positive degree always has non-trivial complex zeros, so the first condition would be unsatisfiable and the theorem vacuous. |
| 4 | Using `P.totalDegree = m` in place of the $m$-homogeneous component. | Those are different objects. The symbol's principal part is the homogeneous piece of degree $m$, whether or not $P$ actually attains degree $m$. |
| 5 | Adding "the principal part is non-zero" as a separate hypothesis. | It already follows from the first ellipticity condition, so it is redundant. |
| 6 | Assuming only that the top-order coefficients are real. | The exercise says the coefficients $a^\alpha$ are real, meaning all of them. |

## Notes on the ground truth

- The coefficient family $(a^\alpha)_{|\alpha| \le m}$ is packaged as a `MvPolynomial (Fin d) ℂ`; the characteristic polynomial $\sum a^\alpha i^{|\alpha|}\xi^\alpha$ is then simply $P$ evaluated at $i\xi$, since $\sum_\alpha a^\alpha\prod_j(i\xi^j)^{\alpha_j} = P(i\xi)$.
- Mathlib has no notion of an elliptic differential operator, so `IsStronglyElliptic` is a new definition; it is three short conjuncts and nothing more.
