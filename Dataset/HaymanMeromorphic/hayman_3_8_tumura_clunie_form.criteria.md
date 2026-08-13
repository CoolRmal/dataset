# Criteria: hayman_3_8_tumura_clunie_form

**Statement:** [hayman_3_8_tumura_clunie_form.md](hayman_3_8_tumura_clunie_form.md) · **Lean:** [hayman_3_8_tumura_clunie_form.lean](hayman_3_8_tumura_clunie_form.lean)

## What the theorem says

Suppose $f$ is meromorphic in the plane with only finitely many poles, and that both $f$ and one of
its higher derivatives $f^{(l)}$, with $l \ge 2$, have only finitely many zeros. Then $f$ is forced
into a very rigid shape: $f = \dfrac{P_1}{P_2}e^{P_3}$ with $P_1, P_2, P_3$ polynomials. If moreover
$f$ and $f^{(l)}$ have *no* zeros at all, the shape narrows to one of exactly two possibilities,
$f(z) = e^{Az+B}$ or $f(z) = (Az+B)^{-n}$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $f$ is meromorphic on the whole plane. | ✅ `hf : Meromorphic f`. |
| 2 | $f$ has only finitely many poles. | ⚠️ `hpoles : {z : ℂ \| ¬ AnalyticAt ℂ f z}.Finite`. "Meromorphic but not analytic" also covers a point where $f$ merely carries the wrong value; see the notes. |
| 3 | $f$ has only finitely many zeros. | ✅ `hzeros : {z : ℂ \| f z = 0}.Finite`. |
| 4 | $f^{(l)}$ has only finitely many zeros. | ✅ `hlzeros : {z : ℂ \| iteratedDeriv l f z = 0}.Finite`. |
| 5 | The order of differentiation satisfies $l \ge 2$. | ✅ `hl : 2 ≤ l`. |
| 6 | First conclusion: $f = P_1 e^{P_3}/P_2$ for three polynomials, with $P_2$ not the zero polynomial. | ✅ `∃ P₁ P₂ P₃ : Polynomial ℂ, P₂ ≠ 0 ∧ ∀ z, P₂.eval z ≠ 0 → f z = P₁.eval z / P₂.eval z * Complex.exp (P₃.eval z)`. |
| 7 | The identity is asserted away from the zeros of $P_2$, since those are where $f$ has its poles. | ✅ The guard `P₂.eval z ≠ 0` on the equation, with `P₂ ≠ 0` ensuring the excluded set is finite. |
| 8 | Second conclusion, under the extra hypothesis that $f$ and $f^{(l)}$ have no zeros at all. | ✅ Second conjunct, guarded by `{z \| f z = 0} = ∅ ∧ {z \| iteratedDeriv l f z = 0} = ∅`. |
| 9 | That second conclusion is a disjunction of exactly the two shapes $e^{Az+B}$ and $(Az+B)^{-n}$. | ✅ `(∃ A B, ∀ z, f z = Complex.exp (A * z + B)) ∨ ∃ A B n, 1 ≤ n ∧ ∀ z, A * z + B ≠ 0 → f z = (A * z + B) ^ (-(n : ℤ))`. |
| 10 | In the second shape the exponent is a *negative* integer power with $n \ge 1$, and the identity holds away from the zero of $Az+B$. | ✅ `(A * z + B) ^ (-(n : ℤ))` with `1 ≤ n` and the guard `A * z + B ≠ 0`. |

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

## Notes on the ground truth

- The two conclusions are conjoined, with the second one written as an implication whose antecedent
  is the extra zero-free assumption. This keeps both of Hayman's claims in one declaration and
  matches the "If, further, …" of the text.
- The pole set is written `{z \| ¬ AnalyticAt ℂ f z}`. For a meromorphic function this is nearly the
  pole set, but it also flags a point at which $f$ has a removable singularity yet carries the wrong
  value. Here that looseness is harmless: such a point can be swallowed by a factor of $P_2$, since
  the identity is only asserted off the zeros of $P_2$. Identifying poles by negative
  `MeromorphicAt.order` would still be the cleaner encoding.
- `Set.Finite` and `= ∅` are exact conditions with no default-value behaviour, and polynomial
  evaluation is a total function, so nothing in this statement can be satisfied by a junk value.
- The negative power is written with an integer exponent, `(A * z + B) ^ (-(n : ℤ))`, so Lean's
  `zpow` is used; at $Az+B = 0$ that would return $0$, which is why the guard is present.
