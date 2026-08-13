# Criteria: folland_4_81_almost_periodic_characterization

**Statement:** [folland_4_81_almost_periodic_characterization.md](folland_4_81_almost_periodic_characterization.md) · **Lean:** [folland_4_81_almost_periodic_characterization.lean](folland_4_81_almost_periodic_characterization.lean)

## What the theorem says

Let $G$ be a locally compact abelian group and $f$ a bounded continuous function on it. Folland
gives three equivalent descriptions of what it means for $f$ to be almost periodic: (a) $f$ extends
continuously to the Bohr compactification $bG$; (b) $f$ is a uniform limit of finite linear
combinations $\sum c_\xi\,\xi(x)$ of characters; (c) $f$ is uniformly almost periodic, meaning the
family of its right translates $R_yf(x) = f(xy)$ is totally bounded in the supremum norm — finitely
many translates approximate all of them, uniformly on $G$.

For $G = \mathbb{R}$ this recovers Bohr's classical theory: the almost periodic functions are the
uniform limits of trigonometric polynomials $\sum c_k e^{i\lambda_k x}$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $G$ is a locally compact abelian topological group. | ✅ `[CommGroup G] [TopologicalSpace G] [IsTopologicalGroup G] [LocallyCompactSpace G]`. |
| 2 | $f$ is continuous. | ✅ `hf : Continuous f`. |
| 3 | $f$ is bounded. | ✅ `hbdd : ∃ C : ℝ, ∀ x, ‖f x‖ ≤ C`. |
| 4 | The statement is an equivalence between the two conditions, not an implication. | ✅ The conclusion is an `↔`. |
| 5 | Side (b): for every $\varepsilon > 0$ there is an approximating combination. | ✅ `∀ ε : ℝ, 0 < ε → ∃ …`. |
| 6 | The combination is a **finite** sum over characters, with arbitrary complex coefficients. | ✅ `∃ (s : Finset (PontryaginDual G)) (c : PontryaginDual G → ℂ), … ∑ ξ ∈ s, c ξ * (ξ x : ℂ)`. |
| 7 | The approximation is uniform in $x$: one choice of sum works for all $x$ at once. | ✅ The `∀ x` sits **inside** the `∃ s, ∃ c`, so `s` and `c` do not depend on `x`. |
| 8 | Characters are the continuous homomorphisms into the circle, taking values of modulus one. | ✅ `PontryaginDual G`, with `ξ x : Circle` coerced into `ℂ`. |
| 9 | Side (c): the right translates admit a finite $\varepsilon$-net **for the supremum norm**. | ✅ `IsUniformlyAlmostPeriodic f`, spelled out in `Defs.lean` as `∀ ε > 0, ∃ s : Finset G, ∀ y, ∃ z ∈ s, ∀ x, ‖rightTranslate y f x - rightTranslate z f x‖ < ε`. |
| 10 | The translates used are the **right** translates $R_yf(x) = f(xy)$. | ✅ `rightTranslate`, defined in `Defs.lean` as `fun x ↦ f (x * y)`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Writing side (c) as `TotallyBounded (Set.range fun y ↦ rightTranslate y f)` inside `G → ℂ`. | Mathlib puts the product uniformity on `G → ℂ`, which is the uniformity of *pointwise* convergence. Under it every uniformly bounded family is totally bounded, so this condition holds for every bounded $f$ and the equivalence becomes false. This is the highest-value trap in this problem. |
| 2 | Approximating by an infinite series $\sum_{n} c_n \xi_n(x)$ instead of a finite sum. | Folland's (b) is a uniform limit of *finite* linear combinations. Allowing infinite sums changes the class and makes (b) $\Rightarrow$ (c) fail. |
| 3 | Restricting the coefficients to `ℝ`. | The characters are complex-valued; real coefficients do not span the trigonometric polynomials, and the resulting class is smaller. |
| 4 | Putting the `∀ x` outside the choice of `s` and `c`, so the approximating sum may depend on the point. | That is pointwise approximation, which is far weaker than uniform and true for many non-almost-periodic functions. |
| 5 | Measuring the approximation in $L^2$ or $L^1$ instead of uniformly. | Uniform approximation is the whole distinction between almost periodicity and Fourier analysis on the group. |
| 6 | Dropping the boundedness or the continuity of $f$. | Both are standing hypotheses of Folland 4.81. Side (b) forces boundedness automatically, but side (c) as stated does not, so the equivalence needs it. |
| 7 | Stating only one implication. | The theorem is an equivalence; each direction is a separate substantial argument. |

## Notes on the ground truth

- ⚠️ Only the equivalence (b) $\Leftrightarrow$ (c) is formalized. Clause (a), that $f$ extends to a
  continuous function on the Bohr compactification $bG$, is omitted because Mathlib has no Bohr
  compactification. A candidate that also formalizes (a) — for instance by quantifying over a
  compact group containing a dense continuous image of $G$ — is closer to the printed theorem.
- `IsUniformlyAlmostPeriodic` is written out in `Defs.lean` as an explicit finite $\varepsilon$-net
  in the supremum norm, precisely to avoid Mathlib's pointwise uniformity on `G → ℂ`. An earlier
  version of the statement used `TotallyBounded` and was satisfied by every bounded function; that
  was rewritten.
- Boundedness is a standing hypothesis rather than a derived fact. It follows from side (b), since
  characters have modulus one and a uniform limit of bounded functions is bounded; it does not drop
  out of the $\varepsilon$-net form of side (c), which only compares translates with each other.
- Folland states 4.81 for a locally compact group, but the section is about locally compact abelian
  groups, where characters exist in abundance; the Lean statement uses `CommGroup` to match.
- `PontryaginDual G` is Mathlib's dual group of continuous characters $G \to \mathbb{T}$, so the
  pairing $\langle x,\xi\rangle$ of the book is the application `ξ x`.
