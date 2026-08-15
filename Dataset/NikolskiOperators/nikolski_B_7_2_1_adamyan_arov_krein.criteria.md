# Criteria: nikolski_B_7_2_1_adamyan_arov_krein

**Statement:** [nikolski_B_7_2_1_adamyan_arov_krein.md](nikolski_B_7_2_1_adamyan_arov_krein.md) · **Lean:** [nikolski_B_7_2_1_adamyan_arov_krein.lean](nikolski_B_7_2_1_adamyan_arov_krein.lean) · **Context:** [nikolski_B_7_2_1_adamyan_arov_krein.context.md](nikolski_B_7_2_1_adamyan_arov_krein.context.md)

## What the theorem says

Take a Hankel operator $H_\varphi$ with symbol $\varphi$. Adamyan, Arov and Krein prove that four
numbers coincide. The first is $s_n(H_\varphi)$, the $n$-th singular value, which is the distance
from $H_\varphi$ to arbitrary operators of rank at most $n$. The second is the distance to
*Hankel* operators of rank at most $n$. The third is the distance in $L^\infty$ from $\varphi$ to
$R_n + H^\infty$, where $R_n$ is the set of rational functions vanishing at infinity whose poles
all lie in the disc and have total multiplicity at most $n$. The fourth is the smallest norm of the
Hankel operators with symbol $\bar B\varphi$, over finite Blaschke products $B$ of degree at most
$n$. The striking part is that the first two agree: restricting the approximants to be Hankel costs
nothing.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The matrix data and the symbol are tied together: $\varphi$ is essentially bounded and $\hat\varphi(-n-1) = a_n$. | ✅ The single hypothesis `HasBoundedHankelSymbol a φ`. |
| 2 | The first quantity is the $n$-th approximation number: the distance to arbitrary matrices of rank at most $n$. | ✅ `hankelApproximationNumber a n`, whose competitors satisfy `MatrixRankLE n B`. |
| 3 | The second quantity is the distance to *Hankel* matrices of rank at most $n$. | ✅ `hankelRankApproximationDistance a n`; its competitors are given by a single sequence `b` used as `b (i + j)`, so the Hankel structure is built in. |
| 4 | "Rank at most $n$" is expressed as a factorization through an $n$-dimensional space. | ✅ `∃ u v : Fin n → ℕ → ℂ, … ∧ ∀ i j, b (i + j) = ∑ q, u q i * v q j`. |
| 5 | The third quantity is the $L^\infty$ distance from $\varphi$ to $R_n + H^\infty$. | ✅ `rationalPlusHInfinityDistance φ n`, an infimum over `ψ` in $R_n$ and `h` in $H^\infty$ of `eLpNorm (φ - ψ - boundaryValue h) ∞`. |
| 6 | $R_n$ is: rational, tending to $0$ at infinity (numerator degree strictly below denominator degree), all poles inside the disc, total pole multiplicity at most $n$ — and it contains the zero function. | ✅ `RationalVanishingAtInfinityDegreeLE n ψ` = `ψ = 0 ∨ (numerator.natDegree < denominator.natDegree ∧ denominator.natDegree ≤ n ∧ denominator ≠ 0 ∧ all roots in the ball ∧ ψ = num/den)`. |
| 7 | The fourth quantity ranges over finite Blaschke products of degree at most $n$, with zeros counted with multiplicity and degree $0$ allowed. | ✅ `FiniteBlaschkeProductDegreeLE n B` uses `∃ m ≤ n, ∃ a : Fin m → ℂ`, so entries may repeat and `m = 0` gives a unimodular constant. |
| 8 | The fourth quantity is the norm of the Hankel operator with symbol $\bar B\varphi$. | ✅ `finiteBlaschkeHankelDistance φ n` takes the infimum of `hankelFormNorm b` over `b` with `HasBoundedHankelSymbol b (fun ζ ↦ star (boundaryValue B ζ) * φ ζ)`. |
| 9 | All four quantities are asserted equal. | ✅ Three conjoined equalities chaining the four terms. |
| 10 | All four quantities live in $[0,\infty]$, so that degenerate cases are not silently rounded to $0$. | ✅ Every one of the four is an `sInf` over a subset of `ℝ≥0∞`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Encoding $R_n$ so that the zero function is excluded — for instance by demanding a numerator degree strictly below a denominator degree of at most $n$ with no separate case for $\psi = 0$. | For $n = 0$ that is unsatisfiable in $\mathbb{N}$, so the class is empty and its distance is the empty infimum $\infty$, while the other three terms are $\lVert H_\varphi\rVert$. With $\varphi = 0$ the chain then asserts $0 = \infty$. $R_0$ is $\{0\}$ and the theorem must degenerate to Nehari's identity. |
| 2 | Letting the approximant in the second term be an arbitrary matrix of rank at most $n$. | That collapses the second term into the first and throws away the theorem's content, which is precisely that a Hankel approximant achieves the same distance. |
| 3 | Dropping the singular-value term $s_n(H_\varphi)$ and relating only the last three quantities. | The headline of the theorem is that a singular value — defined by approximation with arbitrary operators — is attained among Hankel operators. |
| 4 | Forgetting the requirement that the numerator degree is strictly below the denominator degree. | That requirement is what encodes "tending to $0$ at infinity". Without it, $R_n$ contains constants and polynomials and the distance changes. |
| 5 | Allowing poles on or outside the unit circle. | Poles off the disc contribute nothing new modulo $H^\infty$, and poles on the circle leave $L^\infty$; either way the class is wrong. |
| 6 | Taking the infima over sets of real numbers. | The infimum of an empty set of reals is $0$, which would make degenerate cases silently equal instead of exposing them. |
| 7 | Requiring the Blaschke degree to be exactly $n$, or forbidding the empty product. | Degree $0$ (a unimodular constant) has to be admissible, and repeated zeros have to be admissible, or the fourth infimum is over the wrong class. |
| 8 | Stating the equalities for an arbitrary pair (matrix data, symbol) with no relation between them. | The two sides then describe unrelated objects and the statement is false. |

## Notes on the ground truth

- The text says "min" twice: the infima are *attained*, by an optimal Hankel approximant and by an
  optimal Blaschke product. All four quantities here are infima, so attainment is not asserted. A
  stronger formalization would add clauses such as "there is a `b` with `HankelMatrixRankLE n b`
  achieving the value", and likewise for $B$.
- An earlier version of this file had no `ψ = 0` case in $R_n$ and no singular-value term. Both are
  now present; Mistakes 1 and 3 record the former defects.
- `MatrixRankLE` and `HankelMatrixRankLE` also require the factorizing sequences to be square
  summable. That is not part of "rank at most $n$", though it is automatic for bounded finite-rank
  Hankel operators.
- `hankelApproximationNumber` and `hankelRankApproximationDistance` guard their defining sets with
  `C < ∞`, which is needed because the bound is stated with `C.toReal` and Lean sends $\infty$ to
  $0$ under that conversion. `rationalPlusHInfinityDistance` compares in $[0,\infty]$ directly and
  needs no guard. The asymmetry is sound but inconsistent.
- Bounding `denominator.natDegree` is the right proxy for total pole multiplicity, since every
  element of $R_n$ has a reduced representation in which the denominator degree is exactly the
  total pole multiplicity.
- The Blaschke factors $\frac{z - a_i}{1 - \bar a_i z}$ differ from the textbook's $b_{\lambda}$ by
  a unimodular constant, which is absorbed into the leading constant `c`.
- `finiteBlaschkeHankelDistance` uses `boundaryValue B`, whose junk value lives on a null set and
  is invisible to the integral definitions inside `HasBoundedHankelSymbol`; `InnerFunction B`,
  required by `FiniteBlaschkeProductDegreeLE`, already asserts that the radial limits exist almost
  everywhere.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[nikolski_B_7_2_1_adamyan_arov_krein.md](nikolski_B_7_2_1_adamyan_arov_krein.md) and the background in [nikolski_B_7_2_1_adamyan_arov_krein.context.md](nikolski_B_7_2_1_adamyan_arov_krein.context.md),
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

- Requirement 6 with $R_n$ not containing the zero function, or with the degree condition on the rational functions wrong.
- Requirement 3 with the second quantity taken over arbitrary rather than Hankel operators, collapsing it into the first.
- Requirement 9 with fewer than all four quantities asserted equal.

### Domain-specific pitfalls for this problem

- Rank at most $n$ should be expressed by a factorization through an $n$-dimensional space, not by a `rank` function that could return a default.
- $R_n$ consists of rational functions tending to $0$ at infinity with poles inside the disc; the zero function is a member, with degree $0$.
- The degree of an inner function is the number of zeros of the corresponding finite Blaschke product, counted with multiplicity, and $\infty$ otherwise.
- All four quantities are infima or minima and belong in $[0,\infty]$.
- The symbol $\bar B\varphi$ carries a complex conjugate on the Blaschke product, not a harmonic conjugate.
