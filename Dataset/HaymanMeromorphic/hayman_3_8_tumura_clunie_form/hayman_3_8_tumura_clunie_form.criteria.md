# Criteria: hayman_3_8_tumura_clunie_form

**Statement:** [hayman_3_8_tumura_clunie_form.md](hayman_3_8_tumura_clunie_form.md) · **Lean:** [hayman_3_8_tumura_clunie_form.lean](hayman_3_8_tumura_clunie_form.lean) · **Context:** [hayman_3_8_tumura_clunie_form.context.md](hayman_3_8_tumura_clunie_form.context.md)

## What the theorem says

Suppose $f$ is meromorphic in the plane with only finitely many poles, and that both $f$ and one of
its higher derivatives $f^{(l)}$, with $l \ge 2$, have only finitely many zeros. Then $f$ is forced
into a very rigid shape: $f = \dfrac{P_1}{P_2}e^{P_3}$ with $P_1, P_2, P_3$ polynomials. If moreover
$f$ and $f^{(l)}$ have *no* zeros at all, the shape narrows to one of exactly two possibilities,
$f(z) = e^{Az+B}$ or $f(z) = (Az+B)^{-n}$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $f$ is meromorphic on the whole plane. | ✅ `hf : Meromorphic f`. |
| 2 | $f$ has only finitely many poles. | ✅ `hpoles : {z : ℂ | meromorphicOrderAt f z < 0}.Finite`, poles being the points of negative meromorphic order. |
| 3 | $f$ has only finitely many zeros. | ✅ `hzeros : {z : ℂ \| 0 < meromorphicOrderAt f z}.Finite` — zeros are points of positive meromorphic order, the representative-independent reading. |
| 4 | $f^{(l)}$ has only finitely many zeros. | ✅ `hlzeros : {z : ℂ \| 0 < meromorphicOrderAt (iteratedDeriv l f) z}.Finite`. |
| 5 | The order of differentiation satisfies $l \ge 2$. | ✅ `hl : 2 ≤ l`. |
| 6 | First conclusion: $f = P_1 e^{P_3}/P_2$ for three polynomials, with $P_2$ not the zero polynomial. | ✅ `∃ P₁ P₂ P₃ : Polynomial ℂ, P₂ ≠ 0 ∧ ∀ z, P₂.eval z ≠ 0 → f z = P₁.eval z / P₂.eval z * Complex.exp (P₃.eval z)`. |
| 7 | The identity is asserted away from the zeros of $P_2$, since those are where $f$ has its poles. | ✅ The guard `P₂.eval z ≠ 0` on the equation, with `P₂ ≠ 0` ensuring the excluded set is finite. |
| 8 | Second conclusion, under the extra hypothesis that $f$ and $f^{(l)}$ have no zeros at all. | ✅ Second conjunct, guarded by `(∀ z, meromorphicOrderAt f z ≤ 0) ∧ (∀ z, meromorphicOrderAt (iteratedDeriv l f) z ≤ 0)` — zero-freeness as "positive order at no point", which is representative-invariant and remains satisfiable when $f$ has poles. |
| 9 | That second conclusion is a disjunction of exactly the two shapes $e^{Az+B}$ and $(Az+B)^{-n}$. | ✅ `(∃ A B, ∀ z, ContinuousAt f z → f z = Complex.exp (A * z + B)) ∨ ∃ A B n, 1 ≤ n ∧ ∀ z, ContinuousAt f z → A * z + B ≠ 0 → f z = (A * z + B) ^ (-(n : ℤ))`. The `ContinuousAt` guards assert the identities exactly where the representative's value is honest (continuity forces value = punctured limit); off that set the values carry no meaning. |
| 10 | In the second shape the exponent is a *negative* integer power with $n \ge 1$, and the identity holds away from the zero of $Az+B$. | ✅ `(A * z + B) ^ (-(n : ℤ))` with `1 ≤ n` and the guards `ContinuousAt f z → A * z + B ≠ 0 → …`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Keeping only the general form $P_1e^{P_3}/P_2$ and dropping the zero-free refinement. | Half the theorem. The refinement is the sharp conclusion that Tumura–Clunie theory is used for. |
| 2 | Weakening $l \ge 2$ to $l \ge 1$. | Hayman states the theorem for $l \ge 2$; the $l = 1$ case needs a different argument and the printed conclusion is not asserted there. |
| 3 | Writing the exponent in the second shape as a natural number, $(Az+B)^{n}$. | Inverts the meaning. $(Az+B)^{n}$ is a polynomial with a zero, contradicting the zero-free hypothesis; the intended function has a pole, not a zero. |
| 4 | Allowing $n = 0$ in $(Az+B)^{-n}$. | Then $f$ is the constant $1$, which is not one of the two shapes Hayman lists and would make the second branch trivially satisfiable. |
| 5 | Asserting $f z = P_1(z)/P_2(z)\,e^{P_3(z)}$ for *every* $z$ with no guard. | At a pole of $f$ both sides are default values in Lean, so the equation would be asserting something about Lean's division-by-zero convention rather than about $f$. |
| 6 | Omitting `P₂ ≠ 0`. | With $P_2 = 0$ the guard `P₂.eval z ≠ 0` is never true, the equation holds at no point, and the whole first conclusion becomes satisfiable by any $f$ whatsoever. |
| 7 | Dropping the finiteness hypothesis on the zeros of $f^{(l)}$, or on the poles. | Both are essential: without them $f$ can be any meromorphic function and no structure follows. |
| 8 | Stating the extra zero-free hypothesis of the second part as a hypothesis of the whole theorem. | That would lose the general form, which is asserted without it. The zero-free condition guards only the second conclusion. |
| 9 | Writing the zero-free antecedent as emptiness of the literal solution sets, `{z \| f z = 0} = ∅ ∧ {z \| iteratedDeriv l f z = 0} = ∅`. | Unsatisfiable in exactly the case the clause addresses: `iteratedDeriv l f` takes the junk value $0$ at every pole (for $l \ge 1$), so the literal emptiness forces the pole set to be empty and the $(Az+B)^{-n}$ branch is unreachable. An earlier version of the ground truth had exactly this defect; the current one incorporates the repair with the order-based antecedent `∀ z, meromorphicOrderAt … ≤ 0`. |
| 10 | Asserting the refined shapes at *every* $z$ with no continuity guard. | The hypotheses are order-based, so nothing pins the representative's values on discrete sets; an unguarded `∀ z, f z = Complex.exp (A * z + B)` is refuted by re-valuing `f` at one point. Likewise the natural representative of $(Az+B)^{-n}$ carries a junk value at its pole, so the identity must be guarded (here by `ContinuousAt f z` and `A * z + B ≠ 0`). |

## Notes on the ground truth

- The two conclusions are conjoined, with the second one written as an implication whose antecedent
  is the extra zero-free assumption. This keeps both of Hayman's claims in one declaration and
  matches the "If, further, …" of the text.
- The pole set is `{z | meromorphicOrderAt f z < 0}` and the zero sets are
  `{z | 0 < meromorphicOrderAt … z}`. Identifying poles by failure of analyticity would also flag a
  removable singularity at which `f` carries the wrong value; identifying zeros by the literal
  `… z = 0` would count junk values (every pole is a literal zero of `iteratedDeriv l f`) and miss
  genuine zeros hidden by re-valuing the representative. Order-based sets depend only on the
  meromorphic germ.
- The second conjunct's antecedent renders "no zeros" as `∀ z, meromorphicOrderAt … ≤ 0` rather
  than emptiness of a literal solution set, so it stays satisfiable when $f$ has poles — which is
  precisely the case the $(Az+B)^{-n}$ branch exists for.
- Both refined identities are guarded by `ContinuousAt f z`: at continuity points the
  representative's value is the honest value of the meromorphic function, and off them it is
  unconstrained junk that no theorem should legislate. For the honest representative of either
  shape the guard holds everywhere the identity is meaningful.
- The negative power is written with an integer exponent, `(A * z + B) ^ (-(n : ℤ))`, so Lean's
  `zpow` is used; at $Az+B = 0$ that would return $0$, which is why the guard `A * z + B ≠ 0` is
  present.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[hayman_3_8_tumura_clunie_form.md](hayman_3_8_tumura_clunie_form.md) and the background in [hayman_3_8_tumura_clunie_form.context.md](hayman_3_8_tumura_clunie_form.context.md),
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

- Requirement 5 with $l = 1$ admitted.
- Requirement 6 with $P_2$ allowed to be the zero polynomial.
- Requirement 8 with the second conclusion asserted under "finitely many zeros" rather than "no zeros".

### Domain-specific pitfalls for this problem

- Junk value — division: $P_1/P_2$ is Lean's default where $P_2$ vanishes, so the identity must be guarded by $P_2(z) \ne 0$ — which is exactly where $f$ has its poles.
- The second alternative is a *negative* integer power $(Az+B)^{-n}$ with $n \ge 1$; a positive power is a different family.
- The extra hypothesis of the second conclusion is the absence of zeros, strictly stronger than their finiteness.
- "Finitely many poles" is finiteness of the set of points of negative meromorphic order; zeros are points of positive order. Literal value-sets of the representative are the wrong notion on both sides: derivatives junk-vanish at poles, and values on discrete sets are unconstrained.
