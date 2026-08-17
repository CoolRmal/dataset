# Criteria: folland_2_40_convolution_lp_bound

**Statement:** [folland_2_40_convolution_lp_bound.md](folland_2_40_convolution_lp_bound.md) · **Lean:** [folland_2_40_convolution_lp_bound.lean](folland_2_40_convolution_lp_bound.lean) · **Context:** [folland_2_40_convolution_lp_bound.context.md](folland_2_40_convolution_lp_bound.context.md)

## What the theorem says

Work on a locally compact group $G$ with a left Haar measure, and define convolution by
$f*g(x) = \int f(y)\,g(y^{-1}x)\,dy$. Take $1 \le p \le \infty$, an integrable $f$ and a $g$ in
$L^p$.

Part (a): the defining integral converges absolutely for almost every $x$, the resulting function
$f*g$ lies in $L^p$, and $\lVert f*g\rVert_p \le \lVert f\rVert_1\lVert g\rVert_p$. This is Young's inequality with the $L^1$
factor on the left.

Part (b): if $G$ is unimodular, the same holds with the factors in the other order, $g*f$. Part (c):
even when $G$ is not unimodular, $g*f$ still lies in $L^p$ provided $f$ has compact support. Left
and right are genuinely different here, because the group need not be abelian and the Haar measure
need not be right invariant.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $G$ is a locally compact topological group with its Borel structure, and $\mu$ is a left Haar measure. | ✅ `[IsTopologicalGroup G] [LocallyCompactSpace G] [BorelSpace G]`, `(μ : Measure G) [μ.IsHaarMeasure]`. |
| 2 | The exponent range is $1 \le p \le \infty$, with $p = \infty$ allowed. | ✅ `p : ℝ≥0∞` with only `hp : 1 ≤ p`; no `p ≠ ∞`. |
| 3 | $f$ is integrable and $g$ is in $L^p$. | ✅ `hf : Integrable f μ`, `hg : MemLp g p μ`. |
| 4 | Convolution is $\int f(y)\,g(y^{-1}x)\,d\mu(y)$. | ✅ `groupConv μ f g`, defined in `Defs.lean` as `fun x ↦ ∫ y, f y * g (y⁻¹ * x) ∂μ`. |
| 5 | Part (a) asserts that the defining integral converges absolutely for almost every $x$. | ✅ `∀ᵐ x ∂μ, Integrable (fun y ↦ f y * g (y⁻¹ * x)) μ`. |
| 6 | Part (a) asserts $f*g \in L^p$. | ✅ `MemLp (groupConv μ f g) p μ`. |
| 7 | Part (a) asserts the norm bound $\lVert f*g\rVert_p \le \lVert f\rVert_1\lVert g\rVert_p$. | ✅ `eLpNorm (groupConv μ f g) p μ ≤ eLpNorm f 1 μ * eLpNorm g p μ`. |
| 8 | Part (b) is stated only under unimodularity, and gives all three conclusions for $g*f$: a.e. absolute convergence of the defining integrals, $g*f \in L^p$, and the same bound. | ✅ `IsUnimodular G → (∀ᵐ x ∂μ, Integrable (fun y ↦ g y * f (y⁻¹ * x)) μ) ∧ MemLp (groupConv μ g f) p μ ∧ eLpNorm (groupConv μ g f) p μ ≤ eLpNorm f 1 μ * eLpNorm g p μ`, mirroring part (a). |
| 9 | Part (c) is stated under compact support of $f$, and gives $g*f \in L^p$. | ✅ `HasCompactSupport f → MemLp (groupConv μ g f) p μ`. |
| 10 | All three parts are asserted, not just one. | ✅ A three-fold conjunction. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Asserting $\lVert g*f\rVert_p \le \lVert f\rVert_1\lVert g\rVert_p$ with no unimodularity hypothesis. | False on a non-unimodular group such as the $ax+b$ group. This is the highest-value trap: part (b) is where the modular function enters. |
| 2 | Formalizing only part (a). | Two-thirds of the proposition is missing, and the missing two-thirds are what distinguishes this from the abelian Young inequality. |
| 3 | Omitting the a.e. absolute convergence conjunct in (a). | Lean gives a divergent Bochner integral the value `0`, so `groupConv μ f g` is defined everywhere no matter what. The norm bound could then be a statement about a function that is `0` on a large set, and would hold for free. |
| 4 | Requiring $p \ne \infty$. | Folland allows $p = \infty$ in this proposition; excluding it drops a case. |
| 5 | Writing convolution additively, as $\int f(y)g(x - y)\,dy$, or as $\int f(y)g(xy^{-1})\,dy$. | The first only makes sense on an abelian group; the second is the *other* convolution, which pairs with right Haar measure and does not satisfy the printed bound. |
| 6 | Swapping the norms, e.g. $\lVert f*g\rVert_p \le \lVert f\rVert_p\lVert g\rVert_1$. | With $f \in L^1$ and $g \in L^p$ this pairs each function with the wrong exponent; the quantities on the right need not even be finite. |
| 7 | Adding "$G$ is not unimodular" as a hypothesis of part (c). | Folland's phrasing is rhetorical — (c) is the case not already covered by (b). Stating (c) for all $G$ is correct and stronger. |
| 8 | Giving part (b) only the membership and norm conclusions, without the a.e. absolute-convergence conjunct for $g*f$. | Folland's (b) says "the same conclusions hold with $f*g$ replaced by $g*f$" — all three of them, including the a.e. convergence of the defining integrals. An earlier version of the ground truth dropped this conjunct; the current ground truth incorporates the repair and states (b) in full, mirroring (a). |

## Notes on the ground truth

- Part (c) is stated without any unimodularity assumption, which is stronger than the printed (c)
  and still true, since the unimodular case follows from (b).
- Unimodularity is expressed as `∀ y : G, Measure.modularCharacterFun y = 1` rather than through a
  type class, so that no extra instance is needed for the other two parts.
- `groupConv` is defined in `Defs.lean` because Mathlib's `MeasureTheory.convolution` is set up for
  additive groups and does not cover a general multiplicative locally compact group.
- The norms are `eLpNorm … μ`, valued in `ℝ≥0∞`, so the inequality never presupposes that either
  side is finite. `MemLp` is stated separately and carries the finiteness claim.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[folland_2_40_convolution_lp_bound.md](folland_2_40_convolution_lp_bound.md) and the background in [folland_2_40_convolution_lp_bound.context.md](folland_2_40_convolution_lp_bound.context.md),
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

- Requirement 8 with part (b) asserted without the unimodularity hypothesis: false on a non-unimodular group.
- Requirement 5 dropped, so that the conclusions are about a function whose defining integral has not been shown to converge.
- Requirement 4 with $f*g$ and $g*f$ interchanged in any part.

### Domain-specific pitfalls for this problem

- Junk value — convolution: a convolution defined by a Bochner integral is `0` wherever the integral diverges. The a.e.-convergence claims carried by parts (a) and (b) are what make the membership and norm clauses meaningful.
- Which factor is on the left is part of every clause; convolution on a non-abelian group is not commutative.
- Part (c) claims membership only, not the norm bound.
- The exponent lives in `ℝ≥0∞` and $p = \infty$ is included, so the $L^p$ norms must be `eLpNorm`-style and not presuppose finiteness.
- Unimodularity has to be stated as $\Delta \equiv 1$ (or by a Mathlib class expressing it), not as commutativity of $G$.
