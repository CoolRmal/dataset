# Criteria: folland_4_81_almost_periodic_characterization

**Statement:** [folland_4_81_almost_periodic_characterization.md](folland_4_81_almost_periodic_characterization.md) · **Lean:** [folland_4_81_almost_periodic_characterization.lean](folland_4_81_almost_periodic_characterization.lean) · **Context:** [folland_4_81_almost_periodic_characterization.context.md](folland_4_81_almost_periodic_characterization.context.md)

## What the theorem says

Let $G$ be a locally compact abelian group and $f$ a bounded continuous function on it. Folland
gives three equivalent descriptions of what it means for $f$ to be almost periodic: (a) $f$ extends
continuously to the Bohr compactification $bG$; (b) $f$ is a uniform limit of finite linear
combinations $\sum c_\xi\,\xi(x)$ of characters; (c) $f$ is uniformly almost periodic, meaning the
family of its right translates $R_yf(x) = f(xy)$ is totally bounded in the supremum norm — finitely
many translates approximate all of them, uniformly on $G$.

For $G = \mathbb{R}$ this recovers Bohr's classical theory: the almost periodic functions are the
uniform limits of trigonometric polynomials $\sum c_k e^{i\lambda_k x}$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $G$ is a locally compact abelian topological group. | ✅ `[CommGroup G] [TopologicalSpace G] [IsTopologicalGroup G] [LocallyCompactSpace G]`. |
| 2 | $f$ is continuous. | ✅ `hf : Continuous f`. |
| 3 | $f$ is bounded. | ✅ `hbdd : ∃ C : ℝ, ∀ x, ‖f x‖ ≤ C`. |
| 4 | All three of Folland's conditions are asserted equivalent. | ✅ `List.TFAE [extendsToBohr, uniformLimitOfCharacters, IsUniformlyAlmostPeriodic f]`. |
| 5 | Side (b): for every $\varepsilon > 0$ there is an approximating combination. | ✅ `∀ ε : ℝ, 0 < ε → ∃ …`. |
| 6 | The combination is a **finite** sum over characters, with arbitrary complex coefficients. | ✅ `∃ (s : Finset (PontryaginDual G)) (c : PontryaginDual G → ℂ), … ∑ ξ ∈ s, c ξ * (ξ x : ℂ)`. |
| 7 | The approximation is uniform in $x$: one choice of sum works for all $x$ at once. | ✅ The `∀ x` sits **inside** the `∃ s, ∃ c`, so `s` and `c` do not depend on `x`. |
| 8 | Characters are the continuous homomorphisms into the circle, taking values of modulus one. | ✅ `PontryaginDual G`, with `ξ x : Circle` coerced into `ℂ`. |
| 9 | Side (c): the right translates admit a finite $\varepsilon$-net **for the supremum norm**. | ✅ `IsUniformlyAlmostPeriodic f`, spelled out in `Defs.lean` as `∀ ε > 0, ∃ s : Finset G, ∀ y, ∃ z ∈ s, ∀ x, ‖rightTranslate y f x - rightTranslate z f x‖ < ε`. |
| 10 | The translates used are the **right** translates $R_yf(x) = f(xy)$. | ✅ `rightTranslate`, defined in `Defs.lean` as `fun x ↦ f (x * y)`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Writing side (c) as `TotallyBounded (Set.range fun y ↦ rightTranslate y f)` inside `G → ℂ`. | Mathlib puts the product uniformity on `G → ℂ`, which is the uniformity of *pointwise* convergence. Under it every uniformly bounded family is totally bounded, so this condition holds for every bounded $f$ and the equivalence becomes false. This is the highest-value trap in this problem. |
| 2 | Approximating by an infinite series $\sum_{n} c_n \xi_n(x)$ instead of a finite sum. | Folland's (b) is a uniform limit of *finite* linear combinations. Allowing infinite sums changes the class and makes (b) $\Rightarrow$ (c) fail. |
| 3 | Restricting the coefficients to `ℝ`. | The characters are complex-valued; real coefficients do not span the trigonometric polynomials, and the resulting class is smaller. |
| 4 | Putting the `∀ x` outside the choice of `s` and `c`, so the approximating sum may depend on the point. | That is pointwise approximation, which is far weaker than uniform and true for many non-almost-periodic functions. |
| 5 | Measuring the approximation in $L^2$ or $L^1$ instead of uniformly. | Uniform approximation is the whole distinction between almost periodicity and Fourier analysis on the group. |
| 6 | Dropping the boundedness or the continuity of $f$. | Both are standing hypotheses of Folland 4.81. Side (b) forces boundedness automatically, but side (c) as stated does not, so the equivalence needs it. |
| 7 | Stating only one implication. | The theorem is an equivalence; each direction is a separate substantial argument. |

## Notes on the ground truth

- All three of Folland's items are stated, as a `List.TFAE`. Clause (a) is expressed by exhibiting
  a compact Hausdorff group `K` with a continuous dense-range homomorphism `ι : G →* K` through
  which every character of `G` factors — conditions that characterise the Bohr compactification
  `bG` — together with a continuous `F : K → ℂ` restricting to `f` along `ι`.
- `IsUniformlyAlmostPeriodic` is written out in `Defs.lean` as an explicit finite $\varepsilon$-net
  in the supremum norm, precisely to avoid Mathlib's pointwise uniformity on `G → ℂ`. An earlier
  version of the statement used `TotallyBounded` and was satisfied by every bounded function; that
  was rewritten.
- Boundedness is a standing hypothesis rather than a derived fact. It follows from side (b), since
  characters have modulus one and a uniform limit of bounded functions is bounded; it does not drop
  out of the $\varepsilon$-net form of side (c), which only compares translates with each other.
- Folland states 4.81 for a locally compact group, but the section is about locally compact abelian
  groups, where characters exist in abundance; the Lean statement uses `CommGroup` to match.
- `PontryaginDual G` is Mathlib's dual group of continuous characters $G \to \mathbb{T}$, so the
  pairing $\langle x,\xi\rangle$ of the book is the application `ξ x`.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[folland_4_81_almost_periodic_characterization.md](folland_4_81_almost_periodic_characterization.md) and the background in [folland_4_81_almost_periodic_characterization.context.md](folland_4_81_almost_periodic_characterization.context.md),
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

- Requirement 6 with an infinite sum or series of characters instead of a finite linear combination.
- Requirement 7 with the approximation quantified pointwise (a different sum for each $x$) rather than uniformly.
- Requirement 9 with total boundedness replaced by boundedness, which is automatic and empty.

### Domain-specific pitfalls for this problem

- "Uniform limit" means the $\forall x$ sits inside the choice of approximating sum: one trigonometric polynomial works at every point.
- The translates in the definition of almost periodicity are the *right* translates $R_yf(x) = f(xy)$.
- Total boundedness in the supremum norm is a finite-$\varepsilon$-net condition, strictly stronger than boundedness and strictly weaker than relative compactness in a general space.
- Characters take values in the circle, so their modulus is $1$; a formalization using arbitrary continuous homomorphisms into $\mathbb{C}^\times$ states something else.
- Folland's item (a), extension to the Bohr compactification, is part of the printed theorem; omitting it is a genuine incompleteness even when the ambient library has no Bohr compactification.
