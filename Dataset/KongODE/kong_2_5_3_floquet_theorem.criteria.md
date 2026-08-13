# Criteria: kong_2_5_3_floquet_theorem

**Statement:** [kong_2_5_3_floquet_theorem.md](kong_2_5_3_floquet_theorem.md) · **Lean:** [kong_2_5_3_floquet_theorem.lean](kong_2_5_3_floquet_theorem.lean)

## What the theorem says

Consider $x' = A(t)x$ where $A$ is continuous and repeats itself every $\omega$ units of time. Let
$X(t)$ be a fundamental matrix solution — a matrix-valued solution that is invertible at every time.
Floquet's theorem says that $X$ factors as $X(t) = P(t)e^{Rt}$, where $R$ is a constant matrix and
$P$ is a continuously differentiable, invertible, $\omega$-periodic matrix function. In words: up to
a periodic change of variables, the periodic system behaves like a constant-coefficient one. The
matrices $R$ and $P$ have to be allowed complex entries even though $A$ and $X$ are real.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The period is positive. | ✅ `hω : 0 < ω`. |
| 2 | $A$ repeats with period $\omega$ at every real time. | ✅ `PeriodicLinearEquation ω A`, which is `∀ t, A (t + ω) = A t`. |
| 3 | $A$ is continuous. | ✅ `hA : Continuous A`. |
| 4 | $X$ is a fundamental matrix solution on **all** of $\mathbb{R}$: it solves $X' = A(t)X$ and is invertible at every time. | ✅ `FundamentalMatrixSolution univ A X`. |
| 5 | The produced $R$ is a constant matrix with complex entries. | ✅ `∃ R : Matrix (Fin n) (Fin n) ℂ`. |
| 6 | The produced $P$ is a complex matrix-valued function of $t$ and is $C^1$. | ✅ `∃ P : ℝ → Matrix (Fin n) (Fin n) ℂ` with `∀ i j, ContDiff ℝ 1 fun t ↦ P t i j`. |
| 7 | $P$ has the same period $\omega$. | ✅ `∀ t, P (t + ω) = P t`. |
| 8 | $P$ is invertible at every time. | ✅ `∀ t, IsUnit (P t)`. |
| 9 | The factorization holds at every $t$, in the order $P(t)$ then $e^{tR}$, with the real matrix $X$ pushed into the complex ones. | ✅ `∀ t, (X t).map (algebraMap ℝ ℂ) = P t * NormedSpace.exp (t • R)`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Stating the factorization over $\mathbb{R}$, with $R$ and $P$ real. | False in general. The factorization needs a logarithm of the real matrix $X(\omega)X^{-1}(0)$, and a real matrix with a negative eigenvalue has no real logarithm. Kong's real version only holds with period $2\omega$. |
| 2 | Writing $e^{Rt}P(t)$ instead of $P(t)e^{Rt}$. | Matrices do not commute, so this is a different claim. |
| 3 | Omitting the requirement that $P(t)$ is invertible. | The statement collapses: take $R = 0$ and $P = X$ and it holds trivially. |
| 4 | Omitting the periodicity of $P$. | Same collapse, for the same reason. Periodicity of $P$ is the whole content. |
| 5 | Omitting the continuity of $A$. | The conclusion becomes false. Since $e^{tR}$ is invertible, $P(t) = X(t)e^{-tR}$ is forced, so demanding $P \in C^1$ demands $X \in C^1$, hence $A = X'X^{-1}$ continuous. Counterexample: take $n = 1$; let $\psi$ be differentiable with $\psi \equiv 0$ near $1$ and $\psi(t) = t^2\sin(1/t)$ near $0$, $\psi(0) = 0$; paste copies of $\psi$ on each $[k, k+1]$ to get a function $h$ with $1$-periodic increments. Then $A := h'$ is $1$-periodic and discontinuous at the integers, $X := e^{h}$ is a fundamental matrix solution, and no $C^1$ factorization exists. |
| 6 | Assuming $X$ is a fundamental matrix solution only on a bounded interval. | The conclusion is a statement about all of $\mathbb{R}$, so the hypothesis has to be global too. |
| 7 | Dropping the $C^1$ requirement on $P$ and asking only for continuity or measurability. | The theorem asserts $P \in C^1(\mathbb{R}, \mathbb{C}^{n\times n})$; the regularity is part of what makes the change of variables usable. |

## Notes on the ground truth

- The regularity of $P$ is written entrywise, `∀ i j, ContDiff ℝ 1 fun t ↦ P t i j`. That is equivalent to `ContDiff ℝ 1 P` into the finite-dimensional matrix space, but noisier; the packaged form would read better.
- `NormedSpace.exp` is mathlib's matrix exponential, defined by the norm-independent series, so no norm instance has to be chosen in the statement. The exponent is written `t • R` with the real scalar $t$ acting on the complex matrix $R$.
- The real fundamental matrix is coerced entrywise with `(X t).map (algebraMap ℝ ℂ)`, which is the only place the real/complex boundary is crossed.
