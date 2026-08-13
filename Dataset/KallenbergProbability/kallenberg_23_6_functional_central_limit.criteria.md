# Criteria: kallenberg_23_6_functional_central_limit

**Statement:** [kallenberg_23_6_functional_central_limit.md](kallenberg_23_6_functional_central_limit.md) · **Lean:** [kallenberg_23_6_functional_central_limit.lean](kallenberg_23_6_functional_central_limit.lean)

## What the theorem says

Take independent, identically distributed random vectors $\xi_1, \xi_2, \dots$ in $\mathbb{R}^d$ with
mean $0$ and covariance the identity matrix. For each $n$, build a continuous path $X^n$ by adding up
the first $\lfloor nt \rfloor$ of them, filling in the gaps by straight lines, and dividing by
$\sqrt{n}$. Donsker's theorem says these random paths converge in distribution to a $d$-dimensional
Brownian motion, as random elements of the space of continuous functions from $\mathbb{R}_+$ to
$\mathbb{R}^d$. The convergence is on path space, not just at finitely many times.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The $\xi_k$ are mutually independent — the whole sequence, not just pairs — and all have the same law. | ✅ `hiid : iIndepFun ξ μ ∧ ∀ n, IdentDistrib (ξ n) (ξ 0) μ μ`. |
| 2 | Each coordinate of $\xi_1$ is square integrable. | ✅ `hsecondMoment : ∀ i, MemLp (fun ω ↦ ξ 0 ω i) 2 μ`. |
| 3 | Every coordinate has mean $0$. | ✅ `hmean : ∀ i, ∫ ω, ξ 0 ω i ∂μ = 0`. |
| 4 | The covariance matrix is the identity: each coordinate has variance $1$, and different coordinates are uncorrelated. | ✅ `hcovariance : ∀ i j, ∫ ω, ξ 0 ω i * ξ 0 ω j ∂μ = if i = j then 1 else 0`, which covers the diagonal and the off-diagonal together. |
| 5 | $X^n$ is the rescaled partial sum with the linear interpolation term, summed over $k \le nt$. | ✅ `hX`: `X n ω t i = (Real.sqrt n)⁻¹ * ((∑ k ∈ Finset.Icc 1 ⌊n * t⌋₊, ξ k ω i) + (n * t - ⌊n * t⌋₊) * ξ (⌊n * t⌋₊ + 1) ω i)`. `Finset.Icc 1 ⌊nt⌋₊` is exactly $\{1, \dots, \lfloor nt\rfloor\}$. |
| 6 | The $X^n$ are random elements of the space of continuous $\mathbb{R}^d$-valued paths on $\mathbb{R}_+$, with that space carrying its Borel $\sigma$-algebra. | ✅ `X : ℕ → Ω → C(ℝ≥0, Fin d → ℝ)` together with `[MeasurableSpace C(ℝ≥0, Fin d → ℝ)] [BorelSpace C(ℝ≥0, Fin d → ℝ)]`, and `hXmeas : ∀ n, AEMeasurable (X n) μ`. |
| 7 | The limit is a genuine $d$-dimensional Brownian motion: every coordinate is a real Brownian motion *and* the coordinates are independent. | ✅ `hB : IsBrownianVector B μ'`, which is `(∀ i, IsBrownianReal (fun t ω ↦ B ω t i) μ') ∧ ∀ times : Finset ℝ≥0, iIndepFun (fun i ω (t : times) ↦ B ω t i) μ'`. |
| 8 | The conclusion is convergence in distribution on path space, with the $X^n$ and $B$ allowed to live on different probability spaces. | ✅ `TendstoInDistribution X atTop B (fun _ ↦ μ) μ'`, with `X n` on `(Ω, μ)` and `B` on `(Ω', μ')`. |
| 9 | Both measures are probability measures. | ✅ `[IsProbabilityMeasure μ] [IsProbabilityMeasure μ']`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Concluding only that the finite-dimensional distributions converge. | That is a strictly weaker fact and omits tightness on path space, which is the entire difficulty of Donsker's theorem. |
| 2 | Dropping the interpolation term $(nt - \lfloor nt\rfloor)\,\xi_{\lfloor nt\rfloor + 1}$. | The paths are then step functions, which are not continuous, so the statement is about $D$-space and the Skorokhod topology instead of $C$. |
| 3 | Summing over `Finset.range ⌊n * t⌋₊`. | With the sequence indexed from $1$ this is off by one: it drops $\xi_{\lfloor nt\rfloor}$ and includes $\xi_0$, which is not part of the array. |
| 4 | Assuming only pairwise independence, or identical distribution without independence, or independence without identical distribution. | Pairwise independence is not enough for a central limit theorem, and either half alone leaves the law of the limit undetermined. |
| 5 | Stating only that each coordinate has variance $1$, and omitting the off-diagonal condition. | Uncorrelated coordinates are what make the limit a *standard* Brownian motion; without it the limit is a Brownian motion with an arbitrary covariance. |
| 6 | Omitting the square-integrability hypothesis. | The mean and covariance are Bochner integrals, and Lean gives a Bochner integral of a non-integrable function the value $0$. Without square integrability those hypotheses can hold for the wrong reason, and the theorem is false. |
| 7 | Asserting each coordinate of $B$ is Brownian but not that the coordinates are independent. | That does not determine the law of $B$, so the conclusion is not a well-posed limit statement. |
| 8 | Using a.s. convergence or convergence in probability. | The $X^n$ and $B$ are on different probability spaces, so those modes are not even expressible; even on one space they are false here. |
| 9 | Working in `C([0,1], ℝ^d)` or in the plain function space `ℝ≥0 → Fin d → ℝ`. | The first changes the time interval; the second carries the product $\sigma$-algebra, for which the set of continuous paths is not measurable and the statement loses its meaning. |

## Notes on the ground truth

- `X` is a parameter constrained by the equation `hX` rather than a defined object, and `hX` is only
  imposed for `0 < n`. ⚠️ This is acceptable: the conclusion is a limit along `atTop`, so `X 0` is
  irrelevant, and $1/\sqrt{0}$ would be undefined anyway. A candidate must not, however, leave
  `X n` unconstrained for infinitely many `n`.
- ⚠️ Independence of the coordinates of $B$ is encoded through all finite collections of times rather
  than directly on path space. This is equivalent, because cylinder sets generate the Borel
  $\sigma$-algebra of path space, but `iIndepFun (fun i ω ↦ fun t ↦ B ω t i) μ'` would render
  "$B^1, \dots, B^d$ are independent" more directly.
- `hξmeas : ∀ n, AEMeasurable (ξ n) μ` is largely redundant given `hsecondMoment` and
  `IdentDistrib`; it is harmless. `hXmeas` is genuinely needed, since path space is not discrete.
