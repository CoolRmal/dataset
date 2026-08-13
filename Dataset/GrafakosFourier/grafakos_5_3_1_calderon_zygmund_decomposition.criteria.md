# Criteria: grafakos_5_3_1_calderon_zygmund_decomposition

**Statement:** [grafakos_5_3_1_calderon_zygmund_decomposition.md](grafakos_5_3_1_calderon_zygmund_decomposition.md) · **Lean:** [grafakos_5_3_1_calderon_zygmund_decomposition.lean](grafakos_5_3_1_calderon_zygmund_decomposition.lean)

## What the theorem says

Given an integrable function $f$ on $\mathbb{R}^n$ and a height $\alpha > 0$, one can split
$f = g + b$ into a "good" part and a "bad" part. The good part is no larger than $f$ in $L^1$ and is
bounded by $2^n\alpha$ everywhere. The bad part breaks into pieces $b_j$, each living inside its own
dyadic cube $Q_j$, the cubes pairwise disjoint. Each piece has integral zero, has $L^1$ norm at most
$2^{n+1}\alpha\lvert Q_j\rvert$, and the cubes together occupy total volume at most
$\alpha^{-1}\|f\|_1$. The value of the theorem is the whole package: a formalization keeping only
some of these claims is a fragment, not the theorem.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The hypotheses are exactly $f \in L^1(\mathbb{R}^n)$, complex-valued, and $\alpha > 0$. | ✅ `hf : MemLp f 1 volume`, `hα : 0 < α`, `f : EuclideanSpace ℝ (Fin n) → ℂ`. |
| 2 | The splitting $f = g + b$. | ✅ `f = g + b` as an equality of functions, holding at every point, not merely almost everywhere. |
| 3 | Both bounds on the good part: $\|g\|_1 \le \|f\|_1$ and $\|g\|_\infty \le 2^n\alpha$. | ✅ `eLpNorm g 1 volume ≤ eLpNorm f 1 volume` and `eLpNorm g ∞ volume ≤ ENNReal.ofReal (2 ^ n * α)`. |
| 4 | The bad part is the sum of the pieces, $b = \sum_j b_j$. | ⚠️ `HasSum bad b`, which is unconditional summation in the function space, i.e. pointwise. This is sound here because the supports are disjoint, so at each point at most one summand is nonzero, but the text means convergence in $L^1$; `Tendsto (fun s ↦ eLpNorm (b - ∑ j ∈ s, bad j) 1 volume) atTop (𝓝 0)` would say that directly. |
| 5 | Each piece is supported in its own dyadic cube, and the cubes are pairwise disjoint. | ✅ `∀ j, Function.support (bad j) ⊆ (Q j).carrier` together with `Pairwise fun i j ↦ Disjoint (Q i).carrier (Q j).carrier`, where `DyadicCube n` has a `scale : ℤ` and an integer `corner`, and `carrier = {x \| ∀ i, (corner i : ℝ) * 2 ^ scale ≤ x i ∧ x i < (corner i + 1 : ℤ) * 2 ^ scale}` — the half-open convention, at every scale. |
| 6 | Each piece has integral zero. | ✅ `∀ j, ∫ x, bad j x = 0`. Because the support sits inside $Q_j$, integrating over $\mathbb{R}^n$ and over $Q_j$ give the same number. |
| 7 | Each piece obeys $\|b_j\|_1 \le 2^{n+1}\alpha\lvert Q_j\rvert$. | ✅ `eLpNorm (bad j) 1 volume ≤ ENNReal.ofReal (2 ^ (n + 1) * α) * volume (Q j).carrier`. |
| 8 | The cubes pack: $\sum_j \lvert Q_j\rvert \le \alpha^{-1}\|f\|_1$. | ✅ `∑' j : J, volume (Q j).carrier ≤ eLpNorm f 1 volume / ENNReal.ofReal α`. |
| 9 | The family of cubes is countable but allowed to be finite or even empty. | ✅ The index is `J : Set ℕ` with `Q : J → DyadicCube n`, so `J` may be empty — which is what happens when $f = 0$ almost everywhere. |
| 10 | The pieces are genuinely integrable, so that "$\int b_j = 0$" carries information. | ⚠️ The statement bounds `eLpNorm (bad j) 1 volume` but never asserts `MemLp (bad j) 1 volume`, and `eLpNorm` alone does not give measurability. Since everything sits inside an `∃`, the ground truth is still provable — the real Calderón–Zygmund pieces are integrable — but adding `MemLp (bad j) 1 volume` (and likewise for `g` and `b`) would make the produced decomposition meaningful rather than merely formal. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Indexing the cubes by all of `ℕ` with a total `Q : ℕ → DyadicCube n` plus pairwise disjointness. | Pairwise disjointness over `ℕ` forces infinitely many *distinct* cubes, and every dyadic carrier has volume $2^{n\cdot\text{scale}} > 0$, so the total volume is strictly positive. The packing bound then cannot hold when $\|f\|_1 = 0$, i.e. for $f = 0$ almost everywhere, and the statement is false for that $f$. The same failure occurs at $n = 0$, where every dyadic carrier is the whole one-point space. An earlier version of this ground truth had exactly this defect. |
| 2 | Using closed cubes, e.g. products of `Set.Icc`, or balls. | Closed cubes of a common generation share faces and so cannot be pairwise disjoint; the half-open convention is what makes dyadic cubes tile and nest. Balls are a different family altogether. |
| 3 | Producing only $f = g + b$ with the two bounds on $g$. | The "good part" fragment. Everything that makes the decomposition useful for singular integrals lives in the description of $b$. |
| 4 | Omitting the cancellation $\int b_j = 0$. | Without it the decomposition is just a truncation. The vanishing mean is exactly what lets a Calderón–Zygmund kernel gain decay off the cube. |
| 5 | Requiring the *closed* support (`tsupport`) to lie in $Q_j$. | The closure of the support of a function living on a half-open cube generally meets the boundary and so is not contained in the half-open cube. The condition would be unsatisfiable for the standard construction. |
| 6 | Writing `∫ x in (Q j).carrier, bad j x = 0` without also requiring the support condition. | Strictly weaker: it says nothing about $b_j$ outside its cube, so the pieces need not be localized at all. |
| 7 | Adding hypotheses such as $f \ge 0$, or $f \in L^1 \cap L^\infty$. | Not in the text, and $f \ge 0$ removes the bookkeeping with $\lvert f\rvert$ that the complex-valued case needs. |
| 8 | Splitting the conclusion into several independent existentials, one for $g$ and $b$, another for the cubes, another for the pieces. | Loses the coupling: the cubes, the pieces and the splitting are produced together by one construction, and the estimates relate them to each other. |

## Notes on the ground truth

- Everything is packaged into a single existential `∃ g b, ∃ (J : Set ℕ) (Q : J → DyadicCube n)
  (bad : J → …), …`, which is the right shape.
- `DyadicCube` is a small structure in `Defs.lean` carrying `scale : ℤ` and `corner : Fin n → ℤ`. The
  `2 ^ scale` is an integer power, so arbitrarily fine and arbitrarily coarse generations are
  available. Mathlib has no dyadic-cube type here, so this is not a redundant wrapper.
- `f = g + b` is stated as equality of functions everywhere. That is the strongest reading and is
  correct for the standard construction; an almost-everywhere version would also be acceptable.
- The index set was changed from `ℕ` to a subset `J : Set ℕ` to repair the degenerate case described
  in mistake 1.
