# Criteria: krylov_4_2_1_better_regular_data_better_regular_solution

**Statement:** [krylov_4_2_1_better_regular_data_better_regular_solution.md](krylov_4_2_1_better_regular_data_better_regular_solution.md) · **Lean:** [krylov_4_2_1_better_regular_data_better_regular_solution.lean](krylov_4_2_1_better_regular_data_better_regular_solution.lean) · **Context:** [krylov_4_2_1_better_regular_data_better_regular_solution.context.md](krylov_4_2_1_better_regular_data_better_regular_solution.context.md)

## What the theorem says

Krylov's Chapter-4 operator $L = \sum_{\lvert\alpha\rvert\le m} a^\alpha(x) D^\alpha$ has *complex*
coefficients and is uniformly elliptic in the full-symbol sense
$\bigl|\sum_{\lvert\alpha\rvert\le m} a^\alpha(x)\,i^{\lvert\alpha\rvert}\xi^\alpha\bigr| \ge \kappa(1+\lvert\xi\rvert^m)$;
the attached family is $L_\lambda = \sum_{\lvert\alpha\rvert\le m} a^\alpha(x)\,\lambda^{m-\lvert\alpha\rvert} D^\alpha$,
so $L_1 = L$. Under the coefficient bounds $\lvert a^\alpha\rvert_\delta \le K$ (the assumptions of
Theorem 4.1.2) and $\lvert a^\alpha\rvert_{k+\delta} \le K_1$, the theorem makes two claims. First, a
regularity gain valid for *every* $\lambda$: if $u \in C^{m+\delta}$ and $L_\lambda u$ happens to lie
in $C^{k+\delta}$, then $u \in C^{k+m+\delta}$. Second, with $\lambda_0$ the threshold furnished by
Theorem 4.1.2's a priori estimate, for every real $\lambda$ with $\lvert\lambda\rvert \ge \lambda_0$
and every $u \in C^{k+m+\delta}$,

$$[u]_{k+m+\delta} + \lvert\lambda\rvert^{k+m+\delta}\lvert u\rvert_0 \ \le\ N\bigl([L_\lambda u]_{k+\delta} + \lvert\lambda\rvert^{k+\delta}\lvert L_\lambda u\rvert_0\bigr),$$

where $N$ is one constant serving every $\lambda$ and every $u$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The order obeys the book's standing assumption $m \ge 2$; $k \ge 0$ is an integer; $0 < \delta < 1$; $K_1 \ge 1$. | ✅ `hm : 2 ≤ m`, `k : ℕ` unconstrained, `hδ : 0 < δ ∧ δ < 1`, `hK₁ : 1 ≤ K₁`. |
| 2 | The coefficients are complex-valued functions $a^\alpha(x)$ indexed by the multi-indices of order at most $m$, and the family is $L_\lambda = \sum_{\lvert\alpha\rvert\le m} a^\alpha(x)\lambda^{m-\lvert\alpha\rvert}D^\alpha$ acting pointwise, so that $L_1 = L$. | ✅ `a : (Fin d → ℕ) → EuclideanSpace ℝ (Fin d) → ℂ`, and `lambdaScaledOperator m a lam u x = ∑ α ∈ multiIndicesLE d m, a α x * (lam : ℂ) ^ (m - ∑ i, α i) * multiDerivative α u x`. |
| 3 | Uniform ellipticity is the full-symbol lower bound $\bigl\lvert\sum_{\lvert\alpha\rvert\le m} a^\alpha(x)\,i^{\lvert\alpha\rvert}\xi^\alpha\bigr\rvert \ge \kappa(1+\lvert\xi\rvert^m)$ for all $x, \xi$, with a single $\kappa > 0$. | ✅ `ha : UniformlyElliptic m κ a`, i.e. `0 < κ ∧ ∀ x ξ, κ * (1 + ‖ξ‖ ^ m) ≤ ‖characteristicPolynomial m a x ξ‖`, where `characteristicPolynomial m a x ξ = ∑ α ∈ multiIndicesLE d m, a α x * Complex.I ^ (∑ i, α i) * ∏ i, (ξ i : ℂ) ^ α i`. |
| 4 | The assumptions of Theorem 4.1.2 are in force: $\lvert a^\alpha\rvert_\delta \le K$ for every $\alpha$, with one constant $K$. | ✅ `haK : ∀ α, krylovHolderNorm 0 δ univ (a α) ≤ ENNReal.ofReal K`. |
| 5 | The data hypothesis of 4.2.1: $\lvert a^\alpha\rvert_{k+\delta} \le K_1$ for every $\alpha$, with the single constant $K_1$. | ✅ `haK₁ : ∀ α, krylovHolderNorm k δ univ (a α) ≤ ENNReal.ofReal K₁`. |
| 6 | The regularity gain is asserted for **every** real $\lambda$, outside any threshold: $u \in C^{m+\delta}$ and $L_\lambda u \in C^{k+\delta}$ imply $u \in C^{k+m+\delta}$. | ✅ the first conjunct `∀ (lam : ℝ) (u), MemHolderSpace m δ univ u → MemHolderSpace k δ univ (lambdaScaledOperator m a lam u) → MemHolderSpace (k + m) δ univ u`, stated before the existentials and free of `lam₀`. |
| 7 | "$u \in C^{r}$" is genuine membership: continuous derivatives through $\lfloor r\rfloor$ **and** a finite Krylov norm bundling the lower-order sup norms. | ✅ `MemHolderSpace k δ univ u = ContDiffOn ℝ k u univ ∧ krylovHolderNorm k δ univ u < ⊤`, with `krylovHolderNorm k δ Ω u = ∑ j ∈ Finset.range (k + 1), supSeminorm j Ω u + holderSeminorm k δ Ω u`. |
| 8 | $\lambda_0$ is produced by the theorem and pinned as the threshold of Theorem 4.1.2: it comes with an $N_0 > 0$ making the 4.1.2 estimate $[u]_{m+\delta} + \lvert\lambda\rvert^{m+\delta}\lvert u\rvert_0 \le N_0([L_\lambda u]_\delta + \lvert\lambda\rvert^\delta\lvert L_\lambda u\rvert_0)$ hold for all real $\lvert\lambda\rvert \ge \lambda_0$ and all $u \in C^{m+\delta}$. | ✅ `∃ lam₀ N₀ : ℝ, 0 ≤ lam₀ ∧ 0 < N₀ ∧ (∀ lam : ℝ, lam₀ ≤ \|lam\| → ∀ u, MemHolderSpace m δ univ u → holderSeminorm m δ univ u + ENNReal.ofReal \|lam\| ^ ((m : ℝ) + δ) * supSeminorm 0 univ u ≤ ENNReal.ofReal N₀ * (holderSeminorm 0 δ univ (lambdaScaledOperator m a lam u) + ENNReal.ofReal \|lam\| ^ δ * supSeminorm 0 univ (lambdaScaledOperator m a lam u))) ∧ …`. |
| 9 | The constant $N$ of (4.2.1) is strictly positive and is fixed after $\lambda_0$ but before $\lambda$ and $u$. | ✅ `∃ N : ℝ, 0 < N ∧ ∀ lam : ℝ, lam₀ ≤ \|lam\| → ∀ u, …` inside the `lam₀` existential. |
| 10 | The estimate is guarded two-sidedly: real $\lambda$ with $\lvert\lambda\rvert \ge \lambda_0$, both half-lines included. | ✅ `lam : ℝ` with `lam₀ ≤ \|lam\|`, in the 4.1.2 conjunct and in the 4.2.1 conjunct alike. |
| 11 | The estimate applies to every $u \in C^{k+m+\delta}$, hypothesized as membership. | ✅ `∀ u, MemHolderSpace (k + m) δ univ u → …`. |
| 12 | The inequality is the two-seminorm form with the undivided weights on the sup norms: $[u]_{k+m+\delta} + \lvert\lambda\rvert^{k+m+\delta}\lvert u\rvert_0 \le N([L_\lambda u]_{k+\delta} + \lvert\lambda\rvert^{k+\delta}\lvert L_\lambda u\rvert_0)$. | ✅ `holderSeminorm (k + m) δ univ u + ENNReal.ofReal \|lam\| ^ (((k + m : ℕ) : ℝ) + δ) * supSeminorm 0 univ u ≤ ENNReal.ofReal N * (holderSeminorm k δ univ (lambdaScaledOperator m a lam u) + ENNReal.ofReal \|lam\| ^ ((k : ℝ) + δ) * supSeminorm 0 univ (lambdaScaledOperator m a lam u))`, all in `ℝ≥0∞`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Modelling the family as $L_\lambda u = Lu - \lambda u$, the shift of the second-order chapters, instead of $L_\lambda = \sum_{\lvert\alpha\rvert\le m} a^\alpha\lambda^{m-\lvert\alpha\rvert}D^\alpha$. | It is a different family, and the two-sided estimate is false for it. Take $d = 1$, $m = 2$, $Lu = -u'' + u$ (uniformly elliptic: the symbol is $\xi^2 + 1$), $u = \sin(nx)$ and $\lambda = n^2 + 1$. Then $Lu - \lambda u = 0$, so the right side vanishes, while $[u]_{k+2+\delta} = n^{k+2+\delta} > 0$ — and $\lvert\lambda\rvert \ge \lambda_0$ once $n$ is large. |
| 2 | Real coefficients with principal-symbol positivity $\sum_{\lvert\alpha\rvert=m}a^\alpha\xi^\alpha \ge \kappa\lVert\xi\rVert^m$ in place of the full-symbol modulus bound. | Chapter 4's ellipticity bounds the whole symbol: at $\xi = 0$ it forces $\lvert a^0(x)\rvert \ge \kappa$. Principal positivity admits $L = D^2$ on $\mathbb{R}$, for which $L_\lambda = D^2$ carries no $\lambda$ at all; $u \equiv 1$ then gives $L_\lambda u = 0$, so the right side of (4.2.1) is $0$ while the left side is $\lvert\lambda\rvert^{k+2+\delta} > 0$. The complex-modulus bound is not a stylistic choice — it is what makes part 2 true. Restricting the coefficients or the functions to real values is likewise a strictly narrower theorem than the book's. |
| 3 | Dividing the $\lambda$-exponents by $m$: weights $\lvert\lambda\rvert^{(k+m+\delta)/m}$ and $\lvert\lambda\rvert^{(k+\delta)/m}$. | The wrong scaling for this family. The two weights must differ by the $\lambda$-homogeneity of the operator, which is $\lambda^m$ for $L_\lambda$: testing $u \equiv 1$ gives $L_\lambda u = a^0\lambda^m u$, so $\lvert\lambda\rvert^{k+m+\delta}\lvert u\rvert_0$ and $\lvert\lambda\rvert^{k+\delta}\lvert L_\lambda u\rvert_0$ match exactly. The divided weights differ by $\lvert\lambda\rvert^1$ — the gap that belongs to the $L - \lambda$ family — so the sup-norm content of the claim is off from the sharp one by the factor $\lvert\lambda\rvert^{m-1}$: a strictly weaker statement, not the printed theorem. |
| 4 | Interchanging the two exponents, or attaching the $\lambda$-weights to the Hölder seminorms rather than to the sup norms. | The weight-on-seminorm version is false: for $d = 1$, $m = 2$, $k = 0$, $Lu = -u'' + u$ and $u = \sin(\lambda x)$, the left side is at least $\lvert\lambda\rvert^{2+\delta}[u]_{2+\delta} \sim \lvert\lambda\rvert^{4+2\delta}$ while the right side is $\approx N\lvert\lambda\rvert^{2+2\delta}$. Interchanging the exponents turns the sharp weight gap $\lvert\lambda\rvert^{m}$ into $\lvert\lambda\rvert^{-m}$ and the claim into a strictly weaker one. |
| 5 | Dropping either weighted sup-norm term. | Dropping $\lvert\lambda\rvert^{k+\delta}\lvert L_\lambda u\rvert_0$ makes the claim false: $u \equiv 1$ with $Lu = -u'' + u$ gives $L_\lambda u \equiv \lambda^2$, whose seminorm $[L_\lambda u]_{k+\delta}$ is $0$, while the left side keeps $\lvert\lambda\rvert^{k+2+\delta} > 0$. Dropping $\lvert\lambda\rvert^{k+m+\delta}\lvert u\rvert_0$ discards the resolvent-decay half of the estimate — the part that makes it a high-parameter theorem. |
| 6 | Guarding part 2 one-sidedly by $\lambda_0 \le \lambda$. | The book asserts the estimate for real $\lambda$ of **either sign** with $\lvert\lambda\rvert \ge \lambda_0$, and under the full-symbol ellipticity the negative half-line carries the same content (for $Lu = -u'' + u$, $L_{-\lambda} = L_\lambda$). Keeping only $\lambda \ge \lambda_0$ silently halves the theorem. |
| 7 | Putting the part-1 regularity gain under the threshold guard, or restricting its $\lambda$. | The text asserts the gain "for any $\lambda$" — including $\lambda = 0$ and small $\lambda$; guarding it loses the part of the theorem that has no constants in it. |
| 8 | Taking $\lambda_0$ as an input of the theorem, producing it with no defining property, or pinning it by solvability of $L_\lambda$. | The text says "take $\lambda_0$ from Theorem 4.1.2", and Theorem 4.1.2 is an **a priori estimate**, not a solvability theorem. As an input, the statement would assert (4.2.1) for arbitrary thresholds — in particular $\lambda_0 = 0$, where the claim extends to all small $\lvert\lambda\rvert$, a uniformity the book neither states nor proves and exactly what the threshold exists to avoid. Pinned by solvability, $\lambda_0$ names a Chapter-4.5 fact that 4.2.1 does not contain. |
| 9 | Writing `∀ u, ∃ N, …`, or choosing `N₀`, `N` or `lam₀` after `lam`. | A constant chosen after $u$ (or after $\lambda$) always exists, so the estimate becomes empty. One $N$ for every $\lambda$ and every $u$ — and one $\lambda_0$ fixed before both — is the whole content of part 2. |
| 10 | Encoding the Hölder memberships as finiteness of a norm only, without the differentiability clause. | The seminorms are built from derivative operators that return $0$ off the differentiability locus, so a bounded nowhere-differentiable function has a finite "norm" and would slip through every membership hypothesis. Membership must couple continuous derivatives with the finite norm, as `MemHolderSpace` does. |
| 11 | Asserting the part-2 estimate for arbitrary $u$ rather than $u \in C^{k+m+\delta}$. | The text quantifies over $u \in C^{k+m+\delta}$. Without the membership, the inequality ranges over functions whose derivative seminorms are junk zeros; whatever truth value it then has, it is a different claim from the printed one. |
| 12 | Building the seminorms as real-valued suprema. | A real `sSup` over an unbounded (or empty) family returns $0$, so a genuinely infinite $[L_\lambda u]_{k+\delta}$ would evaluate to $0$ and the inequality would assert falsehoods — or memberships defined through real gauges would hold for free. The quantities must live in a type with $\infty$, or carry explicit boundedness hypotheses. |

## Notes on the ground truth

- Krylov's $N$ depends only on $\kappa, k, m, \delta, K_1, d$, and his $\lambda_0, N_0$ only on
  $\kappa, m, \delta, K, d$ — not on the individual operator. In the Lean statement `a`, `κ`, `K`
  and `K₁` are implicit variables fixed before the existentials, so `lam₀`, `N₀` and `N` may depend
  on all of them, including `a` itself. That is strictly weaker than the printed dependence, though
  still non-trivial; the quantifier position relative to `lam` and `u` is faithful. A fully faithful
  version would read `∃ lam₀ N₀ N, ∀ a, …`.
- "Take $\lambda_0$ from Theorem 4.1.2" cannot reference another theorem's constant inside a single
  Lean statement, so the ground truth bundles the 4.1.2 estimate (with its own `N₀`) as the defining
  property of `lam₀`, then asserts the 4.2.1 estimate with its own `N` for the same threshold. A
  candidate that pins $\lambda_0$ in any equivalent way loses nothing; one that produces a bare
  threshold for (4.2.1) alone asserts less — the tie to 4.1.2 is what the text's "$\lambda_0$"
  means.
- Everything lands in `ℝ≥0∞`: the seminorms are `⨆` into `ℝ≥0∞`, so no real-`sSup` junk fires; the
  weights are `rpow`s of `ENNReal.ofReal \|lam\|`; `ENNReal.ofReal` on `N`, `N₀`, `K₁` is safe under
  the positivity conjuncts.
- The book's $[u]_{k+\delta}$ is a *max* over $\lvert\alpha\rvert = k$ and $\lvert u\rvert_{k+\delta}$
  a sum over the orders $j \le k$; `holderSeminorm`, `supSeminorm` and `krylovHolderNorm` reproduce
  exactly that. `multiDerivative` differentiates along a fixed coordinate list; mixed partials of
  $C^k$ functions commute, so the fixed order is harmless.
- At $\lambda = 0$, allowed in part 1, `lambdaScaledOperator` reads `(0 : ℂ) ^ (m - ∑ i, α i)` with
  `0 ^ 0 = 1`, so $L_0$ is the principal part $\sum_{\lvert\alpha\rvert=m}a^\alpha D^\alpha$, as in
  the book; the `ℕ`-subtraction never truncates because `multiIndicesLE d m` only contains
  $\lvert\alpha\rvert \le m$.
- `0 ≤ lam₀`, not `0 < lam₀`: Theorem 4.1.2 furnishes a nonnegative threshold, and nothing in the
  statement needs it positive. Demanding strict positivity would be a harmless variant.
- `haK` is nearly redundant for $k \ge 1$ (a $\lvert a^\alpha\rvert_{k+\delta}$ bound interpolates to
  a $\delta$-bound), but $K$ is the constant that 4.1.2's $\lambda_0, N_0$ are supposed to depend
  on, so it is kept as the book states it; for $k = 0$ the two hypotheses coincide up to the two
  constants.
- There is no sign hypothesis on `K`: for $K \le 0$, `ENNReal.ofReal K = 0` would force `a ≡ 0`,
  which contradicts ellipticity at $\xi = 0$ (the symbol bound gives $\lvert a^0(x)\rvert \ge \kappa$),
  so no false instance arises.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[krylov_4_2_1_better_regular_data_better_regular_solution.md](krylov_4_2_1_better_regular_data_better_regular_solution.md) and the background in [krylov_4_2_1_better_regular_data_better_regular_solution.context.md](krylov_4_2_1_better_regular_data_better_regular_solution.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 12 rows, so each row is worth 4.2 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 6 with the regularity gain restricted to $\lvert\lambda\rvert \ge \lambda_0$: part 1 holds for every $\lambda$.
- Requirement 9 with $N$ quantified after $\lambda$ or $u$.
- Requirement 12 with either weighted term dropped, the weights divided by $m$, or the two exponents interchanged.

### Domain-specific pitfalls for this problem

- The two parts have different $\lambda$-ranges: part 1 is unconditional, part 2 is two-sided above the threshold.
- (4.2.1) is a *seminorm* inequality: top-order $[\,\cdot\,]$ seminorms plus $\lambda$-weighted sup norms, not full Hölder norms.
- The weights $\lvert\lambda\rvert^{k+m+\delta}$ and $\lvert\lambda\rvert^{k+\delta}$ differ by exactly $\lvert\lambda\rvert^m$, the $\lambda$-homogeneity of $L_\lambda$; dividing them by $m$ or interchanging them breaks that bookkeeping.
- $\lambda_0$ is Theorem 4.1.2's threshold — an a priori estimate, not a solvability statement.
- $\lvert u\rvert_0$ is the plain sup norm, distinct from the full norm $\lvert u\rvert_{k+\delta}$.
- $K_1 \ge 1$ bounds all coefficient norms with a single constant; $K$ is Theorem 4.1.2's separate constant.
- The constant $N$ is chosen before everything it is claimed independent of.
