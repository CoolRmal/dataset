# Criteria: nikolski_A_3_7_blaschke_zero_sets

**Statement:** [nikolski_A_3_7_blaschke_zero_sets.md](nikolski_A_3_7_blaschke_zero_sets.md) · **Lean:** [nikolski_A_3_7_blaschke_zero_sets.lean](nikolski_A_3_7_blaschke_zero_sets.lean)

## What the theorem says

Let $(\lambda_n)$ be a sequence of points of the open unit disc. If some function that is analytic
on the disc, is not identically zero, and has bounded logarithmic means — in particular any nonzero
function in a Hardy class $H^p$ — has exactly these points as its zeros, each repeated as often as
its multiplicity, then $\sum_n (1 - \lvert\lambda_n\rvert)$ converges. This is the Blaschke
condition. Conversely, any sequence satisfying it is realized: the Blaschke product
$B = \prod_n b_{\lambda_n}$ converges locally uniformly on the disc, satisfies
$\lvert B\rvert \le 1$ there and $\lvert B\rvert = 1$ almost everywhere on the circle, and has
exactly those zeros with those multiplicities.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The exponent is not $0$. | ✅ `hp : p ≠ 0`. |
| 2 | The points $\lambda_n$ lie in the open unit disc. | ✅ First conjunct of `BlaschkeCondition a`, and again inside `HasZeroSequence f a`. |
| 3 | The Blaschke condition is the convergence of $\sum_n (1 - \lvert\lambda_n\rvert)$. | ✅ `Summable (fun n : ℕ ↦ 1 - ‖a n‖)`. |
| 4 | The function is in a Hardy class. | ✅ `HardyClass p f`. |
| 5 | The function is not identically zero on the disc. | ✅ `∃ z ∈ Metric.ball (0 : ℂ) 1, f z ≠ 0`. |
| 6 | Zeros are counted with multiplicity: for each point $z$ of the disc, the number of indices $n$ with $\lambda_n = z$ equals the order of vanishing of $f$ at $z$. | ✅ `HasZeroSequence f a` asks for `∃ k, (∀ j < k, iteratedDeriv j f z = 0) ∧ iteratedDeriv k f z ≠ 0 ∧ {n \| a n = z}.ncard = k`. |
| 7 | Each such fibre is finite, so that counting is meaningful. | ✅ `{n \| a n = z}.Finite`, a separate conjunct of `HasZeroSequence`. |
| 8 | The sequence lists *all* the zeros, not merely some of them. | ✅ The multiplicity clause is quantified over **every** `z ∈ Metric.ball (0 : ℂ) 1`; at a point where $f$ does not vanish, $k = 0$ forces the fibre to be empty. |
| 9 | Both directions are asserted. | ✅ A single `↔` between "some nonzero $H^p$ function has `a` as its zero sequence" and `BlaschkeCondition a`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Encoding "zero sequence" as `∀ n, f (a n) = 0`. | That says only that each listed point is a zero. It records no multiplicity and does not say the list is complete, so a function with extra zeros or with a higher-order zero would qualify and the forward implication would be about the wrong object. |
| 2 | Using `Set.ncard` for the multiplicity without also asserting the fibre is finite. | `Set.ncard` of an infinite set is $0$ in Lean, so an infinitely repeated point would report multiplicity $0$ and pass the check. |
| 3 | Writing the Blaschke condition as `∑' n, (1 - ‖a n‖) < ∞` with `tsum`. | Lean gives a non-summable family the sum $0$, so this inequality would hold for free and the condition would be no condition at all. |
| 4 | Omitting $p \ne 0$. | `eLpNorm f 0 μ = 0` in Lean, so `HardyClass 0 f` reduces to "analytic on the disc". A nonzero analytic function on the disc can have a zero sequence that is not Blaschke, so the forward direction becomes false. |
| 5 | Dropping the hypothesis that the function is not identically zero. | The zero function vanishes at every point to infinite order, so any sequence at all would be its zero sequence and the forward direction fails. |
| 6 | Stating only one implication. | The material is genuinely two-directional: 3.7.1 gives one way, 3.7.3 the other, and each is a separate theorem. |
| 7 | Allowing $\lvert\lambda_n\rvert = 1$ (points on the circle). | The Blaschke sum is then meaningless as a condition on interior zeros, and the zeros of an analytic function on the open disc are interior points. |

## Notes on the ground truth

- `iteratedDeriv` is built from Lean's global `deriv`, which returns $0$ wherever the function is
  not differentiable. Using it for the order of vanishing is legitimate here only because
  `Metric.ball 0 1` is open, so `DifferentiableOn ℂ f (ball 0 1)` gives differentiability at every
  interior point and the iterated derivatives agree with the analytic ones. Mathlib's
  `AnalyticAt.order` would state "multiplicity" directly and avoid relying on that argument.
- Honest limitation: a sequence of type `ℕ → ℂ` cannot enumerate a *finite* zero multiset, because
  $\mathbb{N}$ would then be a finite union of finite fibres. So `HasZeroSequence f a` is
  unsatisfiable when $f$ has finitely many zeros, and `BlaschkeCondition a` forces
  $\lvert a_n\rvert \to 1$. The theorem as stated is true, but it silently covers only infinite
  zero sequences, whereas the book covers any zero sequence. Indexing by an arbitrary countable
  type, or allowing a sentinel for "no further zeros", would fix this.
- The reverse direction only produces *some* nonzero $H^p$ function with those zeros. The extra
  content of 3.7.3 — the explicit product $B = \prod_n b_{\lambda_n}$, its uniform convergence on
  compact subsets of the disc and of $\mathbb{C}\setminus\operatorname{clos}\{1/\lambda_n\}$, the
  bound $\lvert B\rvert \le 1$ on the disc, and $\lvert B\rvert = 1$ almost everywhere on the
  circle — is not stated. `FiniteBlaschkeProductDegreeLE` and `InnerFunction` in `Defs.lean` show
  an infinite-product version was within reach.
- The hypothesis of 3.7.1 is weaker than membership in $H^p$: it asks only that
  $\lim_{r\to1}\int_{\mathbb{T}}\log\lvert f_r\rvert\,dm$ be finite, with $H^p$ appearing as the
  "in particular". The ground truth uses `HardyClass p f`, i.e. the special case, which is what
  makes the two directions combine into a single `↔`.
- The summands $1 - \lvert\lambda_n\rvert$ are nonnegative, so `Summable` (which is unconditional
  convergence) is exactly the printed condition.
