# Criteria: hayman_2_9_polya_composition_order

**Statement:** [hayman_2_9_polya_composition_order.md](hayman_2_9_polya_composition_order.md) · **Lean:** [hayman_2_9_polya_composition_order.lean](hayman_2_9_polya_composition_order.lean)

## What the theorem says

Let $f$ and $g$ be entire functions and put $\phi = g \circ f$. Write $M(r,h)$ for the largest value
of $\lvert h\rvert$ on the circle of radius $r$. A function has *finite order* when
$\log M(r) \le r^{k}$ for some fixed $k$ and all large $r$, and *zero order* when
$\log M(r) \le r^{\varepsilon}$ for every $\varepsilon > 0$ and all large $r$. Pólya's theorem says
that if the composition $\phi$ has finite order, then at least one of two things happens: $f$ is a
polynomial, or $g$ has zero order. Composing two genuinely fast-growing functions cannot stay of
finite order.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $f$ is entire. | ✅ `hf : Differentiable ℂ f`, i.e. differentiable at every point of `ℂ`. |
| 2 | $g$ is entire. | ✅ `hg : Differentiable ℂ g`. |
| 3 | The growth hypothesis is on the composition $g \circ f$, in that order (inner $f$, outer $g$). | ✅ `hcomp : HasFiniteOrder (g ∘ f)`. |
| 4 | "Finite order" is: there exists an exponent $k$ such that $\lvert h(z)\rvert \le e^{r^{k}}$ whenever $\lVert z\rVert \le r$, for all large $r$. | ✅ `HasFiniteOrder` in `Defs.lean`: `∃ k : ℝ, ∀ᶠ r in atTop, ∀ z, ‖z‖ ≤ r → ‖f z‖ ≤ Real.exp (r ^ k)`. |
| 5 | "Zero order" is the same bound but for *every* positive $\varepsilon$ in place of $k$. | ✅ `HasZeroOrder`: `∀ ε, 0 < ε → ∀ᶠ r in atTop, ∀ z, ‖z‖ ≤ r → ‖f z‖ ≤ Real.exp (r ^ ε)`. |
| 6 | The conclusion is a disjunction of two alternatives. | ✅ `(∃ p : Polynomial ℂ, ∀ z, f z = p.eval z) ∨ HasZeroOrder g`. |
| 7 | "$f$ is a polynomial" means $f$ agrees with the evaluation of some polynomial at every point. | ✅ `∃ p : Polynomial ℂ, ∀ z, f z = p.eval z`. |
| 8 | The zero-order alternative is about $g$ (the outer function), and the polynomial alternative about $f$ (the inner one). | ✅ The two branches are attached to the correct function. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Concluding only that $f$ is a polynomial. | False. Take $g$ constant and $f(z) = e^{z}$. Then $g \circ f$ is constant, so it has finite order, and $g$ has zero order — but $f$ is not a polynomial. The second branch is genuinely needed. |
| 2 | Concluding only that $g$ has zero order. | False. Take $f(z) = z^{2}$ and $g(z) = e^{z}$: the composition $e^{z^{2}}$ has order $2$, which is finite, but $g$ has order $1$, not zero. |
| 3 | Replacing the disjunction by a conjunction. | The theorem gives one alternative or the other, never both at once, and either can fail on its own. |
| 4 | Collapsing "finite order" and "zero order" into one notion, or using $\exists \varepsilon$ where $\forall \varepsilon$ is meant. | The two differ only in the quantifier on the exponent. With $\exists$ the zero-order branch would be implied by finite order, and the conclusion would become trivial. |
| 5 | Putting the finite-order hypothesis on $f$ instead of on $g \circ f$. | A different theorem. The whole point is that finiteness of the *composition* forces the dichotomy. |
| 6 | Defining the order as $\limsup_{r\to\infty} \frac{\log\log M(r)}{\log r}$ without care for the degenerate cases. | For a bounded $g$, $\log\log M(r)$ is undefined or negative infinite, and Lean's `limsup` and `Real.log` return default values there, so the definition can silently say the wrong thing. The pointwise-bound form avoids all of this. |
| 7 | Requiring the growth bound at every radius rather than for all large $r$. | A bound like $\lvert h(z)\rvert \le e^{r^{k}}$ can easily fail at small $r$ (for instance $r < 1$ with $k$ large), so a for-all-$r$ version would be a strictly different and sometimes false hypothesis. |

## Notes on the ground truth

- "Integral function" is Hayman's term for an entire function, formalized here as
  `Differentiable ℂ` on all of `ℂ`.
- `HasFiniteOrder` and `HasZeroOrder` are stated as eventual pointwise bounds on $\lVert f z\rVert$
  for $\lVert z\rVert \le r$, rather than through a `limsup` of $\log\log M(r)/\log r$. That is
  equivalent to the usual definition and avoids any default-value question: no supremum, logarithm or
  division is taken. It is also slightly stronger-looking than the book's $O(r^{k})$ because there is
  no multiplicative constant, but absorbing a constant into a larger exponent shows the two agree.
- The exponent $r^{k}$ uses real exponentiation, so $k$ may be any real number, not just a natural
  one. That matches "order" being a real number.
- No integrals, `Set.ncard`, or coercions to `ℝ` from an extended type occur here.
