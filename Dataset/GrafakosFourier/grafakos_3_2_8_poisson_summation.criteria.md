# Criteria: grafakos_3_2_8_poisson_summation

**Statement:** [grafakos_3_2_8_poisson_summation.md](grafakos_3_2_8_poisson_summation.md) · **Lean:** [grafakos_3_2_8_poisson_summation.lean](grafakos_3_2_8_poisson_summation.lean)

## What the theorem says

Let $f$ be continuous on $\mathbb{R}^n$ and decay slightly faster than $\lvert x\rvert^{-n}$, and
suppose the values of $\widehat f$ at the integer points are absolutely summable. Then summing $f$
over the translates of $x$ by the integer lattice gives the same answer as summing
$\widehat f(m)e^{2\pi i m\cdot x}$ over the lattice — the two Fourier series agree at every $x$.
Taking $x = 0$ gives the familiar special case: the sum of $\widehat f$ over $\mathbb{Z}^n$ equals
the sum of $f$ over $\mathbb{Z}^n$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $f$ is continuous on all of $\mathbb{R}^n$. | ✅ `Continuous f`, the first conjunct of `hf`. |
| 2 | The decay bound $\lvert f(x)\rvert \le C(1+\lvert x\rvert)^{-n-\delta}$ for *some* $C > 0$ and $\delta > 0$, valid at every $x$. | ✅ `∃ C δ : ℝ, 0 < C ∧ 0 < δ ∧ ∀ x, ‖f x‖ ≤ C * (1 + ‖x‖) ^ (-(n : ℝ) - δ)`, with the existential inside the hypothesis and the exponent a real power on the positive base `1 + ‖x‖`. |
| 3 | A separate hypothesis that $\widehat f$ restricted to $\mathbb{Z}^n$ is absolutely summable. | ✅ `Summable fun m : Fin n → ℤ ↦ 𝓕 f (WithLp.toLp 2 fun i ↦ (m i : ℝ))`. Over a countable index in `ℂ`, `Summable` is unconditional summability, which is the same as absolute summability. |
| 4 | $f$ is integrable, so that $\widehat f$ is a genuine integral rather than a default value. | ⚠️ `Integrable f` is listed, but it already follows from continuity plus the decay bound, so it is formally redundant. A candidate omitting it is still faithful. |
| 5 | The lattice $\mathbb{Z}^n$ is embedded into the *Euclidean* space, and both sums run over the full lattice. | ✅ `WithLp.toLp 2 fun i ↦ (m i : ℝ)` maps `Fin n → ℤ` into `EuclideanSpace ℝ (Fin n)`, and both `∑'` are indexed by `m k : Fin n → ℤ`. |
| 6 | The character is $e^{+2\pi i m\cdot x}$, with the sign opposite to the $e^{-2\pi i x\cdot\xi}$ inside the transform. | ✅ `Complex.exp (2 * Real.pi * Complex.I * (∑ i, (m i : ℂ) * (x i : ℂ)))`; the pairing matches the inner product used by `𝓕` and the signs are consistent. |
| 7 | First conclusion: the identity holds at *every* $x \in \mathbb{R}^n$. | ✅ `∀ x : EuclideanSpace ℝ (Fin n), ∑' m, 𝓕 f (…) * Complex.exp (…) = ∑' k, f (x + …)`. |
| 8 | Second conclusion: the "in particular" case at $x = 0$, $\sum_m \widehat f(m) = \sum_k f(k)$. | ✅ `(∑' m, 𝓕 f (…)) = ∑' k, f (…)` as the second conjunct. It is a consequence of the first, but the text states it and keeping it is harmless. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Omitting the decay hypothesis. | Without it, $\sum_k f(x+k)$ need not converge, and Lean assigns a divergent `tsum` the value `0`. The "identity" would then assert that the Fourier side equals `0`, which is false. |
| 2 | Weakening the decay to $O(\lvert x\rvert^{-n})$, or to mere integrability. | The exponent $-n$ is the borderline case: $\sum_k (1+\lvert k\rvert)^{-n}$ diverges over $\mathbb{Z}^n$. The strictly positive $\delta$ is what makes the periodization converge absolutely and be continuous. |
| 3 | Omitting the summability of $\widehat f$ over $\mathbb{Z}^n$, or trying to derive it from the decay of $f$. | It does not follow: decay of $f$ says nothing about decay of $\widehat f$. Without it the left-hand `tsum` is again the default `0` and the statement is false. |
| 4 | Using the character $e^{i m\cdot x}$ while keeping the $e^{-2\pi i x\cdot\xi}$ transform. | The two conventions must match; mixing them makes the identity false. The lattice dual to $\mathbb{Z}^n$ for the $2\pi$-convention is $\mathbb{Z}^n$ itself, which is what makes the formula constant-free. |
| 5 | Summing over $\mathbb{N}^n$, or over a one-sided range, on one or both sides. | Poisson summation is over the full lattice; a one-sided sum is a different and false statement. |
| 6 | Stating only the $x = 0$ identity. | That is the corollary. The theorem is the identity for all $x$, and the corollary is explicitly labelled "in particular". |

## Notes on the ground truth

- The four hypotheses are bundled into a single anonymous conjunction `hf : Continuous f ∧
  Integrable f ∧ (∃ C δ, …) ∧ Summable …`. Splitting them into separately named hypotheses would be
  more usable and more legible; the mathematical content is the same.
- `Integrable f` is redundant given continuity and the decay bound, but it makes the encoding
  visibly free of default values: `𝓕 f w` is a Bochner integral and would be `0` for
  non-integrable $f$. A candidate that omits *both* the integrability and the decay has a statement
  about the constant function `0`.
- A more informative version would also *assert* summability of the two families —
  `Summable (fun k : Fin n → ℤ ↦ f (x + …))` alongside the equality — rather than leaving it implicit
  in the `tsum`. Here the decay hypothesis forces it, so the ground truth is sound, but a candidate
  that concludes summability as well says strictly more and should be rewarded.
- The index type `Fin n → ℤ` is the natural rendering of $\mathbb{Z}^n$ and is countable, so `tsum`
  and `Summable` behave as expected.
