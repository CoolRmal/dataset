# Criteria: folland_2_69_convolution_factorization

**Statement:** [folland_2_69_convolution_factorization.md](folland_2_69_convolution_factorization.md) · **Lean:** [folland_2_69_convolution_factorization.lean](folland_2_69_convolution_factorization.lean) · **Context:** [folland_2_69_convolution_factorization.context.md](folland_2_69_convolution_factorization.context.md)

## What the theorem says

On any locally compact group $G$, convolving an $L^1$ function with an $L^p$ function gives an
$L^p$ function; that much is Young's inequality. The theorem says the reverse: for
$1 \le p < \infty$, *every* $L^p$ function arises this way. Written as sets,
$L^1(G) * L^p(G) = L^p(G)$.

So given $f \in L^p$ one can find $g \in L^1$ and $h \in L^p$ with $g * h = f$ exactly, not merely
approximately. This is a special case of Cohen's factorization theorem. Folland's theorem also
records the $p = \infty$ analogues, where the answer is the uniformly continuous functions rather
than $L^\infty$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $G$ is a locally compact topological group with its Borel structure, and $\mu$ is a left Haar measure. | ✅ `[IsTopologicalGroup G] [LocallyCompactSpace G] [BorelSpace G]`, `(μ : Measure G) [μ.IsHaarMeasure]`. |
| 2 | The exponent satisfies $1 \le p$ and $p \ne \infty$. | ✅ `hp : 1 ≤ p`, `hp' : p ≠ ∞`. |
| 3 | The theorem applies to an arbitrary $f \in L^p$, given in advance. | ✅ Each clause quantifies over its own $f$ inside the conclusion, so all four printed identities are asserted for every function of the relevant class. |
| 4 | The conclusion produces two factors. | ✅ `∃ g h : G → ℂ`. |
| 5 | The left factor is integrable. | ✅ `Integrable g μ`. |
| 6 | The right factor is in $L^p$. | ✅ `MemLp h p μ`. |
| 7 | The convolution of the two factors equals $f$, exactly, almost everywhere. | ✅ `∀ᵐ x ∂μ, groupConv μ g h x = f x`. |
| 8 | The $L^1$ factor sits on the **left** of the convolution. | ✅ `groupConv μ g h`, with `g` the integrable one. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Stating only the inclusion $L^1 * L^p \subseteq L^p$. | That is Young's inequality (Folland 2.40, a separate problem in this book). The content of 2.69 is the reverse inclusion — surjectivity of convolution onto $L^p$. This is the highest-value trap. |
| 2 | Asserting an approximate factorization, e.g. for every $\varepsilon$ there are $g,h$ with $\lVert g*h - f\rVert_p < \varepsilon$. | Much weaker, and immediate from the approximate identity (2.44). The theorem asserts exact equality. |
| 3 | Writing `∀ x, groupConv μ g h x = f x` instead of `∀ᵐ x ∂μ`. | Convolution of an $L^1$ with an $L^p$ function is only defined almost everywhere, and $f$ itself is only determined almost everywhere, so pointwise equality everywhere is not something one can ask for. |
| 4 | Allowing $p = \infty$. | Folland's $p = \infty$ clause has a *different* conclusion: $L^1 * L^\infty = C_{lu}(G)$, the bounded left uniformly continuous functions, not $L^\infty$. Keeping the $L^p$ conclusion at $p = \infty$ states something false. |
| 5 | Putting the $L^p$ factor on the left, $h * g$. | That is the right-handed statement, which on a non-unimodular group is a genuinely different assertion (Folland states it separately, with $C_{ru}$). |
| 6 | Dropping `Integrable g μ` or `MemLp h p μ`. | The factorization is only interesting because the factors live in the stated spaces. Without those constraints the statement is about arbitrary functions and loses its meaning. |
| 7 | Asserting the inclusion $L^\infty * L^1 \subseteq C_{ru}$ for arbitrary $g \in L^\infty$ and $h \in L^1$ of the *left* Haar measure. | On a non-unimodular group $\int \lvert h(y^{-1}x)\rvert\,d\mu(y) = \int \lvert h\rvert\,\Delta^{-1}\,d\mu$ can be infinite, so the defining integral of $g*h$ can diverge and the junk-completed convolution need not be right uniformly continuous — the clause then asserts something the book's set equation does not. The clause needs $h$ integrable for the *right* Haar measure as well. An earlier version of the ground truth omitted this guard; the current ground truth incorporates the repair. |

## Notes on the ground truth

- All four printed identities are stated: $L^1 * L^p = L^p$, $L^1 * L^\infty = L^1 * C_{lu} = C_{lu}$
  and $L^\infty * L^1 = C_{ru} * L^1 = C_{ru}$, using `IsLeftUniformlyContinuous` and
  `IsRightUniformlyContinuous` added to `Defs.lean` for $C_{lu}$ and $C_{ru}$.
- Both halves of each set equality are stated: the factorization and the inclusion.
- `groupConv μ g h x` takes the value `0` wherever its defining integral diverges. The statement
  does not separately assert that the integral converges almost everywhere; it does not need to,
  because that follows from `Integrable g μ` and `MemLp h p μ` by Folland 2.40(a), and because
  the a.e. equality with `f` is an honest claim either way.
- `groupConv` is defined in `Defs.lean` because Mathlib's `MeasureTheory.convolution` is set up for
  additive groups and does not cover a general multiplicative locally compact group.
- The three $C_{ru}$ clauses carry the extra conjunct `Integrable (fun y ↦ h y⁻¹) μ`, which says
  $\int \lvert h\rvert\,\Delta^{-1}\,d\mu < \infty$ — $h \in L^1$ of the right Haar measure — without
  needing the modular function in `Defs.lean`. On the inclusion clause it is a hypothesis: it is
  exactly the condition under which the defining integral of $g*h$ converges absolutely for every
  $x$ and every bounded $g$, and without it the clause would overstate the book (and is likely
  false on non-unimodular groups). On the two factorization clauses it is a produced property of
  the witness $h$, a harmless strengthening of the existential (the constructed $h$ can be taken
  compactly supported). An earlier version of the ground truth asserted the inclusion unguarded;
  the current ground truth incorporates the repair. On the $C_{lu}$ side no such guard is needed:
  there the finiteness of $\int \lvert g(y) h(y^{-1}x)\rvert\,d\mu(y)$ already follows from
  `Integrable g μ` and boundedness of `h`.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[folland_2_69_convolution_factorization.md](folland_2_69_convolution_factorization.md) and the background in [folland_2_69_convolution_factorization.context.md](folland_2_69_convolution_factorization.context.md),
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

- Requirement 7 with an approximate factorization ($g*h$ close to $f$) instead of exact a.e. equality: that is the approximate-identity statement and is much weaker.
- Requirement 8 with the $L^1$ factor on the wrong side.
- Requirement 2 with $p = \infty$ admitted in the $L^p$ clause.

### Domain-specific pitfalls for this problem

- The set equation packages two inclusions; the substantive one is that every $L^p$ function factors exactly.
- Junk value — convolution: `groupConv` returns `0` where its defining integral diverges, so the a.e. equality with $f$ must be read together with the integrability of the factors.
- Convolution is not commutative; the side of the $L^1$ factor is part of the claim.
- Folland's sentence also covers $L^\infty$, $C_{lu}$ and $C_{ru}$; a candidate that formalizes only the $L^p$ clause has stated part of the theorem.
- In the $L^\infty * L^1$ direction the defining integral converges only when $h$ is integrable for the *right* Haar measure too; the ground truth encodes this as `Integrable (fun y ↦ h y⁻¹) μ`.
