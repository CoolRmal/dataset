# Criteria: krylov_2_5_2_harmonic_smooth_interior_estimates

**Statement:** [krylov_2_5_2_harmonic_smooth_interior_estimates.md](krylov_2_5_2_harmonic_smooth_interior_estimates.md) · **Lean:** [krylov_2_5_2_harmonic_smooth_interior_estimates.lean](krylov_2_5_2_harmonic_smooth_interior_estimates.lean) · **Context:** [krylov_2_5_2_harmonic_smooth_interior_estimates.context.md](krylov_2_5_2_harmonic_smooth_interior_estimates.context.md)

## What the theorem says

A harmonic function on a domain is automatically infinitely differentiable there, even though only
two derivatives were assumed. On top of that, every derivative is controlled by the size of the
function itself on a ball: if the ball of radius $R$ around $x$ lies inside the domain, then
$\lvert D^\alpha u(x)\rvert \le N R^{-\lvert\alpha\rvert} \sup_{B_R(x)}\lvert u\rvert$. The constant
$N$ is allowed to depend on the dimension and on the multi-index $\alpha$, but on nothing else — not
on $u$, not on the domain, not on $x$ and not on $R$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The constant is chosen before the domain, the function, the point and the radius, and may depend only on $d$ and $\alpha$. | ✅ `∀ α, ∃ C : ℝ, 0 ≤ C ∧ ∀ (Ω) (u), … → ∀ x ∈ Ω, ∀ R, …`; the dimension `d` is a parameter of the theorem, $\alpha$ is quantified just outside `∃ C`, and everything else comes after it. |
| 2 | The constant is nonnegative. | ✅ `0 ≤ C`. |
| 3 | $\Omega$ is a domain: nonempty, connected and open. | ✅ `IsOpen Ω → IsConnected Ω → Ω.Nonempty →`. |
| 4 | "Harmonic" carries a smoothness assumption as well as $\Delta u = 0$. | ✅ `HarmonicIn Ω u` unfolds to `ContDiffOn ℝ 2 u Ω ∧ ∀ x ∈ Ω, laplacian u x = 0`. |
| 5 | First conclusion: $u$ is infinitely differentiable on $\Omega$. | ✅ `ContDiffOn ℝ ∞ u Ω`, with `∞` (which in current mathlib means $C^\infty$) rather than `⊤`. |
| 6 | Second conclusion: the derivative bound, asserted for every multi-index, every interior point and every admissible radius. | ✅ The conjunct after `∧`, quantified `∀ x ∈ Ω, ∀ R : ℝ, 0 < R → …`, with `α` fixed at the outermost level. |
| 7 | The bound applies only when the ball around $x$ of radius $R$ sits inside $\Omega$. | ✅ `Metric.closedBall x R ⊆ Ω`. |
| 8 | The power of $R$ is $-\lvert\alpha\rvert$, where $\lvert\alpha\rvert$ is the sum of the entries of $\alpha$. | ✅ `R ^ (-(∑ i, α i : ℤ))`, an integer power, well behaved because `0 < R`. |
| 9 | The right-hand supremum is of $\lvert u\rvert$ over that ball. | ✅ `sSup {\|u y\| \| y ∈ Metric.closedBall x R}`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Putting `∃ C` inside `∀ x`, inside `∀ R`, or after $u$ and $\Omega$ have been fixed as implicit variables of the theorem. | The estimate then says nothing: for one fixed instance a large enough constant always exists. Krylov's $N$ is uniform over all of these, and this is the single most damaging error class in this book. |
| 2 | Assuming only $\Delta u = 0$ pointwise, with $u$ merely continuous or with no regularity at all. | `laplacian` is built from `fderiv`, which returns $0$ wherever the function is not differentiable. Every nowhere-differentiable function would then count as harmonic, and the conclusion "$u$ is $C^\infty$" would be plainly false. |
| 3 | Writing `ContDiffOn ℝ ⊤ u Ω` for "infinitely differentiable". | In current mathlib the smoothness exponent lives in `WithTop ℕ∞`, where `∞` is $C^\infty$ and `⊤` is `ω`, i.e. real-analytic. That is strictly more than the text claims (true for harmonic functions, but not what is stated). |
| 4 | Taking the supremum over $\Omega$, or dropping the hypothesis that the ball lies inside $\Omega$. | A real `sSup` returns $0$ on a set that is unbounded above, so the estimate would degenerate into the false claim $\lvert D^\alpha u(x)\rvert \le 0$. The ball hypothesis is what makes the set compact and the supremum genuine. |
| 5 | Dropping the smoothness conclusion and keeping only the estimate, or vice versa. | The theorem asserts both. |
| 6 | Restricting the estimate to first derivatives, or to $\lvert\alpha\rvert \le$ some bound. | The estimate is claimed for every multi-index. |
| 7 | Using the positive power $R^{\lvert\alpha\rvert}$, or a natural-number subtraction for the exponent. | The scaling is $R^{-\lvert\alpha\rvert}$: shrinking the ball must make the bound worse, not better. |
| 8 | Working in `Fin d → ℝ` rather than `EuclideanSpace ℝ (Fin d)`. | `Fin d → ℝ` carries the sup norm, so `Metric.closedBall x R` becomes the cube $\{y : \max_i \lvert y_i - x_i\rvert \le R\}$ rather than a Euclidean ball. |

## Notes on the ground truth

- The text uses the open ball $B_R(x)$; the ground truth uses `Metric.closedBall x R` in both places. The hypothesis is then slightly stronger and the supremum is over a slightly larger set, so the statement is a little weaker than the printed one and remains true.
- Connectedness of $\Omega$ is assumed to match the word "domain", but neither conclusion uses it. Assuming it only restricts the theorem; `IsOpen Ω` alone would be a stronger and equally faithful result.
- `Ω.Nonempty` is redundant next to `IsConnected Ω`, since mathlib's `IsConnected` already includes nonemptiness. Harmless duplication.
- The `sSup` is real-valued rather than `ℝ≥0∞`-valued. It is safe here only because `HarmonicIn` gives continuity on the compact ball, so the set is nonempty and bounded. A `⨆ y : Metric.closedBall x R, ENNReal.ofReal \|u y\|` (the `functionSupNorm` style used elsewhere in this book) would be safe by construction.
- The text's extra "$\cap\, C(\Omega)$" is already implied by `ContDiffOn ℝ 2`.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[krylov_2_5_2_harmonic_smooth_interior_estimates.md](krylov_2_5_2_harmonic_smooth_interior_estimates.md) and the background in [krylov_2_5_2_harmonic_smooth_interior_estimates.context.md](krylov_2_5_2_harmonic_smooth_interior_estimates.context.md),
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

- Requirement 1 with the constant quantified after $u$, $x$ or $R$: the estimate is then vacuous.
- Requirement 7 with the containment $B_R(x)\subseteq\Omega$ dropped.
- Requirement 8 with a power of $R$ other than $-|\alpha|$.

### Domain-specific pitfalls for this problem

- The constant depends only on the dimension and the multi-index; its position in the quantifier prefix is the whole content.
- Junk value — supremum: $\sup_{B_R(x)}|u|$ over a set that is unbounded above would be `0` in `ℝ`; here it is finite because $u$ is continuous on a bounded ball, but the statement should not rely on the default.
- "Domain" carries connectedness as well as openness and non-emptiness.
- Smoothness of $u$ is a conclusion, not a hypothesis; the hypothesis is $C^2$ plus harmonicity.
