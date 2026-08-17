# Criteria: krylov_7_1_2_interior_holder_regularization

**Statement:** [krylov_7_1_2_interior_holder_regularization.md](krylov_7_1_2_interior_holder_regularization.md) · **Lean:** [krylov_7_1_2_interior_holder_regularization.lean](krylov_7_1_2_interior_holder_regularization.lean) · **Context:** [krylov_7_1_2_interior_holder_regularization.context.md](krylov_7_1_2_interior_holder_regularization.context.md)

## What the theorem says

Section 7.1 fixes an $m$th-order ($m \ge 2$) operator $L = \sum_{|\alpha| \le m} a^\alpha(x) D^\alpha$
with *complex* coefficients satisfying $|a^\alpha|_{k+\delta} \le K$, uniformly elliptic with
constant $\kappa$ in the Chapter-4 sense, and attaches to it the family
$L_\lambda = \sum_{|\alpha| \le m} a^\alpha(x)\, \lambda^{m-|\alpha|} D^\alpha$. Theorem 7.1.2: if
$u \in C^{m+\delta}(\Omega)$ — the class with finite norm over all of $\Omega$ — and
$L_\lambda u \in C^{k+\delta}(\Omega)$ for some real $\lambda$, then $u$ gains $k$ derivatives
*locally*: $u \in C^{k+m+\delta}_{\mathrm{loc}}(\Omega)$, i.e. $u \in C^{k+m+\delta}(\Omega')$ for
every bounded open $\Omega'$ with $\overline{\Omega'} \subset \Omega$. The asymmetry is the
content: global-norm classes in, the local class out — the gained derivatives may blow up at
$\partial\Omega$. No constants appear in the conclusion and no restriction is placed on $\lambda$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $0 < \delta < 1$, $k \ge 0$ an integer, and the order obeys the standing assumption $m \ge 2$. | ✅ `hδ : 0 < δ ∧ δ < 1`, `k m : ℕ`, `hm : 2 ≤ m`. |
| 2 | $\Omega$ is open. | ✅ `hΩ : IsOpen Ω`, which is what makes the `fderiv`-built derivatives inside the norms the genuine classical ones at every point of $\Omega$. |
| 3 | The operator family is Krylov's $L_\lambda = \sum_{\lvert\alpha\rvert \le m} a^\alpha(x)\,\lambda^{m-\lvert\alpha\rvert} D^\alpha$, with complex-valued coefficients and a complex-valued $u$ — not the shift $Lu - \lambda u$. | ✅ `lambdaScaledOperator m a lam u`, which is `∑ α ∈ multiIndicesLE d m, a α x * (lam : ℂ) ^ (m - ∑ i, α i) * multiDerivative α u x`, with `a : (Fin d → ℕ) → EuclideanSpace ℝ (Fin d) → ℂ` and `u : EuclideanSpace ℝ (Fin d) → ℂ`. |
| 4 | Uniform ellipticity in the Chapter-4 sense with a single constant $\kappa > 0$: $\bigl\lvert\sum_{\lvert\alpha\rvert \le m} a^\alpha(x)\, i^{\lvert\alpha\rvert} \xi^\alpha\bigr\rvert \ge \kappa(1 + \lvert\xi\rvert^m)$ for all $x, \xi \in \mathbb{R}^d$. | ✅ `ha : UniformlyElliptic m κ a`, i.e. `0 < κ ∧ ∀ x ξ, κ * (1 + ‖ξ‖ ^ m) ≤ ‖characteristicPolynomial m a x ξ‖`, with `characteristicPolynomial` the full polynomial $\sum_{\lvert\alpha\rvert \le m} a^\alpha(x)\, i^{\lvert\alpha\rvert} \xi^\alpha$. |
| 5 | The coefficient bound $\lvert a^\alpha\rvert_{k+\delta} \le K$ — the same $k+\delta$ as the datum, one constant $K$, on all of $\mathbb{R}^d$. | ✅ `haK : ∀ α, krylovHolderNorm k δ Set.univ (a α) ≤ ENNReal.ofReal K`. |
| 6 | $u \in C^{m+\delta}(\Omega)$ as the global-norm class on $\Omega$: continuous derivatives through order $m$ together with a finite norm $\lvert u\rvert_{m+\delta,\Omega}$ — genuine membership, not a finite gauge alone and not a merely local condition. | ✅ `hu : MemHolderSpace m δ Ω u`, which unfolds to `ContDiffOn ℝ m u Ω ∧ krylovHolderNorm m δ Ω u < ⊤`. |
| 7 | $L_\lambda u \in C^{k+\delta}(\Omega)$, again the global-norm class on $\Omega$. | ✅ `hLu : MemHolderSpace k δ Ω (lambdaScaledOperator m a lam u)`. |
| 8 | $\lambda$ is an arbitrary real: "for some $\lambda$" carries no threshold and no sign condition. | ✅ `{lam : ℝ}` is an unconstrained implicit variable. Regularity does not depend on invertibility of $L_\lambda$. |
| 9 | The conclusion is the *local* class $u \in C^{k+m+\delta}_{\mathrm{loc}}(\Omega)$: membership in $C^{k+m+\delta}(\Omega')$ for every bounded open $\Omega'$ with $\overline{\Omega'} \subset \Omega$ — not a single finite norm over $\Omega$. | ✅ `MemHolderSpaceLoc (k + m) δ Ω u`, which unfolds to `∀ Ω', IsOpen Ω' → Bornology.IsBounded Ω' → closure Ω' ⊆ Ω → MemHolderSpace (k + m) δ Ω' u`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Concluding the global class $C^{k+m+\delta}(\Omega)$ — a single finite Hölder norm over all of $\Omega$. | That is false. Take $d = 2$, $m = 2$, $k = 1$, $\delta = 1/2$, $\Omega$ the unit disc, $L = \Delta - 1$ (constant coefficients, so $K = 1$; its characteristic polynomial is $-(1+\lvert\xi\rvert^2)$, so $\kappa = 1$), $\lambda = 0$ (so $L_0 = \Delta$), and $u = \operatorname{Re}\bigl((1-z)^{5/2}\bigr)$ with $z = x_1 + ix_2$ (principal branch). Then $u$ is harmonic, so $L_0 u = 0 \in C^{1+\delta}(\Omega)$; the derivatives of $u$ through order $2$ are bounded on $\Omega$ and $D^2u \sim c(1-z)^{1/2}$ is $\tfrac12$-Hölder there, so $u \in C^{2+\delta}(\Omega)$; but $D^3u \sim c(1-z)^{-1/2}$ is unbounded on $\Omega$, so $\lvert u\rvert_{3+\delta,\Omega} = \infty$: $u$ lies in the local class only. |
| 2 | Weakening the hypotheses to the local classes $u \in C^{m+\delta}_{\mathrm{loc}}(\Omega)$, $L_\lambda u \in C^{k+\delta}_{\mathrm{loc}}(\Omega)$. | The book assumes the global-norm classes on $\Omega$. With local hypotheses the statement is a formally different theorem — the same conclusion from weaker hypotheses, whose reduction to the text's version is itself an argument — and equivalent-but-different hypotheses are charged even when the resulting statement is true: state the condition the text states. |
| 3 | Reading $L_\lambda$ as the shift $Lu - \lambda u$. | Wrong family. Sec. 7.1 defines $L_\lambda = \sum_{\lvert\alpha\rvert \le m} a^\alpha \lambda^{m-\lvert\alpha\rvert} D^\alpha$: every coefficient of order $\lvert\alpha\rvert < m$ is weighted by $\lambda^{m-\lvert\alpha\rvert}$, so the zeroth-order term becomes $a^0 \lambda^m u$, not $a^0 u - \lambda u$. The hypothesis $L_\lambda u \in C^{k+\delta}(\Omega)$ then constrains a different function, and the statement is not the book's. |
| 4 | Imposing a threshold ($\lambda \ge \lambda_0$) or a sign condition on $\lambda$, imported from the solvability theorems. | The text says "for some $\lambda$", meaning an arbitrary real $\lambda$. Regularity does not depend on invertibility of $L_\lambda$, and adding a restriction narrows the theorem for no reason. |
| 5 | Real-valued coefficients or a real-valued $u$. | Sec. 7.1's setting is complex: the $a^\alpha$, $u$ and $L_\lambda u$ are complex-valued, and the ellipticity condition is a lower bound on the modulus of a complex characteristic polynomial. A real-only statement is a strictly narrower theorem than the text's. |
| 6 | A different ellipticity notion: mere nonvanishing of the symbol (Definition 1.1.1), a bound on the principal part alone, a missing $\kappa > 0$, or a $\kappa$ depending on $x$. | The text's condition is the uniform Chapter-4 bound $\kappa(1+\lvert\xi\rvert^m) \le \bigl\lvert\sum_{\lvert\alpha\rvert \le m} a^\alpha(x)\, i^{\lvert\alpha\rvert} \xi^\alpha\bigr\rvert$ for all $x$ and $\xi$ with one $\kappa > 0$. It involves the full polynomial — at $\xi = 0$ it already forces $\lvert a^0(x)\rvert \ge \kappa$, which no principal-part condition gives — and it is uniform in $x$. |
| 7 | Dropping the coefficient bound $\lvert a^\alpha\rvert_{k+\delta} \le K$, or taking it with an exponent other than $k+\delta$. | The theorem trades $C^{k+\delta}$ regularity of $L_\lambda u$ against $C^{k+\delta}$ coefficients: with coefficients rougher than $k+\delta$ the gain of $k$ derivatives fails (multiplication by $a^\alpha$ does not preserve $C^{k+\delta}$), and demanding smoother coefficients is a narrower hypothesis than the text's. |
| 8 | Concluding $C^{k+\delta}$ or $C^{m+\delta}$. | Those are the hypotheses. The point of the theorem is the gain to $k+m+\delta$. |
| 9 | Using a second Hölder exponent somewhere instead of the same $\delta$ throughout. | The bookkeeping is exact: $m+\delta$ in, $k+\delta$ for $L_\lambda u$ and for the coefficients, $k+m+\delta$ out, all with one $\delta$. |
| 10 | Encoding the memberships of $u$ or $L_\lambda u$ as norm-finiteness alone, without the existence of the derivatives. | In Lean the classical derivative is a total function that is $0$ off the differentiability locus, so a bounded nowhere-differentiable $u$ satisfies every finiteness-only hypothesis while the conclusion fails. Membership must pair the finite norm with genuine differentiability, as Krylov's Definition 3.1.1 does. |
| 11 | Taking the classes of $u$ or of $L_\lambda u$ over $\mathbb{R}^d$ (or over $\overline{\Omega}$) instead of over $\Omega$. | Nothing is known about $u$ off $\Omega$ — in Lean $u$ is a total function whose values outside $\Omega$ are arbitrary. Requiring finite norms over $\mathbb{R}^d$, or over $\overline{\Omega}$ where the boundary derivatives are a different object, is a stronger hypothesis and hence a strictly weaker theorem than the text's. |
| 12 | Bolting a quantitative Schauder estimate with a constant onto the conclusion. | The text asserts membership only. Taken over $\Omega$ the estimate is false for the same reason as mistake 1; taken over each $\Omega'$ it would need a constant quantified before $u$ and depending on $\Omega'$, none of which the text provides. |

## Notes on the ground truth

- `haK` takes the coefficient norms over `Set.univ`: Sec. 7.1's operator lives on all of
  $\mathbb{R}^d$ (the ellipticity display quantifies over $x, \xi \in \mathbb{R}^d$), so the global
  norm is the faithful reading; only the classes of $u$ and $L_\lambda u$ are relative to $\Omega$.
  The bound `≤ ENNReal.ofReal K` leaves `K : ℝ` unconstrained, matching the book's "for a constant
  $K$"; a non-positive $K$ would force the coefficients to vanish and contradict ellipticity.
- `haK` is a norm bound alone: its seminorms read the total-`fderiv` derivatives of the
  coefficients, which are the classical ones wherever the $a^\alpha$ are genuinely differentiable.
  A candidate that renders the book's $C^{k+\delta}$ reading more literally by pairing the bound
  with explicit smoothness of the coefficients scores at least as high, per GRADING.md.
- `MemHolderSpace` pairs `ContDiffOn ℝ k u Ω` with finiteness of `krylovHolderNorm k δ Ω u` —
  Definition 3.1.1 verbatim: continuous derivatives through order $k$ *and* a finite norm. The
  norm's `multiDerivative` (repeated `fderiv` along the coordinate list `multiIndexDirections α`)
  is the classical $D^\alpha$ at every point of the open $\Omega$; mixed partials of $C^k$
  functions commute, so the fixed coordinate order is harmless.
- All suprema and Hölder quotients live in `ℝ≥0∞` via `⨆` and `ENNReal.ofReal`, so an empty or
  unbounded family cannot produce a junk-zero supremum, and `< ⊤` is honest finiteness.
  `krylovHolderNorm` sums the `supSeminorm`s through order $k$ and adds the top-order
  `holderSeminorm`, exactly Krylov's $|u|_{k+\delta,\Omega}$.
- `MemHolderSpaceLoc (k + m) δ Ω u` quantifies over bounded open `Ω'` with `closure Ω' ⊆ Ω`, which
  is Krylov's definition of $C^{k+m+\delta}_{\mathrm{loc}}(\Omega)$. A candidate quantifying
  instead over compact $K \subseteq \Omega$ states an equivalent local class (each such $\Omega'$
  has compact closure inside $\Omega$, and each compact set sits inside such an $\Omega'$) and
  loses nothing.
- In `lambdaScaledOperator`, the exponent `m - ∑ i, α i` is natural subtraction; it never
  truncates, because `multiIndicesLE d m` restricts to $|\alpha| \le m$. At `lam = 1` the family
  collapses to $L$ itself, as in the text.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[krylov_7_1_2_interior_holder_regularization.md](krylov_7_1_2_interior_holder_regularization.md) and the background in [krylov_7_1_2_interior_holder_regularization.context.md](krylov_7_1_2_interior_holder_regularization.context.md),
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

- Requirement 9 with the conclusion stated as the global class $C^{k+m+\delta}(\Omega)$ — a finite Hölder norm up to $\partial\Omega$.
- Requirement 8 with a threshold or sign condition imposed on $\lambda$.
- Requirement 3 with $L_\lambda$ encoded as the shift $Lu - \lambda u$ instead of the $\lambda$-weighted family $\sum_{|\alpha| \le m} a^\alpha \lambda^{m-|\alpha|} D^\alpha$.

### Domain-specific pitfalls for this problem

- The "loc" sits on the conclusion only: global-norm classes in, local class out. Moving it in either direction changes the theorem.
- $L_\lambda$ weights each coefficient by $\lambda^{m-|\alpha|}$; it is not the shift $L - \lambda$.
- No condition on $\lambda$ is needed or assumed here.
- The setting is complex-valued, the ellipticity bound is the Chapter-4 one on the *full* characteristic polynomial, and the coefficients' regularity is the same $k+\delta$ as the datum's.
