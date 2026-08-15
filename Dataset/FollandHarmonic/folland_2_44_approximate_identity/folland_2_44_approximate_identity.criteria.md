# Criteria: folland_2_44_approximate_identity

**Statement:** [folland_2_44_approximate_identity.md](folland_2_44_approximate_identity.md) · **Lean:** [folland_2_44_approximate_identity.lean](folland_2_44_approximate_identity.lean) · **Context:** [folland_2_44_approximate_identity.context.md](folland_2_44_approximate_identity.context.md)

## What the theorem says

On a locally compact group with a left Haar measure, convolution has no unit, but it has
approximate units. Call a function $\psi$ a *bump for $U$* when its closed support is compact and
contained in the neighbourhood $U$ of the identity, when $\psi \ge 0$, and when $\int\psi = 1$.

The proposition says that for $1 \le p < \infty$ and $f \in L^p$, convolving with such a bump
returns something close to $f$, and the closeness is controlled by $U$ alone: given $\varepsilon > 0$
there is a neighbourhood $U$ of $1$ such that *every* bump for $U$ already satisfies
$\lVert \psi * f - f\rVert_p < \varepsilon$. If the bump is also symmetric, $\psi(x^{-1}) = \psi(x)$, the same
holds for the convolution on the other side, $\lVert f * \psi - f\rVert_p < \varepsilon$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $G$ is a locally compact topological group with its Borel structure, and $\mu$ is a left Haar measure. | ✅ `[IsTopologicalGroup G] [LocallyCompactSpace G] [BorelSpace G]`, `(μ : Measure G) [μ.IsHaarMeasure]`. |
| 2 | The exponent satisfies $1 \le p < \infty$, and $f$ lies in $L^p$. | ✅ `hp : 1 ≤ p`, `hp' : p ≠ ∞`, `hf : MemLp f p μ`. |
| 3 | The quantifiers run: given $\varepsilon > 0$, there is a neighbourhood $U$ of the identity, such that **every** admissible bump supported in $U$ works. | ✅ `(ε : ℝ≥0∞) (hε : 0 < ε)` then `∃ U ∈ 𝓝 (1 : G), ∀ ψ : G → ℝ, …`. |
| 4 | Condition (i): the bump has compact support, and its closed support lies inside $U$. | ✅ `HasCompactSupport ψ` and `tsupport ψ ⊆ U`. |
| 5 | Condition (ii), first half: the bump is nonnegative. | ✅ `∀ x, 0 ≤ ψ x`. |
| 6 | Condition (ii), second half: the bump has total mass $1$. | ✅ `∫ x, ψ x ∂μ = 1`, with `Integrable ψ μ` alongside it. |
| 7 | The first conclusion is that $\psi * f$ is within $\varepsilon$ of $f$ in $L^p$, with $\psi$ on the **left**. | ✅ `eLpNorm (groupConv μ (fun x ↦ (ψ x : ℂ)) f - f) p μ < ε`. |
| 8 | The second conclusion, $f * \psi$ close to $f$, is asserted only under condition (iii), $\psi(x^{-1}) = \psi(x)$. | ✅ `(∀ x, ψ x⁻¹ = ψ x) → eLpNorm (groupConv μ f (fun x ↦ (ψ x : ℂ)) - f) p μ < ε`. |
| 9 | Convolution is $\int \psi(y)\,f(y^{-1}x)\,d\mu(y)$. | ✅ `groupConv`, defined in `Defs.lean`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Putting the quantifiers as `∀ ψ, ∃ U` or `∃ ψ, …`. | Both are much weaker. `∃ ψ` says only that *some* bump works, which any single approximate identity supplies; `∀ ψ, ∃ U` lets the neighbourhood depend on the bump, so it says nothing about how small the support has to be. This is the highest-value trap. |
| 2 | Asserting the right-hand convergence $\lVert f*\psi - f\rVert_p \to 0$ without the symmetry condition (iii). | On a non-unimodular group the two-sided statement genuinely needs $\psi(x^{-1}) = \psi(x)$; without it the modular function appears and the limit is wrong. |
| 3 | Using `Function.support ψ ⊆ U` instead of `tsupport ψ ⊆ U`. | Folland's $\operatorname{supp}\psi$ is the closed support. The open version is a weaker requirement on $\psi$, so it makes the hypothesis on the bump weaker and the theorem stronger than what is printed. |
| 4 | Dropping $\int \psi = 1$, or dropping $\psi \ge 0$. | Without unit mass, $\psi * f$ converges to a multiple of $f$, or to nothing. Without nonnegativity, $\psi$ can have unit integral while carrying a large amount of cancelling mass, and the conclusion fails. |
| 5 | Allowing $p = \infty$ while keeping $f$ merely in $L^\infty$. | Folland's $p = \infty$ case requires $f$ to be left (resp. right) uniformly continuous. For a general bounded measurable $f$ the conclusion is false. |
| 6 | Convolving on the wrong side: writing $f * \psi$ for the first conclusion and $\psi * f$ for the second. | The first half of the proposition holds with no symmetry assumption only for $\psi$ on the left; swapping them attaches the hypothesis to the wrong conclusion. |

## Notes on the ground truth

- Only the $p < \infty$ half of the proposition is formalized. Folland's $p = \infty$ clause, which
  needs $f$ left uniformly continuous for the first conclusion and right uniformly continuous for
  the second, is omitted. That is a proper restriction of the printed statement, not a distortion
  of it.
- "As $U \to \{1\}$" is unpacked exactly as the `.md` explains it: $\varepsilon$ first, then a
  neighbourhood $U$, then all bumps supported in $U$.
- `Integrable ψ μ` is carried explicitly. It is not strictly needed to rule out a junk value —
  Lean gives a divergent integral the value `0`, which cannot equal `1` — but it makes the intent
  plain and is used by the conclusion.
- $\psi$ is real-valued, matching the book, and is coerced into `ℂ` where the convolution needs it.
- `ε` is taken in `ℝ≥0∞`, so `ε = ∞` is permitted by `0 < ε`. That instance of the statement is
  trivially true and harmless.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[folland_2_44_approximate_identity.md](folland_2_44_approximate_identity.md) and the background in [folland_2_44_approximate_identity.context.md](folland_2_44_approximate_identity.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 9 rows, so each row is worth 5.6 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 3 with the quantifiers reordered — in particular fixing one family $\psi_U$ in advance rather than quantifying over all admissible bumps supported in $U$.
- Requirement 8 with the right-hand conclusion asserted without the symmetry hypothesis (iii).
- Requirement 6 with the unit-mass condition dropped: without it $\psi * f$ converges to a multiple of $f$.

### Domain-specific pitfalls for this problem

- The statement is $\forall \varepsilon\, \exists U\, \forall \psi$; a sequential reading ($\exists$ a family with norms tending to $0$) is strictly weaker.
- Condition (i) is about the *closed* support being compact and contained in $U$.
- Nonnegativity and unit mass are both needed; either alone gives a different limit.
- Symmetry (iii) is needed only for the $f * \psi$ half, and it is the condition $\psi(x^{-1}) = \psi(x)$, not evenness in any additive sense.
- Junk value — convolution: the convolution integral must converge for the $L^p$ estimate to be meaningful; here it does, because $\psi$ is integrable and $f \in L^p$.
