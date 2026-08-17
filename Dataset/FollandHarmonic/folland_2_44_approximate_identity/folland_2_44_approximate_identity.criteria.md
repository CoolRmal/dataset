# Criteria: folland_2_44_approximate_identity

**Statement:** [folland_2_44_approximate_identity.md](folland_2_44_approximate_identity.md) · **Lean:** [folland_2_44_approximate_identity.lean](folland_2_44_approximate_identity.lean) · **Context:** [folland_2_44_approximate_identity.context.md](folland_2_44_approximate_identity.context.md)

## What the theorem says

On a locally compact group with a left Haar measure, convolution has no unit, but it has
approximate units. Call a function $\psi$ a *bump for $U$* when its closed support is compact and
contained in the neighbourhood $U$ of the identity, when $\psi \ge 0$, and when $\int\psi = 1$.

The proposition takes a neighbourhood base $\mathcal{U}$ at $1$ and, for each $U \in \mathcal{U}$,
a bump $\psi_U$ for $U$, and concludes that $\psi_U * f \to f$ as $U \to \{1\}$: in the $L^p$ norm
when $1 \le p < \infty$ and $f \in L^p$, and in the uniform norm when $p = \infty$ and $f$ is left
uniformly continuous. If in addition every bump is symmetric, $\psi_U(x^{-1}) = \psi_U(x)$, the
same holds on the other side, $f * \psi_U \to f$, with *right* uniform continuity as the
hypothesis in the $p = \infty$ case. Because the base and the family of bumps are arbitrary, this
is Folland's reading — given $\varepsilon > 0$ there is a neighbourhood $U$ of $1$ such that
*every* bump for $U$ already satisfies $\lVert \psi * f - f\rVert_p < \varepsilon$ — the
closeness is controlled by $U$ alone.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $G$ is a locally compact topological group with its Borel structure, and $\mu$ is a left Haar measure. | ✅ `[IsTopologicalGroup G] [LocallyCompactSpace G] [BorelSpace G]`, `(μ : Measure G) [μ.IsHaarMeasure]`. |
| 2 | The exponent range is $1 \le p \le \infty$, with $f \in L^p$ for the finite-$p$ conclusions and $f$ left (resp. right) uniformly continuous for the $p = \infty$ conclusions. | ✅ `p : ℝ≥0∞`, `hp : 1 ≤ p`; the conclusions are guarded by `p ≠ ∞ → MemLp f p μ → …` and `p = ∞ → IsLeftUniformlyContinuous f → …` (resp. `IsRightUniformlyContinuous f`). |
| 3 | The convergence must hold for **every** neighbourhood base at $1$ and **every** family of admissible bumps indexed by it, as $U \to \{1\}$ — equivalent to the `.md`'s reading: $\varepsilon$ first, then a neighbourhood $U$, then all bumps supported in $U$. | ✅ `𝓤 : Set (Set G)` with `hbase : (𝓝 (1 : G)).HasBasis (· ∈ 𝓤) id` and `ψ : Set G → G → ℝ` are universally quantified hypotheses, and the conclusion is `Tendsto … ((𝓝 (1 : G)).smallSets ⊓ Filter.principal 𝓤) (𝓝 0)`. |
| 4 | Condition (i): each bump has compact support, and its closed support lies inside its $U$. | ✅ `hsupp : ∀ U ∈ 𝓤, HasCompactSupport (ψ U) ∧ tsupport (ψ U) ⊆ U`. |
| 5 | Condition (ii), first half: each bump is nonnegative. | ✅ `hnonneg : ∀ U ∈ 𝓤, ∀ x, 0 ≤ ψ U x`. |
| 6 | Condition (ii), second half: each bump has total mass $1$. | ✅ `hmass : ∀ U ∈ 𝓤, Integrable (ψ U) μ ∧ ∫ x, ψ U x ∂μ = 1`. |
| 7 | The first conclusion is that $\lVert\psi_U * f - f\rVert_p \to 0$, with $\psi$ on the **left**, in both the $p < \infty$ and the $p = \infty$ cases. | ✅ `Tendsto (fun U ↦ eLpNorm (groupConv μ (fun x ↦ (ψ U x : ℂ)) f - f) p μ) F (𝓝 0)`, asserted under both guards of row 2. |
| 8 | The second conclusion, $f * \psi_U \to f$, is asserted only under condition (iii), symmetry $\psi_U(x^{-1}) = \psi_U(x)$ of every bump. | ✅ `(∀ U ∈ 𝓤, ∀ x, ψ U x⁻¹ = ψ U x) → …`, with `groupConv μ f (fun x ↦ (ψ U x : ℂ))` and `IsRightUniformlyContinuous f` in the `p = ∞` case. |
| 9 | Convolution is $\int \psi(y)\,f(y^{-1}x)\,d\mu(y)$. | ✅ `groupConv`, defined in `Defs.lean`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Weakening the quantifier structure: concluding only that *some* family of bumps works (an `∃`-family reading), or letting the neighbourhood depend on the bump. | Both are much weaker. `∃`-family says only that some approximate identity converges, which any single mollifier family supplies; letting $U$ depend on $\psi$ says nothing about how small the support has to be. The ground truth quantifies universally over the base and the family, which is equivalent to the `.md`'s $\forall\varepsilon\,\exists U\,\forall\psi$. This is the highest-value trap. |
| 2 | Asserting the right-hand convergence $\lVert f*\psi_U - f\rVert_p \to 0$ without the symmetry condition (iii). | On a non-unimodular group the two-sided statement genuinely needs $\psi(x^{-1}) = \psi(x)$; without it the modular function appears and the limit is wrong. |
| 3 | Using `Function.support (ψ U) ⊆ U` instead of `tsupport (ψ U) ⊆ U`. | Folland's $\operatorname{supp}\psi$ is the closed support. The open version is a weaker requirement on $\psi$, so it makes the hypothesis on the bump weaker and the theorem stronger than what is printed. |
| 4 | Dropping $\int \psi_U = 1$, or dropping $\psi_U \ge 0$. | Without unit mass, $\psi_U * f$ converges to a multiple of $f$, or to nothing. Without nonnegativity, $\psi_U$ can have unit integral while carrying a large amount of cancelling mass, and the conclusion fails. |
| 5 | Allowing $p = \infty$ with $f$ merely in $L^\infty$. | Folland's $p = \infty$ case requires $f$ to be left (resp. right) uniformly continuous, which is how the ground truth states it. For a general bounded measurable $f$ the conclusion is false. |
| 6 | Convolving on the wrong side: writing $f * \psi_U$ for the first conclusion and $\psi_U * f$ for the second. | The first half of the proposition holds with no symmetry assumption only for $\psi$ on the left; swapping them attaches the hypothesis to the wrong conclusion. |
| 7 | Omitting the $p = \infty$ clauses altogether. | Folland's proposition covers both regimes; a $p < \infty$-only statement drops the uniformly-continuous half of the theorem (charge it to rows 2, 7 and 8). |

## Notes on the ground truth

- Both halves of the proposition are formalized. The `p ≠ ∞` clauses assume `MemLp f p μ`; the
  `p = ∞` clauses assume `IsLeftUniformlyContinuous f` for the first conclusion and
  `IsRightUniformlyContinuous f` for the second — the `Defs.lean` renderings of Folland's
  $C_{lu}(G)$ and $C_{ru}(G)$.
- "As $U \to \{1\}$" is the filter limit along `(𝓝 (1 : G)).smallSets ⊓ Filter.principal 𝓤`:
  membership in the base together with containment in an arbitrarily small neighbourhood of `1`.
  Because the base `𝓤` (with `hbase`) and the family `ψ` are universally quantified hypotheses,
  this renders the `.md`'s $\forall\varepsilon\,\exists U\,\forall\psi$ reading in an equivalent
  fixed-family form: any failing $\varepsilon$–$U$–$\psi$ triple assembles into a failing family.
- `hmass` carries `Integrable (ψ U) μ` explicitly. It is not strictly needed to rule out a junk
  value — Lean gives a divergent integral the value `0`, which cannot equal `1` — but it makes the
  intent plain.
- $\psi_U$ is real-valued, matching the book, and is coerced into `ℂ` (`fun x ↦ (ψ U x : ℂ)`)
  where the convolution needs it.
- The norms are `eLpNorm … p μ`, valued in `ℝ≥0∞`, and the limit target is `𝓝 (0 : ℝ≥0∞)`. At
  `p = ∞` this is the essential supremum with respect to Haar measure, which agrees with the
  uniform norm for the uniformly continuous functions the clause concerns (Haar measure has full
  support).

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

- Requirement 3 with the quantifier structure weakened — an existential over the base or the family ("some approximate identity converges"), or the neighbourhood allowed to depend on the bump. The ground truth's universally quantified family with a filter limit is equivalent to the `.md`'s $\forall\varepsilon\,\exists U\,\forall\psi$; anything strictly weaker is fatal.
- Requirement 8 with the right-hand conclusion asserted without the symmetry hypothesis (iii).
- Requirement 6 with the unit-mass condition dropped: without it $\psi_U * f$ converges to a multiple of $f$.

### Domain-specific pitfalls for this problem

- The convergence is along the small-sets filter over an arbitrary neighbourhood base, with the family of bumps universally quantified; a reading that merely exhibits one convergent family ($\exists$-reading, or a sequential version) is strictly weaker.
- Condition (i) is about the *closed* support being compact and contained in $U$.
- Nonnegativity and unit mass are both needed; either alone gives a different limit.
- Symmetry (iii) is needed only for the $f * \psi_U$ half, and it is the condition $\psi(x^{-1}) = \psi(x)$, not evenness in any additive sense.
- The $p = \infty$ clauses require uniform continuity (left for $\psi * f$, right for $f * \psi$), not mere boundedness; with $f$ only in $L^\infty$ the statement is false.
- Junk value — convolution: the convolution integral must converge for the estimate to be meaningful; here it does, because each $\psi_U$ is integrable and $f$ is in $L^p$ (or bounded and uniformly continuous in the $p = \infty$ clauses).
