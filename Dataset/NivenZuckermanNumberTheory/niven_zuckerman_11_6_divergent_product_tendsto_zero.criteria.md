# Criteria: niven_zuckerman_11_6_divergent_product_tendsto_zero

**Statement:** [niven_zuckerman_11_6_divergent_product_tendsto_zero.md](niven_zuckerman_11_6_divergent_product_tendsto_zero.md) · **Lean:** [niven_zuckerman_11_6_divergent_product_tendsto_zero.lean](niven_zuckerman_11_6_divergent_product_tendsto_zero.lean) · **Context:** [niven_zuckerman_11_6_divergent_product_tendsto_zero.context.md](niven_zuckerman_11_6_divergent_product_tendsto_zero.context.md)

## What the theorem says

Take numbers $c_1, c_2, \dots$ each strictly between $0$ and $1$, and suppose the series
$\sum c_j$ diverges, meaning its partial sums grow without bound. Form the products
$(1-c_1)(1-c_2)\cdots(1-c_n)$. The lemma says these products get arbitrarily small: for any
$\varepsilon > 0$ there is an $N$ beyond which every such product is below $\varepsilon$. Since each
factor lies in $(0,1)$ the products are positive and decreasing, so this is exactly the statement
that they tend to $0$. Divergence of $\sum c_j$ is essential: for a convergent series the products
settle down at a positive number instead.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | Every term satisfies $c_j > 0$. | ✅ `hpos : ∀ j, 0 < c j`. |
| 2 | Every term satisfies $c_j < 1$. | ✅ `hlt : ∀ j, c j < 1`. |
| 3 | The series $\sum c_j$ diverges: its partial sums tend to $+\infty$. | ✅ `hdiv : Tendsto (fun n ↦ ∑ j ∈ Finset.range n, c j) atTop atTop`. |
| 4 | The objects being controlled are the partial products $\prod_{j<n}(1-c_j)$ of the numbers $1-c_j$, not of the $c_j$ themselves. | ✅ `∏ j ∈ Finset.range n, (1 - c j)`. |
| 5 | The conclusion is that these partial products tend to $0$ as $n \to \infty$. | ✅ `Tendsto … atTop (𝓝 0)`, which is the $\varepsilon$–$N$ form of the book for a positive decreasing sequence. |
| 6 | The sequence $c$ is an arbitrary real sequence subject only to these hypotheses. | ✅ `(c : ℕ → ℝ)` is universally quantified. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Omitting the divergence hypothesis. | This is the highest-value trap and the statement becomes false. Take $c_j = 2^{-j-1}$: all terms lie in $(0,1)$, the series converges, and the products stay above $1/4$ forever. |
| 2 | Omitting $c_j < 1$. | Also false. Take $c_j = 2$ for all $j$: the partial sums tend to $+\infty$, but every factor is $-1$, so the products alternate between $1$ and $-1$ and never approach $0$. |
| 3 | Writing the $\varepsilon$–$N$ conclusion as "there exists $n \ge N$ with $\prod < \varepsilon$". | Far weaker. The book asserts the bound for *every* $n \ge N$, which is what makes it convergence to $0$. |
| 4 | Expressing the conclusion as an infinite product equal to zero, `∏' j, (1 - c j) = 0`. | Mathlib's infinite product deliberately excludes limits that are $0$: such a family is not `Multipliable`, and `∏'` then returns $1$, not $0$. So this cannot express the conclusion and may even be provably false. |
| 5 | Concluding only that the products are bounded above by some constant less than $1$, or that they are decreasing. | Both are immediate from $0 < c_j < 1$ alone and say nothing about divergence. |
| 6 | Replacing divergence of $\sum c_j$ by divergence of $\sum(1-c_j)$, or by "$c_j$ does not tend to $0$". | Different hypotheses. The second is strictly stronger and would make the lemma much weaker. |

## Notes on the ground truth

- Products and sums run over `Finset.range n`, i.e. indices $0,\dots,n-1$, while the book indexes
  from $1$. The hypotheses apply to all indices, so this shift changes nothing.
- Divergence is written as "the partial sums tend to `atTop`". For a sequence of nonnegative terms
  this is equivalent to `¬ Summable c`, so a candidate using the latter should be accepted.
- The hypothesis $0 < c_j$ is the printed one, but it is not needed for the conclusion: from
  $c_j < 1$ and divergence alone one gets $\log(1-c_j) \le -c_j$, hence the products still tend to
  $0$. We keep it because the book states it.
- The book's $\varepsilon$–$N$ phrasing and our `Tendsto … (𝓝 0)` say the same thing here, because
  the partial products are positive. A candidate writing the explicit $\varepsilon$–$N$ form is
  equally faithful.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[niven_zuckerman_11_6_divergent_product_tendsto_zero.md](niven_zuckerman_11_6_divergent_product_tendsto_zero.md) and the background in [niven_zuckerman_11_6_divergent_product_tendsto_zero.context.md](niven_zuckerman_11_6_divergent_product_tendsto_zero.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 6 rows, so each row is worth 8.3 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 3 with summability in place of divergence, which reverses the hypothesis.
- Requirement 1 or 2 with either bound on $c_j$ dropped.
- Requirement 4 with the product taken of $c_j$ rather than of $1-c_j$.

### Domain-specific pitfalls for this problem

- Divergence here means the partial sums tend to $+\infty$, which for a non-negative series is the negation of summability.
- The factors are $1 - c_j$, and they lie in $(0,1)$ exactly because of the two hypotheses on $c_j$.
- The conclusion is convergence of the partial products to $0$, equivalent to the printed $\varepsilon$-$N$ form.
- The sequence is otherwise arbitrary.
